import 'dart:io';

import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/material.dart';
import 'package:image_pickers/Media.dart';
import 'package:image_pickers/UIConfig.dart';
import 'package:image_pickers/image_pickers.dart';
import '../../public/public.dart';

class InputAvatarPage extends StatefulWidget {
  Map infoPackage = {};
  InputAvatarPage({Key key, this.infoPackage}) : super(key: key);

  @override
  _InputAvatarPageState createState() => _InputAvatarPageState();
}

class _InputAvatarPageState extends State<InputAvatarPage> {
  bool _nextAviable = false; //是否填写完毕
  List<String> _lebelList = [
    "一些约会",
    "情侣关系",
    "一段认真的感情",
    "认识有趣的人",
    "朋友",
    "婚姻",
  ];
  List<String> _selectLebels = [];
  var _avatar;

  //检测输入数据
  void _checkInfoInput() {
    if (_avatar != null && _selectLebels.length > 0) {
      setState(() {
        _nextAviable = true;
      });
    } else {
      setState(() {
        _nextAviable = false;
      });
    }
  }

  //完成
  void _onConfirm() {
    Navigator.of(context).popUntil(
      ModalRoute.withName("/"),
    );
    DartNotificationCenter.post(
      channel: kAccountHandleNotification,
      options: {
        "type": 0,
      },
    );
  }

  //选择图片
  void _selectAvatarImage() {
    ImagePickers.pickerPaths(
      selectCount: 1,
      showCamera: true,
      compressSize: 500,
      uiConfig: UIConfig(
        uiThemeColor: Colors.black,
      ),
    ).then((list) {
      if (list.length > 0) {
        Media _media = list.first;
        setState(() {
          _avatar = _media.path;
        });
      }
    }).catchError((error) {
      showToast(error.toString(), context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      appBar: customAppBar(),
      body: ListView(
        padding: EdgeInsets.fromLTRB(23, 15.5, 23, 66.5),
        children: <Widget>[
          Text(
            "上传本人真实照片",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: rgba(51, 51, 51, 1),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20.5,
          ),
          //选择、展示头像区域
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              //选择头像、展示头像
              FlatButton(
                padding: EdgeInsets.all(0.4),
                onPressed: _avatar == null
                    ? () {
                        this._selectAvatarImage();
                      }
                    : null,
                child: Stack(
                  children: <Widget>[
                    //头像
                    ClipRRect(
                      child: _avatar == null
                          ? Image.asset(
                              "images/avatar_select@3x.png",
                              width: 102,
                              height: 102,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              File(_avatar),
                              width: 102,
                              height: 102,
                              fit: BoxFit.cover,
                            ),
                      borderRadius: BorderRadius.circular(102 / 2),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: _avatar == null
                          ? Container()
                          : Container(
                              //再次选择按钮
                              width: 33,
                              height: 33,
                              child: FlatButton(
                                padding: EdgeInsets.all(1),
                                onPressed: () {
                                  this._selectAvatarImage();
                                },
                                child: Image.asset(
                                  "images/tianjiazhaopian@3x.png",
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(33 / 2),
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(102 / 2),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 17,
          ),
          //提醒
          Container(
            padding: EdgeInsets.fromLTRB(32, 0, 32, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 15.5,
                  height: 15.5,
                  margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
                  child: Image.asset(
                    "images/tishi@3x.png",
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    "温馨提醒：尊敬的用户，您上传的头像需遵守相关法律法规和社区规则，请严格遵守相关规定，以免违规。",
                    style: TextStyle(
                      fontSize: 12,
                      color: rgba(51, 51, 51, 1),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 45,
          ),
          Text(
            "我期望",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: rgba(51, 51, 51, 1),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 9.5,
          ),
          //标签
          Wrap(
            spacing: 14.5,
            runSpacing: 15,
            children: _lebelList.map((label) {
              bool _selected = false;
              if (_selectLebels.indexOf(label) >= 0) {
                _selected = true;
              }

              return Container(
                height: 26,
                child: ChoiceChip(
                  label: Text(
                    "$label",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: _selected
                          ? rgba(255, 45, 85, 1)
                          : rgba(153, 153, 153, 1),
                      fontSize: 14,
                    ),
                  ),
                  selected: _selected,
                  backgroundColor: rgba(239, 240, 245, 1),
                  selectedColor: rgba(254, 247, 248, 1),
                  padding: EdgeInsets.zero,
                  labelPadding: EdgeInsets.fromLTRB(12, -4.4, 12, 0),
                  pressElevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26 / 2),
                    side: BorderSide(
                      color: _selected
                          ? rgba(255, 88, 120, 1)
                          : rgba(239, 240, 245, 1),
                      width: 1.5,
                    ),
                  ),
                  onSelected: (index) {
                    bool _isExist = false;
                    _selectLebels.forEach((element) {
                      if (element == label) {
                        _isExist = true;
                      }
                    });

                    setState(() {
                      if (_isExist == false) {
                        _selectLebels.add(label);
                      } else {
                        _selectLebels.remove(label);
                      }

                      this._checkInfoInput();
                    });
                  },
                ),
              );
            }).toList(),
          ),
          SizedBox(
            height: 52,
          ),
          //完成
          Container(
            height: 44,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: _nextAviable == false ? rgba(216, 216, 216, 1) : null,
              borderRadius: BorderRadius.circular(44 / 2),
              gradient: _nextAviable == false
                  ? null
                  : LinearGradient(
                      colors: [
                        rgba(255, 44, 96, 1),
                        rgba(255, 114, 81, 1),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
            ),
            child: FlatButton(
              padding: EdgeInsets.zero,
              onPressed: _nextAviable == false
                  ? null
                  : () {
                      this._onConfirm();
                    },
              child: Text(
                "完成",
                style: TextStyle(
                  fontSize: 16,
                  color: rgba(255, 255, 255, 1),
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(44 / 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
