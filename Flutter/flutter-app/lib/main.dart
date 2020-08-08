import 'package:amap_location_flutter_plugin/amap_location_flutter_plugin.dart';
import 'package:common_utils/common_utils.dart';
import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/material.dart';
import 'package:tencent_im_plugin/tencent_im_plugin.dart';
import 'pages/account/info_input.dart';
import 'pages/account/input_avatar.dart';
import 'pages/account/account_main.dart';
import 'pages/message/message_tab.dart';
import 'pages/mine/mine_tab.dart';
import 'pages/near/near_tab.dart';
import 'public/public.dart';
import 'pages/account/api/account_api.dart';
import 'package:umeng_analytics_plugin/umeng_analytics_plugin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  int _pageStatus = -1; // -1 启动页 0 未登录 1 已登录
  int _unreadCount = 0; //未读消息数

  //未读消息角标
  Widget _messageBadge(bool active) {
    Widget _icon() {
      if (active == false) {
        return Image.asset(
          "images/news@3x.png",
          width: 20,
          height: 20,
        );
      } else {
        return Image.asset(
          "images/news_sel@3x.png",
          width: 20,
          height: 20,
        );
      }
    }

    if (_unreadCount > 0) {
      var _txtBoxSize = getTextSize(
        "$_unreadCount",
        TextStyle(
          fontSize: 10,
          color: rgba(255, 255, 255, 1),
        ),
      );
      var _txtSpace = 14;
      if (_unreadCount < 10) {
        _txtSpace = 7;
      }

      return Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          _icon(),
          Positioned(
            top: -2.5,
            right: -(_txtBoxSize.width + 20 + _txtSpace) / 2,
            child: Container(
              padding: EdgeInsets.fromLTRB(6.5, 2.5, 6.5, 2.5),
              decoration: BoxDecoration(
                color: rgba(255, 73, 54, 1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                "$_unreadCount",
                style: TextStyle(
                  fontSize: 10,
                  color: rgba(255, 255, 255, 1),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return _icon();
    }
  }

  // tab页面
  List<Widget> _tabs = [
    NearPage(),
    MessagePage(),
    MinePage(),
  ];

  // tab标题、icon
  List<BottomNavigationBarItem> _barItems() {
    return [
      BottomNavigationBarItem(
        icon: Image.asset(
          "images/nearby@3x.png",
          width: 20,
          height: 20,
        ),
        activeIcon: Image.asset(
          "images/nearby_sel@3x.png",
          width: 20,
          height: 20,
        ),
        title: Text(
          "附近",
        ),
      ),
      BottomNavigationBarItem(
        icon: _messageBadge(false),
        activeIcon: _messageBadge(true),
        title: Text(
          "消息",
        ),
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          "images/my@3x.png",
          width: 20,
          height: 20,
        ),
        activeIcon: Image.asset(
          "images/my_sel@3x.png",
          width: 20,
          height: 20,
        ),
        title: Text(
          "我",
        ),
      ),
    ];
  }

  //全局刷新用户信息
  void _refreshAccount() {
    AccountApi.profile((data, msg) {
      if (data != null) {
        kLog("刷新用户信息");
        currentAccount = Map.from(data);

        DartNotificationCenter.post(
            channel: kAccountHandleNotification,
            options: {
              "type": 3,
            });
      }
    });
  }

  @override
  void initState() {
    super.initState();

    userID((userID) {
      if (ObjectUtil.isEmptyString(userID) == false) {
        setState(() {
          _pageStatus = 1;
          _currentIndex = 0;
        });
      } else {
        setState(() {
          _pageStatus = 0;
          _currentIndex = 0;
        });
      }
    });

    DartNotificationCenter.subscribe(
      channel: kAccountHandleNotification,
      observer: this,
      onNotification: (option) {
        //type 0 登录 1 请求账号信息刷新 2 登出 3 请求账号信息结束，刷新本地记录用户信息
        if (option["type"] == 0) {
          setState(() {
            _pageStatus = 1;
            _currentIndex = 0;
          });
        } else if (option["type"] == 2) {
          setState(() {
            _pageStatus = 0;
            _currentIndex = 0;
          });
        } else if (option["type"] == 1) {
          this._refreshAccount();
        }
      },
    );

    DartNotificationCenter.subscribe(
      channel: kAccountProfileNotification,
      observer: this,
      onNotification: (option) {
        //status 470 资料完善第一步
        if (option["status"] == 470) {
          Router.navigatorKey.currentState.pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) {
              return InfoInputPage();
            }),
            (route) => route == null,
          );
        }
        // status 471 资料完善第二步
        if (option["status"] == 471) {
          Router.navigatorKey.currentState.pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) {
              return InputAvatarPage();
            }),
            (route) => route == null,
          );
        }
      },
    );

    //高德地图
    AmapLocationFlutterPlugin.setApiKey(
        AMAP_CONFIG["androidKey"], AMAP_CONFIG["iosKey"]);

    //友盟统计
    initUmengAnalysis();

    //初始化腾讯im聊天
    TencentImPlugin.init(appid: TENCENTIM_APPID);
  }

  void initUmengAnalysis() async {
    var res = await UmengAnalyticsPlugin.init(
      androidKey: UMENG_CONFIG['androidKey'],
      iosKey: UMENG_CONFIG['iosKey'],
    );

    if (res) {
      kLog("友盟统计配置成功！");
    }
  }

  @override
  void dispose() {
    super.dispose();

    DartNotificationCenter.unsubscribe(observer: this);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '约约',
      navigatorKey: Router.navigatorKey, //设置在这里
      home: Scaffold(
        backgroundColor: kMainBackgroundColor,
        body: _pageStatus == -1
            ? Container()
            : _pageStatus == 0
                ? AccountMainPage()
                : IndexedStack(
                    children: _tabs,
                    index: _currentIndex,
                  ),
        bottomNavigationBar: _pageStatus == 0
            ? null
            : BottomNavigationBar(
                items: _barItems(),
                type: BottomNavigationBarType.fixed,
                currentIndex: _currentIndex,
                selectedFontSize: 9,
                unselectedFontSize: 9,
                selectedItemColor: kTabSelectedColor,
                unselectedItemColor: kTabUnselectedColor,
                elevation: 0,
                backgroundColor: kMainBackgroundColor,
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
      ),
    );
  }
}

class Router {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();
}
