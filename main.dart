import 'package:chongxiaobao/pages/chat/chat_tab.dart';
import 'package:chongxiaobao/pages/home/home_tab.dart';
import 'package:chongxiaobao/pages/merchant/merchant_tab.dart';
import 'package:chongxiaobao/pages/mine/mine_tab.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

import 'public/public.dart';
import 'public/public.dart';
import 'public/public.dart';
import 'public/public.dart';
import 'public/public.dart';
import 'public/public.dart';
import 'public/public.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '宠小宝',
      navigatorKey: Router.navigatorKey, //设置在这里
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _unreadCount = 0; //未读消息数
  int _currentIndex = 0;

  // tab页面
  List<Widget> _tabs = [
    HomeTabPage(),
    MerchantTabPage(),
    Container(),
    ChatTabPage(),
    MineTabPage(),
  ];

  // tab标题、icon
  List<TabItem> _barItems() {
    List<String> _tabs = [
      "主页",
      "商家",
      "",
      "聊天",
      "我的",
    ];
    List<String> _tabSelectIcons = [
      "images/home_tab_sel@3x.png",
      "images/home_tab_sel@3x.png",
      "",
      "images/home_tab_sel@3x.png",
      "images/home_tab_sel@3x.png",
    ];

    List<String> _tabIcons = [
      "images/home_tab@3x.png",
      "images/home_tab@3x.png",
      "",
      "images/home_tab@3x.png",
      "images/home_tab@3x.png",
    ];

    return _tabs.map((tab) {
      var index = _tabs.indexOf(tab);
      return tab == ""
          ? TabItem(
              icon: InkWell(
                child: Image.asset(
                  "images/tab_post_icon@3x.png",
                  width: 52,
                  height: 52,
                ),
                onTap: () {},
              ),
            )
          : TabItem(
              title: tab,
              icon: Image.asset(_currentIndex == index
                  ? _tabSelectIcons[index]
                  : _tabIcons[index]),
            );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: _tabs,
        index: _currentIndex,
      ),
      bottomNavigationBar: StyleProvider(
        style: Style(),
        child: ConvexAppBar.badge(
          {0: "12"},
          badgeMargin: EdgeInsets.only(bottom: 26, left: 40),
          badgePadding: EdgeInsets.fromLTRB(5, 2, 5, 2),
          backgroundColor: kMainBackgroundColor,
          color: kTextColor,
          activeColor: kMainColor,
          elevation: 0.1,
          style: TabStyle.fixedCircle,
          onTabNotify: (index) {
            setState(() {
              _currentIndex = index;
            });
            return index == 2 ? false : true;
          },
          items: _barItems(),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: _barItems(),
      //   type: BottomNavigationBarType.fixed,
      //   currentIndex: _currentIndex,
      //   selectedFontSize: 10,
      //   unselectedFontSize: 10,
      //   selectedItemColor: kMainColor,
      //   unselectedItemColor: kTextColor,
      //   elevation: 0,
      //   backgroundColor: kMainBackgroundColor,
      //   onTap: (index) {
      //     setState(() {
      //       _currentIndex = index;
      //     });
      //   },
      // ),
    );
  }
}

class Router {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();
}

class Style extends StyleHook {
  @override
  double get activeIconSize => 40;

  @override
  double get activeIconMargin => 10;

  @override
  double get iconSize => 20;

  @override
  TextStyle textStyle(Color color) {
    return TextStyle(fontSize: 10, color: color);
  }
}
