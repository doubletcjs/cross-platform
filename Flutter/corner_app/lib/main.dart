import 'package:flutter/material.dart';

import 'package:corner_app/pages/tab/discover_tab.dart';
import 'package:corner_app/pages/tab/home_tab.dart';
import 'package:corner_app/pages/tab/message_tab.dart';
import 'package:corner_app/pages/tab/mine_tab.dart';
import 'package:corner_app/public/public.dart';

void main() {
  runApp(CornerApp());
}

class CornerApp extends StatefulWidget {
  CornerApp({Key key}) : super(key: key);

  @override
  _CornerAppState createState() => _CornerAppState();
}

class _CornerAppState extends State<CornerApp> {
  int _currentIndex = 0;
  // tab页面
  List<Widget> _tabs = [
    HomeTabPage(),
    DiscoverTabPage(),
    MessageTabPage(),
    MineTabPage(),
  ];

  // tab标题、icon
  List<BottomNavigationBarItem> _barItems() {
    return [
      BottomNavigationBarItem(
        icon: Image.asset(
          "images/home_tab@3x.png",
          width: 28,
          height: 28,
        ),
        title: Text(
          "角落",
        ),
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          "images/discover_tab@3x.png",
          width: 28,
          height: 28,
        ),
        title: Text(
          "发现",
        ),
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          "images/message_tab@3x.png",
          width: 28,
          height: 28,
        ),
        title: Text(
          "消息",
        ),
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          "images/mine_tab@3x.png",
          width: 28,
          height: 28,
        ),
        title: Text(
          "我",
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "角落",
      home: Scaffold(
        body: IndexedStack(
          children: _tabs,
          index: _currentIndex,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: _barItems(),
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          selectedFontSize: 11,
          unselectedFontSize: 11,
          selectedItemColor: rgba(235, 102, 91, 1),
          unselectedItemColor: rgba(27, 27, 27, 1),
          elevation: 0,
          backgroundColor: rgba(255, 255, 255, 1),
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
