import 'dart:io';

import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_compress/video_compress.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';
import '../function/base_video_player.dart';
import '../../public/public.dart';
import '../../public/networking.dart';
import '../account/api/account_api.dart';

class CertificationPage extends StatefulWidget {
  CertificationPage({Key key}) : super(key: key);

  @override
  _CertificationPageState createState() => _CertificationPageState();
}

class _CertificationPageState extends State<CertificationPage> {
  var _image;
  String _videoPath;

  //删除视频
  void _deleteAction() {
    setState(() {
      _image = null;
      _videoPath = null;
    });
  }

  //选择视频
  void _selectAction() {
    ImagePicker()
        .getVideo(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.rear,
      maxDuration: Duration(seconds: 8),
    )
        .then((file) {
      if (file != null) {
        Future.delayed(Duration(milliseconds: 0), () {
          XsProgressHud.show(context);
        });

        VideoCompress.compressVideo(
          file.path,
          deleteOrigin: true,
          quality: VideoQuality.LowQuality,
        ).then((mediaInfo) {
          PickedFile _file = PickedFile(mediaInfo.path);
          _file.readAsBytes().then((videoValue) {
            setState(() {
              _videoPath = _file.path;

              Future.delayed(Duration(milliseconds: 100), () {
                XsProgressHud.hide();
              });
            });
          });
        });

        VideoCompress.getByteThumbnail(
          file.path,
          quality: 80,
        ).then((imageValue) {
          List<int> _imageData = imageValue;
          setState(() {
            _image = _imageData;
            _videoPath = file.path;
          });
        });
      }
    }).catchError((error) {
      showToast("$error", context);
    });
  }

  //播放
  void _playAction() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return BaseVideoPlayer(
          videoPath: _videoPath,
        );
      }),
    );
  }

  //提交
  void _onConfirm() {
    if (_account["audit_status"] == 2) {
      setState(() {
        _image = null;
        _videoPath = null;
        _account["audit_status"] = 0;
      });
    } else {
      //上传视频
      XsProgressHud.show(context);
      Networking.uploadFiles("/api/v1/upload", [
        File(_videoPath),
      ], (data, msg) {
        if (data != null) {
          List urls = data;
          if (urls.length > 0) {
            AccountApi.authenticate(urls.first, (data, msg) {
              XsProgressHud.hide();
              if (data != null) {
                showToast("认证提交成功!", context);
                Future.delayed(Duration(milliseconds: 800), () {
                  Navigator.of(context).pop();
                });
              } else {
                showToast("$msg", context);
              }
            });
          } else {
            XsProgressHud.hide();
            showToast("视频文件上传失败！请稍后重试。", context);
          }
        } else {
          XsProgressHud.hide();
          showToast("视频文件上传失败！请稍后重试。", context);
        }
      });
    }
  }

  Map _account;
  //获取用户信息
  void _refreshAccount() {
    setState(() {
      _account = currentAccount;
    });
  }

  @override
  void initState() {
    super.initState();

    //audit_status	0:未认证 1：审核中 2：认证失败 3：认证成功
    DartNotificationCenter.subscribe(
      channel: kAccountHandleNotification,
      observer: this,
      onNotification: (option) {
        //type 0 登录 1 请求账号信息刷新 2 登出 3 请求账号信息结束，刷新本地记录用户信息
        if (option["type"] == 3) {
          this._refreshAccount();
        }
      },
    );

    setState(() {
      /*
        audit_status	integer 认证状态 0:未认证 1：审核中 2：认证失败 3：认证成功 
        video_url	string 个人认证视频 
        audit_message	string 个人认证视频返回信息 
        video_photo	string 个人认证视频预览图
      */
    });
    _account = currentAccount;
    if (_account["audit_status"] != 0) {
      _image = _account["video_photo"];
      _videoPath = _account["video_url"];
    }
  }

  @override
  void dispose() {
    super.dispose();

    DartNotificationCenter.unsubscribe(observer: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "视频认证",
        elevation: 0.5,
      ),
      backgroundColor: rgba(245, 245, 245, 1),
      body: _account == null
          ? Container()
          : Column(
              children: <Widget>[
                Container(
                  color: kMainBackgroundColor,
                  padding: EdgeInsets.fromLTRB(8.5, 0, 8.5, 10.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                            child: Stack(
                              children: <Widget>[
                                //选择头像
                                Container(
                                  width: 87,
                                  height: 87,
                                  decoration: BoxDecoration(
                                    color: rgba(246, 246, 246, 1),
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  //添加按钮
                                  child: _image == null
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
                                            borderRadius:
                                                BorderRadius.circular(3),
                                          ),
                                        )
                                      : Stack(
                                          children: <Widget>[
                                            ClipRRect(
                                              child: (_image is String)
                                                  ? Image.network(
                                                      _image,
                                                      fit: BoxFit.cover,
                                                      width: 87,
                                                      height: 87,
                                                    )
                                                  : Image.memory(
                                                      _image,
                                                      fit: BoxFit.cover,
                                                      width: 87,
                                                      height: 87,
                                                    ),
                                              borderRadius:
                                                  BorderRadius.circular(3),
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
                                                        BorderRadius.circular(
                                                            31.5 / 2),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                ),
                                (_image == null ||
                                        _account["audit_status"] != 0)
                                    ? Container()
                                    : //关闭按钮
                                    Positioned(
                                        top: 0,
                                        right: 0,
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
                                              borderRadius:
                                                  BorderRadius.circular(17 / 2),
                                            ),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 14.5,
                          ),
                          Expanded(
                            child: Text(
                              _account["audit_status"] == 1
                                  ? "认证中，请等待！"
                                  : _account["audit_status"] == 2
                                      ? "${_account['audit_message']}"
                                      : _account["audit_status"] == 3
                                          ? "认证成功！"
                                          : "",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                color: _account["audit_status"] == 3
                                    ? rgba(0, 177, 95, 1)
                                    : rgba(255, 45, 85, 1),
                              ),
                            ),
                          ), // audit_status	0:未认证 1：审核中 2：认证失败 3：认证成功
                        ],
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
                                "温馨提醒：尊敬的用户，请杜绝虚假信息，请自拍正脸视频证明照片是本人头像和视频一直才能通过审核",
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
                _account["audit_status"] != 3
                    ? Container(
                        margin: EdgeInsets.fromLTRB(23, 29.5, 23, 0),
                        height: 44,
                        width: MediaQuery.of(context).size.width,
                        decoration: _account["audit_status"] == 1
                            ? BoxDecoration(
                                color: rgba(216, 216, 216, 1),
                                borderRadius: BorderRadius.circular(44 / 2),
                              )
                            : BoxDecoration(
                                color: _image == null
                                    ? rgba(216, 216, 216, 1)
                                    : null,
                                borderRadius: BorderRadius.circular(44 / 2),
                                gradient: _image == null
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
                          onPressed: _account["audit_status"] == 1
                              ? null
                              : (_image == null
                                  ? null
                                  : () {
                                      this._onConfirm();
                                    }),
                          child: Text(
                            _account["audit_status"] == 1
                                ? "认证中"
                                : _account["audit_status"] == 2 ? "重新提交" : "提交",
                            style: TextStyle(
                              fontSize: 16,
                              color: rgba(255, 255, 255, 1),
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(44 / 2),
                          ),
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: _account["audit_status"] != 3 ? 12 : 15.5,
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
