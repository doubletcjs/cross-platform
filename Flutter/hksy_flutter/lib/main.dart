import 'package:flutter/material.dart';
import 'package:hksy_flutter/function/account/loginregister.dart';
import 'package:hksy_flutter/pages/calculate/calculatemain.dart';
import 'package:hksy_flutter/pages/galaxy/galaxypage.dart';
import 'package:hksy_flutter/pages/guide/appguide.dart';
import 'package:hksy_flutter/pages/home/homepage.dart';
import 'package:hksy_flutter/pages/mine/minepage.dart';
import 'package:hksy_flutter/pages/store/storepage.dart';
import 'package:hksy_flutter/public/public.dart';
import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:package_info/package_info.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = -3; //-1 未登录 -2 版本更新显示版本介绍页 -3 默认空白页

  void _compareVersion(version, kObjectFunctionBlock handel) {
    PackageInfo.fromPlatform().then((info) {
      //当前版本
      String currentVersion = info.version;
      if (version != currentVersion) {
        if (handel != null) {
          handel(true);
        }
      } else {
        if (handel != null) {
          handel(false);
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();

    appVersion((version) {
      if (isStringEmpty(version)) {
        setState(() {
          _currentIndex = -2;
        });
      } else {
        this._compareVersion(version, (needUpdate) {
          if (needUpdate) {
            setState(() {
              _currentIndex = -2;
            });
          } else {
            userID((id) {
              if (isStringEmpty(id)) {
                setState(() {
                  _currentIndex = -1;
                });
              } else {
                setState(() {
                  _currentIndex = 0;
                });
              }
            });
          }
        });
      }
    });

    ///登录成功
    DartNotificationCenter.subscribe(
      channel: kRefreshAccountNotification,
      observer: this,
      onNotification: (options) {
        setState(() {
          _currentIndex = 0;
          kLog("登录成功");
        });
      },
    );

    ///退出登录
    DartNotificationCenter.subscribe(
      channel: kForceLogoutNotification,
      observer: this,
      onNotification: (options) {
        setState(() {
          _currentIndex = -1;
        });
      },
    );

    DartNotificationCenter.subscribe(
      channel: kSwitchTabNotification,
      observer: this,
      onNotification: (options) {
        setState(() {
          _currentIndex = options["index"];
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "华科闪云",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: kMainBackgroundColor,
        body: _currentIndex == -1
            ? LoginRegisterPage()
            : _currentIndex == -2
                ? AppGuidePage()
                : _currentIndex == -3
                    ? Container(
                        color: kMainBackgroundColor,
                      )
                    : IndexedStack(
                        children: <Widget>[
                          HomePage(),
                          StorePage(),
                          GalaxyPage(),
                          MinePage(),
                        ],
                        index: _currentIndex,
                      ),
        bottomNavigationBar: _currentIndex == 0
            ? BottomNavigationBar(
                items: [
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      "images/ico_tab_home_normal@3x.png",
                      width: 22,
                      height: 22,
                    ),
                    activeIcon: Image.asset(
                      "images/ico_tab_home_selected@3x.png",
                      width: 22,
                      height: 22,
                    ),
                    title: Text(
                      "首页",
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      "images/ico_tab_market_normal@3x.png",
                      width: 22,
                      height: 22,
                    ),
                    activeIcon: Image.asset(
                      "images/ico_tab_market_selected@3x.png",
                      width: 22,
                      height: 22,
                    ),
                    title: Text(
                      "商城",
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      "images/ico_tab_galaxy_normal@3x.png",
                      width: 22,
                      height: 22,
                    ),
                    activeIcon: Image.asset(
                      "images/ico_tab_galaxy_selected@3x.png",
                      width: 22,
                      height: 22,
                    ),
                    title: Text(
                      "Galaxy",
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      "images/ico_tab_my_normal@3x.png",
                      width: 22,
                      height: 22,
                    ),
                    activeIcon: Image.asset(
                      "images/ico_tab_my_selected@3x.png",
                      width: 22,
                      height: 22,
                    ),
                    title: Text(
                      "我的",
                    ),
                  )
                ],
                type: BottomNavigationBarType.fixed,
                currentIndex: _currentIndex,
                selectedFontSize: 10,
                unselectedFontSize: 10,
                selectedItemColor: kMainColor,
                unselectedItemColor: rgba(145, 152, 173, 1),
                elevation: 0,
                backgroundColor: kMainBackgroundColor,
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              )
            : null,
      ),
      routes: {
        "/calculate": (context) {
          return CalculateMain();
        },
      },
    );
  }
}
