import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/material.dart';
import 'package:hksy_flutter/function/account/api/accountapi.dart';
import 'package:hksy_flutter/pages/home/api/homeapi.dart';
import 'package:hksy_flutter/pages/home/views/homeassets.dart';
import 'package:hksy_flutter/pages/home/views/homeheader.dart';
import 'package:hksy_flutter/pages/home/views/homeintroduce.dart';
import 'package:hksy_flutter/pages/home/views/homenotice.dart';
import 'package:hksy_flutter/pages/home/views/homerecommend.dart';
import 'package:hksy_flutter/pages/home/views/homeversion.dart';
import 'package:hksy_flutter/public/public.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //获取用户信息
  void _refreshUserInfo() {
    userID((id) {
      if (isStringEmpty(id) == false) {
        AccountApi.getUserInfo(id, (data, msg) {
          if (data != null) {
            recordUserInfo(data);
            fetchUser(null);
            kLog("获取用户信息");
          }
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();

    DartNotificationCenter.subscribe(
      channel: kRefreshAccountNotification,
      observer: this,
      onNotification: (options) {
        this._refreshUserInfo();
      },
    );

    userID((id) {
      if (isStringEmpty(id) == false) {
        HomeApi.getAppVersion((data, msg) {
          if (data != null) {
            if (data.length > 0) {
              HomeVersion().show(
                context,
                data,
              );
            }
          }
        });
      }
    });

    this._refreshUserInfo();
  }

  @override
  void didUpdateWidget(HomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      body: Stack(
        children: <Widget>[
          transparentAppBar(
            brightness: Brightness.dark,
          ),
          ListView.builder(
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              return index == 0
                  ? HomeHeader()
                  : index == 1
                      ? HomeNotice()
                      : index == 2
                          ? HomeAssets()
                          : index == 3
                              ? HomeRecommend()
                              : index == 4 ? HomeIntroduce() : Container();
            },
            itemCount: 5,
          ),
        ],
      ),
    );
  }
}
