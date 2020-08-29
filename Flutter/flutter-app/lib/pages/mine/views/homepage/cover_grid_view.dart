import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';
import '../../../../public/public.dart';

typedef _kCoverGridUpdateBlock = void Function(List coverList);

class CoverGridView extends StatefulWidget {
  double gridWidth = 0; //控件宽度
  List coverList; //展示列表，图片url
  int maxColumn = 4; //每行显示数 用于计算间距
  double itemSpace = 8; //间距，默认12
  double bottomSpace = 10; //底部间隙
  int imageCount = 9; //最多可以选择图片数
  bool coverAddition = false; //添加封面
  _kCoverGridUpdateBlock updateHandle; //图片列表编辑通知

  CoverGridView({
    Key key,
    this.coverList,
    this.gridWidth = 0,
    this.maxColumn = 4,
    this.itemSpace = 12,
    this.bottomSpace = 10,
    this.imageCount = 9,
    this.coverAddition = false,
    this.updateHandle,
  }) : super(key: key);

  @override
  _CoverGridViewState createState() => _CoverGridViewState();
}

class _CoverGridViewState extends State<CoverGridView> {
  double _itemWH = 0;
  List _coverList = [];
  var _movingValue; // 记录正在移动的数据

  @override
  void initState() {
    if (this.widget.coverList == null) {
      setState(() {
        this.widget.coverList = [];
      });
    }

    super.initState();

    if (this.widget.gridWidth == 0) {
      setState(() {
        this.widget.gridWidth = MediaQuery.of(context).size.width;
      });
    }

    setState(() {
      _coverList.addAll(this.widget.coverList);
    });
  }

  //添加按钮
  Widget _coverAdditionButton() {
    return this._coverFrame(
      child: FlatButton(
        onPressed: () {
          this._selectImages();
        },
        child: Center(
          child: Image.asset(
            "images/certification_add@3x.png",
            width: 24,
            height: 24,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    );
  }

  //封面框架控件
  Widget _coverFrame({Widget child}) {
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

  //加载封面列表
  List<Widget> _loadCoverList() {
    List<Widget> _list = [];
    _coverList.forEach((element) {
      _list.add(
        this._draggableItem(element),
      );
    });

    if (_coverList.length < this.widget.imageCount &&
        this.widget.coverAddition == true) {
      _list.add(this._coverAdditionButton());
    }

    return _list;
  }

  // 基础展示的item 此处设置width,height对GridView 无效，主要是偷懒给feedback用
  Widget _baseMoveItem(element) {
    if (element == _movingValue) {
      return Container();
    }

    return this._coverFrame(
      child: Stack(
        children: <Widget>[
          ClipRRect(
            child: (element is String)
                ? CachedNetworkImage(
                    placeholder: (context, url) {
                      return Image.asset(
                        "images/placeholder_mini@3x.png",
                        width: _itemWH,
                        height: _itemWH,
                        fit: BoxFit.cover,
                      );
                    },
                    imageUrl: element != null ? "$element" : "",
                    width: _itemWH,
                    height: _itemWH,
                    fit: BoxFit.cover,
                  )
                : Image.memory(
                    element,
                    width: _itemWH,
                    height: _itemWH,
                    fit: BoxFit.cover,
                  ),
            borderRadius: BorderRadius.circular(3),
          ),
          this.widget.coverAddition == true
              ? Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 17,
                    height: 17,
                    child: FlatButton(
                      padding: EdgeInsets.zero,
                      child: Image.asset(
                        "images/certification_close@3x.png",
                        width: 17,
                        height: 17,
                      ),
                      onPressed: () {
                        setState(() {
                          _coverList.remove(element);
                          if (this.widget.updateHandle != null) {
                            this.widget.updateHandle(_coverList);
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

  // 重新排序
  void _exchangeMoveItem(moveData, toData, onAccept) {
    setState(() {
      var toIndex = _coverList.indexOf(toData);

      _coverList.remove(moveData);
      _coverList.insert(toIndex, moveData);

      if (this.widget.updateHandle != null) {
        this.widget.updateHandle(_coverList);
      }

      if (onAccept) {
        _movingValue = null;
      }
    });
  }

  // 生成可拖动的item
  Widget _draggableItem(element) {
    if (this.widget.coverAddition == true) {
      return Draggable(
        data: element,
        child: DragTarget(
          builder: (context, candidateData, rejectedData) {
            return this._baseMoveItem(element);
          },
          onWillAccept: (moveData) {
            print('=== onWillAccept ===');

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

  //添加图片
  void _selectImages() {
    MultiImagePicker.pickImages(
      maxImages: this.widget.imageCount - _coverList.length,
      enableCamera: true,
    ).then((assets) {
      if (assets.length > 0) {
        Future.delayed(Duration(milliseconds: 0), () {
          XsProgressHud.show(context);
        });

        List _tempCoverList = _coverList;
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
                _coverList = _tempCoverList;
                Future.delayed(Duration(milliseconds: 100), () {
                  XsProgressHud.hide();
                });

                if (this.widget.updateHandle != null) {
                  this.widget.updateHandle(_coverList);
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

  @override
  Widget build(BuildContext context) {
    if (_itemWH == 0) {
      _itemWH = (this.widget.gridWidth -
              (this.widget.itemSpace * (this.widget.maxColumn - 1))) /
          this.widget.maxColumn;
    }

    return this.widget.coverAddition == false
        ? Container(
            padding: EdgeInsets.fromLTRB(
              0,
              0,
              0,
              this.widget.coverList.length > 0 ? this.widget.bottomSpace : 0,
            ),
            width: this.widget.gridWidth,
            child: Wrap(
              spacing: this.widget.itemSpace,
              runSpacing: this.widget.itemSpace,
              children: this._loadCoverList(),
            ),
          )
        : Container(
            padding: EdgeInsets.fromLTRB(
              0,
              0,
              0,
              this.widget.bottomSpace,
            ),
            width: this.widget.gridWidth,
            child: Wrap(
              spacing: this.widget.itemSpace,
              runSpacing: this.widget.itemSpace,
              alignment: WrapAlignment.start,
              children: this._loadCoverList(),
            ),
          );
  }
}
