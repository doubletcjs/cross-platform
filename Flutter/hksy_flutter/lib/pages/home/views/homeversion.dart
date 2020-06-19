import 'dart:io';

import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hksy_flutter/function/generaldialog.dart';
import 'package:hksy_flutter/public/public.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeVersion extends StatefulWidget {
  HomeVersion({Key key}) : super(key: key);

  @override
  _HomeVersionState createState() => _HomeVersionState();

  show(BuildContext context, Map info) {
    GeneralDialog().show(
      context,
      backgroundPadding: EdgeInsets.fromLTRB(67.5, 0, 67.5, 0),
      backgroundAlignment: Alignment.center,
      borderRadius: BorderRadius.circular(7.5),
      containerContent: this,
      barrierDismissible: false,
    );

    Future.delayed(Duration(milliseconds: 400), () {
      DartNotificationCenter.post(channel: "kHomeVersionInfo", options: info);
    });
  }
}

class _HomeVersionState extends State<HomeVersion> {
  List _list = [];
  Map _info = {};
  String _downloadUrl = "";
  bool _showClose = true;

  void _closeAlert(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _openBrower() {
    String _url = _downloadUrl;
    Navigator.of(context).pop();
    canLaunch(_url).then((value) {
      if (value) {
        launch(_url).then((value) {});
      }
    });
  }

  @override
  void initState() {
    super.initState();

    DartNotificationCenter.subscribe(
        channel: "kHomeVersionInfo",
        observer: this,
        onNotification: (options) {
          setState(() {
            _info = options;
            if (_info.length == 0) {
              Navigator.of(context).pop();
            } else {
              var version = "";
              if (Platform.isIOS) {
                version = _info["ios_version"];
                _downloadUrl = _info["ios_download"];
              } else if (Platform.isAndroid) {
                version = _info["android_version"];
                _downloadUrl = _info["android_download"];
              }
              _list = "${_info["readme"]}".split(";");

              PackageInfo.fromPlatform().then((info) {
                //当前版本
                String currentVersion = info.version;
                if (currentVersion == version) {
                  Navigator.of(context).pop();
                }
              });
            }
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return _list.length == 0
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[],
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Image.asset(
                    "images/app_update@3x.png",
                  ),
                  _showClose == false
                      ? Container()
                      : Positioned(
                          top: 7.5,
                          right: 7.5,
                          child: InkWell(
                            child: Image.asset(
                              "images/ico_version_close@3x.png",
                              width: 20,
                              height: 20,
                            ),
                            onTap: () {
                              this._closeAlert(context);
                            },
                          ),
                        ),
                ],
              ),
              Container(
                padding: EdgeInsets.fromLTRB(21.5, 0, 21.5, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 2,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        "2.0版本系统升级",
                        style: TextStyle(
                          fontSize: 15,
                          color: rgba(21, 25, 54, 1),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _list.map(
                        (item) {
                          return Text(
                            "·" + item,
                            style: TextStyle(
                              fontSize: 13,
                              color: rgba(145, 152, 173, 1),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                    SizedBox(
                      height: 28,
                    ),
                    FlatButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        this._openBrower();
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.5),
                      ),
                      child: Container(
                        height: 34,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: rgba(23, 96, 255, 1),
                          borderRadius: BorderRadius.circular(7.5),
                        ),
                        child: Text(
                          "升级新版本",
                          style: TextStyle(
                            fontSize: 13,
                            color: rgba(255, 255, 255, 1),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                  ],
                ),
              ),
            ],
          );
  }
}
