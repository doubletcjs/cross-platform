import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_pickers/Media.dart';
import 'package:image_pickers/UIConfig.dart';
import 'package:image_pickers/image_pickers.dart';
import '../../../../public/public.dart';

class CoverGridView extends StatefulWidget {
  double gridWidth = 0; //控件宽度
  List coverList; //展示列表，图片url
  int maxColumn = 4; //每行显示数 用于计算间距
  double itemWH = 87; //宽高，默认87
  double bottemSpace = 10; //底部间隙
  int imageCount = 9; //最多可以选择图片数
  bool coverAddition = false; //添加封面

  CoverGridView({
    Key key,
    this.coverList,
    this.gridWidth = 0,
    this.maxColumn = 4,
    this.itemWH = 87,
    this.bottemSpace = 10,
    this.imageCount = 9,
    this.coverAddition = false,
  }) : super(key: key);

  @override
  _CoverGridViewState createState() => _CoverGridViewState();
}

class _CoverGridViewState extends State<CoverGridView> {
  double _space = 0;
  List _coverList = [];

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
      width: this.widget.itemWH,
      height: this.widget.itemWH,
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
        this._coverFrame(
          child: Stack(
            children: <Widget>[
              ClipRRect(
                child: Image.file(
                  File(element),
                  width: this.widget.itemWH,
                  height: this.widget.itemWH,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(3),
              ),
              Positioned(
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
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17 / 2),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });

    if (_coverList.length < this.widget.imageCount) {
      _list.add(this._coverAdditionButton());
    }

    return _list;
  }

  //添加图片
  void _selectImages() {
    ImagePickers.pickerPaths(
      selectCount: this.widget.imageCount - _coverList.length,
      showCamera: true,
      compressSize: 800,
      uiConfig: UIConfig(
        uiThemeColor: Colors.black,
      ),
    ).then((list) {
      List _tempCoverList = _coverList;
      list.forEach((element) {
        _tempCoverList.add(element.path);
      });

      setState(() {
        _coverList = _tempCoverList;
      });
    }).catchError((error) {
      showToast(error.toString(), context);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_space == 0) {
      _space = (this.widget.gridWidth -
              (this.widget.itemWH * this.widget.maxColumn)) /
          (this.widget.maxColumn - 1);
    }

    return this.widget.coverAddition == false
        ? Container(
            padding: EdgeInsets.fromLTRB(
              0,
              0,
              0,
              this.widget.coverList.length > 0 ? this.widget.bottemSpace : 0,
            ),
            width: this.widget.gridWidth,
            child: Wrap(
              spacing: _space,
              runSpacing: _space,
              children: this.widget.coverList.map((cover) {
                return this._coverFrame();
              }).toList(),
            ),
          )
        : Container(
            padding: EdgeInsets.fromLTRB(
              0,
              0,
              0,
              this.widget.bottemSpace,
            ),
            width: this.widget.gridWidth,
            child: Wrap(
              spacing: _space,
              runSpacing: _space,
              alignment: WrapAlignment.start,
              children: this._loadCoverList(),
            ),
          );
  }
}
