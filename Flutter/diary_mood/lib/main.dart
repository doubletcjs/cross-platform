import 'package:diary_mood/pages/diary/diary_tab.dart';
import 'package:diary_mood/pages/mine/mine_tab.dart';
import 'package:diary_mood/pages/mood/mood_tab.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '心情日记',
      home: MainTabPage(),
    );
  }
}

class MainTabPage extends StatefulWidget {
  MainTabPage({Key key}) : super(key: key);

  @override
  _MainTabPageState createState() => _MainTabPageState();
}

class _MainTabPageState extends State<MainTabPage> {
  PageController _pageController;
  DiaryTabPage _diaryTabPage = DiaryTabPage();
  MoodTabPage _moodTabPage = MoodTabPage();
  MineTabPage _mineTabPage = MineTabPage();
  int _current = 0;

  // tab页面
  List<Widget> _tabs = [];

  // tab标题、icon
  List<BottomNavigationBarItem> _barItems() {
    return [
      BottomNavigationBarItem(
        icon: Icon(
          Icons.book,
        ),
        label: "日记",
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.mood,
        ),
        label: "心情",
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.person,
        ),
        label: "我的",
      ),
    ];
  }

  @override
  void initState() {
    super.initState();

    _tabs = [_diaryTabPage, _moodTabPage, _mineTabPage];
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: _tabs,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _barItems(),
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        currentIndex: _current,
        onTap: (value) {
          _pageController.jumpToPage(value);
          _current = value;
          setState(() {});
        },
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
