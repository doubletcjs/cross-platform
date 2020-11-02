import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:time_flies/public/public.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';

typedef _kGridUpdateBlock = void Function(List gridList);

// ignore: must_be_immutable
class ImageGridView extends StatefulWidget {
  double gridWidth = 0; //控件宽度
  List gridList; //展示列表，图片url
  int maxColumn = 4; //每行显示数 用于计算间距
  double itemSpace = 8; //间距，默认12
  int imageCount = 9; //最多可以选择图片数
  bool gridAddition = false; //添加封面
  _kGridUpdateBlock updateHandle; //图片列表编辑通知

  ImageGridView({
    Key key,
    this.gridList,
    this.gridWidth = 0,
    this.maxColumn = 4,
    this.itemSpace = 8,
    this.imageCount = 9,
    this.gridAddition = false,
    this.updateHandle,
  }) : super(key: key);

  @override
  _ImageGridViewState createState() => _ImageGridViewState();
}

class _ImageGridViewState extends State<ImageGridView> {
  double _itemWH = 0;
  List _gridList = [];
  var _movingValue; // 记录正在移动的数据

  //添加图片
  void _selectImages() {
    FocusScope.of(context).requestFocus(FocusNode());
    MultiImagePicker.pickImages(
      maxImages: this.widget.imageCount - _gridList.length,
      enableCamera: true,
    ).then((assets) {
      if (assets.length > 0) {
        Future.delayed(Duration(milliseconds: 0), () {
          XsProgressHud.show(context);
        });

        List _tempCoverList = _gridList;
        var index = 0;
        assets.forEach((element) {
          //w / h = 750 / x
          double originalHeight = element.originalHeight.toDouble();
          double originalWidth = element.originalWidth.toDouble();
          int height = (750.0 * originalHeight) ~/ originalWidth;

          element
              .getThumbByteData(
            750,
            height,
            quality: 80,
          )
              .then((byteData) {
            List<int> _imageData = byteData.buffer.asUint8List();
            _tempCoverList.add(_imageData);
            if (index == assets.length - 1) {
              setState(() {
                _gridList = _tempCoverList;
                Future.delayed(Duration(milliseconds: 100), () {
                  XsProgressHud.hide();
                });

                if (this.widget.updateHandle != null) {
                  this.widget.updateHandle(_gridList);
                }
              });
            } else {
              index += 1;
            }
          });
        });
      }
    }).catchError((error) {});
  }

  //封面框架控件
  Widget _gridFrame({Widget child}) {
    return Container(
      width: _itemWH,
      height: _itemWH,
      decoration: BoxDecoration(
        color: rgba(246, 246, 246, 1),
        borderRadius: BorderRadius.circular(3),
      ),
      child: child == null ? Container() : child,
    );
  }

  //添加按钮
  Widget _gridAdditionButton() {
    return this._gridFrame(
      child: FlatButton(
        onPressed: () {
          this._selectImages();
        },
        child: Center(
          child: Image.asset(
            "images/grid_image_add@3x.png",
            width: 48,
            height: 48,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    );
  }

  //加载封面列表
  List<Widget> _loadGridList() {
    List<Widget> _list = [];
    _gridList.forEach((element) {
      _list.add(
        this._draggableItem(element),
      );
    });

    if (_gridList.length < this.widget.imageCount &&
        this.widget.gridAddition == true) {
      _list.add(this._gridAdditionButton());
    }

    return _list;
  }

  // 生成可拖动的item
  Widget _draggableItem(element) {
    if (this.widget.gridAddition == true) {
      return Draggable(
        data: element,
        child: DragTarget(
          builder: (context, candidateData, rejectedData) {
            return this._baseMoveItem(element);
          },
          onWillAccept: (moveData) {
            print('=== onWillAccept ===');
            FocusScope.of(context).requestFocus(FocusNode());

            var accept = moveData != null;
            if (accept) {
              this._exchangeMoveItem(moveData, element, false);
            }
            return accept;
          },
          onAccept: (moveData) {
            print('=== onAccept: ===');
            this._exchangeMoveItem(moveData, element, true);
          },
          onLeave: (moveData) {
            print('=== onLeave ===');
          },
        ),
        feedback: this._baseMoveItem(element),
        onDraggableCanceled: (Velocity velocity, Offset offset) {
          print('=== onDraggableCanceled ===');
          setState(() {
            _movingValue = null; //清空标记进行重绘
          });
        },
        onDragCompleted: () {
          print('=== onDragCompleted ===');
        },
      );
    } else {
      return this._baseMoveItem(element);
    }
  }

  // 重新排序
  void _exchangeMoveItem(moveData, toData, onAccept) {
    setState(() {
      var toIndex = _gridList.indexOf(toData);

      _gridList.remove(moveData);
      _gridList.insert(toIndex, moveData);

      if (this.widget.updateHandle != null) {
        this.widget.updateHandle(_gridList);
      }

      if (onAccept) {
        _movingValue = null;
      }
    });
  }

  // 基础展示的item 此处设置width,height对GridView 无效，主要是偷懒给feedback用
  Widget _baseMoveItem(element) {
    if (element == _movingValue) {
      return Container();
    }

    return this._gridFrame(
      child: Stack(
        children: <Widget>[
          (element is String)
              ? networkImage(
                  "$element",
                  Size(_itemWH, _itemWH),
                  BorderRadius.circular(3),
                )
              : ClipRRect(
                  child: Image.memory(
                    element,
                    width: _itemWH,
                    height: _itemWH,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(3),
                ),
          this.widget.gridAddition == true
              ? Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 17,
                    height: 17,
                    child: FlatButton(
                      padding: EdgeInsets.zero,
                      child: Image.asset(
                        "images/cover_grid_delete@3x.png",
                        width: 17,
                        height: 17,
                      ),
                      onPressed: () {
                        setState(() {
                          _gridList.remove(element);
                          if (this.widget.updateHandle != null) {
                            this.widget.updateHandle(_gridList);
                          }
                        });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17 / 2),
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  @override
  void initState() {
    if (this.widget.gridList == null) {
      setState(() {
        this.widget.gridList = [];
      });
    }

    super.initState();

    if (this.widget.gridWidth == 0) {
      setState(() {
        this.widget.gridWidth = MediaQuery.of(context).size.width;
      });
    }

    setState(() {
      _gridList.addAll(this.widget.gridList);
    });
  }

  Widget build(BuildContext context) {
    if (_itemWH == 0) {
      _itemWH = (this.widget.gridWidth -
              (this.widget.itemSpace * (this.widget.maxColumn - 1))) /
          this.widget.maxColumn;
    }

    return GridView.count(
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      crossAxisCount: this.widget.maxColumn,
      crossAxisSpacing: this.widget.itemSpace,
      mainAxisSpacing: this.widget.itemSpace,
      children: this._loadGridList(),
    );
  }
}
