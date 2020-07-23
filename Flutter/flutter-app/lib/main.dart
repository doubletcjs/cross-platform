import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/material.dart';
import 'pages/account/accountmain.dart';
import 'pages/message/main_message.dart';
import 'pages/mine/main_mine.dart';
import 'pages/near/main_near.dart';
import 'public/public.dart';

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
  int _pageStatus = 0; //0 未登录 1 已登录
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

  @override
  void initState() {
    super.initState();

    setState(() {
      _unreadCount = 130;
    });

    DartNotificationCenter.subscribe(
      channel: kAccountHandleNotification,
      observer: this,
      onNotification: (option) {
        if (option["type"] == 0) {
          setState(() {
            _pageStatus = 1;
          });
        }
      },
    );
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
      home: Scaffold(
        backgroundColor: kMainBackgroundColor,
        body: _pageStatus == 0
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
