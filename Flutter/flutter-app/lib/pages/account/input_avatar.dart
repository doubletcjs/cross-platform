import 'dart:convert';

import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';
import '../../public/networking.dart';
import '../../public/public.dart';
import 'api/account_api.dart';

class InputAvatarPage extends StatefulWidget {
  InputAvatarPage({Key key}) : super(key: key);

  @override
  _InputAvatarPageState createState() => _InputAvatarPageState();
}

class _InputAvatarPageState extends State<InputAvatarPage> {
  bool _viableNext = false; //是否填写完毕
  List<String> _labelList = [
    "一些约会",
    "情侣关系",
    "一段认真的感情",
    "认识有趣的人",
    "朋友",
    "婚姻",
  ];
  List<String> _selectLabels = [];
  var _avatar;
  var _imageByteData;

  //检测输入数据
  void _checkInfoInput() {
    if (_avatar != null && _selectLabels.length > 0) {
      setState(() {
        _viableNext = true;
      });
    } else {
      setState(() {
        _viableNext = false;
      });
    }
  }

  //完成
  void _onConfirm() {
    //注册第三步
    void _register(urls) {
      var params = {
        "avatar": urls[0],
        "interest": JsonDecoder().convert(JsonEncoder().convert(_selectLabels)),
      };

      AccountApi.editProfile(params, (data, msg) {
        if (data != null) {
          XsProgressHud.hide();
          Future.delayed(Duration(milliseconds: 1000), () {
            //回到首页
            DartNotificationCenter.post(
              channel: kAccountHandleNotification,
              options: {
                "type": 0,
              },
            );

            Navigator.of(context)
                .pushNamedAndRemoveUntil("/", (route) => false);
          });
        } else {
          XsProgressHud.hide();
          showToast("$msg", context);
        }
      });
    }

    XsProgressHud.show(context);

    //上传头像
    Networking.uploadFiles("/api/v1/upload", [_imageByteData], (data, msg) {
      if (data != null) {
        List urls = data;
        //注册第三步
        if (urls.length > 0) {
          _register(urls);
        }
      } else {
        XsProgressHud.hide();
        showToast("$msg", context);
      }
    });
  }

  //选择图片
  void _selectAvatarImage() {
    MultiImagePicker.pickImages(
      maxImages: 1,
      enableCamera: true,
    ).then((assets) {
      if (assets.length > 0) {
        Future.delayed(Duration(milliseconds: 0), () {
          XsProgressHud.show(context);
        });

        Asset _asset = assets.first;
        _asset.getThumbByteData(750, 750).then((byteData) {
          List<int> _imageData = byteData.buffer.asUint8List();
          setState(() {
            _avatar = _imageData;
            _imageByteData = byteData;
            this._checkInfoInput();
            Future.delayed(Duration(milliseconds: 100), () {
              XsProgressHud.hide();
            });
          });
        });
      }
    }).catchError((error) {});
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
                          : Image.memory(
                              _avatar,
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
            children: _labelList.map((label) {
              bool _selected = false;
              if (_selectLabels.indexOf(label) >= 0) {
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
                    _selectLabels.forEach((element) {
                      if (element == label) {
                        _isExist = true;
                      }
                    });

                    setState(() {
                      if (_isExist == false) {
                        _selectLabels.add(label);
                      } else {
                        _selectLabels.remove(label);
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
              color: _viableNext == false ? rgba(216, 216, 216, 1) : null,
              borderRadius: BorderRadius.circular(44 / 2),
              gradient: _viableNext == false
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
              onPressed: _viableNext == false
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
