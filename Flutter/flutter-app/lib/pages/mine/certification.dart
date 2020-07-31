import 'dart:io';

import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';
import '../../public/public.dart';

class CertificationPage extends StatefulWidget {
  CertificationPage({Key key}) : super(key: key);

  @override
  _CertificationPageState createState() => _CertificationPageState();
}

class _CertificationPageState extends State<CertificationPage> {
  var _avatar;

  //删除视频
  void _deleteAction() {
    setState(() {
      _avatar = null;
    });
  }

  //选择图片
  void _selectAction() {
    MultiImagePicker.pickImages(
      maxImages: 1,
      enableCamera: true,
    ).then((assets) {
      if (assets.length > 0) {
        Future.delayed(Duration(milliseconds: 0), () {
          XsProgressHud.show(context);
        });

        Asset _asset = assets.first;
        _asset.getByteData().then((byteData) {
          List<int> _imageData = byteData.buffer.asUint8List();
          setState(() {
            _avatar = _imageData;
            Future.delayed(Duration(milliseconds: 100), () {
              XsProgressHud.hide();
            });
          });
        });
      }
    }).catchError((error) {});
  }

  //播放
  void _playAction() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "头像认证",
        elevation: 0.5,
      ),
      backgroundColor: rgba(245, 245, 245, 1),
      body: Column(
        children: <Widget>[
          Container(
            color: kMainBackgroundColor,
            padding: EdgeInsets.fromLTRB(8.5, 0, 8.5, 10.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 97,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        bottom: 0,
                        child: //选择头像
                            Container(
                          width: 87,
                          height: 87,
                          decoration: BoxDecoration(
                            color: rgba(246, 246, 246, 1),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          //添加按钮
                          child: _avatar == null
                              ? FlatButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    this._selectAction();
                                  },
                                  child: Image.asset(
                                    "images/certification_add@3x.png",
                                    width: 24,
                                    height: 24,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                )
                              : Stack(
                                  children: <Widget>[
                                    ClipRRect(
                                      child: Image.memory(
                                        _avatar,
                                        fit: BoxFit.cover,
                                        width: 87,
                                        height: 87,
                                      ),
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    //播放按钮
                                    Center(
                                      child: Container(
                                        width: 31.5,
                                        height: 31.5,
                                        child: FlatButton(
                                          padding: EdgeInsets.zero,
                                          child: Image.asset(
                                            "images/certification_play@3x.png",
                                            width: 31.5,
                                            height: 31.5,
                                          ),
                                          onPressed: () {
                                            this._playAction();
                                          },
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(31.5 / 2),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                      _avatar == null
                          ? Container()
                          : //关闭按钮
                          Positioned(
                              top: 3,
                              left: 87 - (17 / 2),
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
                                    this._deleteAction();
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
                SizedBox(
                  height: 10,
                ),
                //温馨提醒
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(10.5, 10.5, 10.5, 10.5),
                  decoration: BoxDecoration(
                    color: rgba(243, 243, 243, 1),
                    borderRadius: BorderRadius.circular(3),
                  ),
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
                          "温馨提醒：尊敬的用户，Yue Mie是一个真实的交友平台，杜绝虚假请自拍正脸视频证明照片是本人头像和视频一直才能通过审核",
                          style: TextStyle(
                            fontSize: 12,
                            color: rgba(51, 51, 51, 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          //提交
          Container(
            margin: EdgeInsets.fromLTRB(23, 29.5, 23, 0),
            height: 44,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: _avatar == null ? rgba(216, 216, 216, 1) : null,
              borderRadius: BorderRadius.circular(44 / 2),
              gradient: _avatar == null
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
              onPressed: _avatar == null ? null : () {},
              child: Text(
                "提交",
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
          SizedBox(
            height: 12,
          ),
          //认证人数
          Text(
            "已有2,3874,59人通过认证，认证后尊享特权功能",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: rgba(153, 153, 153, 1),
            ),
          ),
        ],
      ),
    );
  }
}
