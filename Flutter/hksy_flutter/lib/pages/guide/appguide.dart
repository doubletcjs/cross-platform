import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hksy_flutter/public/public.dart';
import 'package:package_info/package_info.dart';

class AppGuidePage extends StatefulWidget {
  AppGuidePage({Key key}) : super(key: key);

  @override
  _AppGuidePageState createState() => _AppGuidePageState();
}

class _AppGuidePageState extends State<AppGuidePage> {
  List<String> _list = [
    "images/appguide_0@3x.png",
    "images/appguide_1@3x.png",
    "images/appguide_2@3x.png",
  ];

  void _recordVersion() {
    PackageInfo.fromPlatform().then((info) {
      //当前版本
      String currentVersion = info.version;
      recordAppVersion(currentVersion);
    });
  }

  void _goLoginRegister() {
    DartNotificationCenter.post(
        channel: kSwitchTabNotification, options: {"index": -1});
    this._recordVersion();
  }

  void _goMainPage() {
    DartNotificationCenter.post(channel: kRefreshAccountNotification);
    this._recordVersion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      body: Stack(
        children: <Widget>[
          transparentAppBar(),
          Swiper.children(
            children: _list.map(
              (guide) {
                int index = _list.indexOf(guide);
                return Center(
                  child: Container(
                    color: Colors.green,
                    child: Stack(
                      children: <Widget>[
                        Image.asset(
                          guide,
                          fit: BoxFit.fitWidth,
                        ),
                        Positioned(
                          right: 0,
                          bottom: 20,
                          child: index == 2
                              ? FlatButton(
                                  onPressed: () {
                                    userID((id) {
                                      if (isStringEmpty(id)) {
                                        this._goLoginRegister();
                                      } else {
                                        this._goMainPage();
                                      }
                                    });
                                  },
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    height: 90,
                                  ),
                                )
                              : Container(),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ).toList(),
          )
        ],
      ),
    );
  }
}
