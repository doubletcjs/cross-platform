import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/material.dart';
import 'package:ideaclass/pages/activity/activitypage.dart';
import 'package:ideaclass/pages/community/communitypage.dart';
import 'package:ideaclass/pages/main/homepage.dart';
import 'package:ideaclass/pages/mine/minepage.dart';
import 'package:ideaclass/public/public.dart';
import 'package:sharesdk_plugin/sharesdk_plugin.dart';

class MainTabPage extends StatefulWidget {
  MainTabPage({Key key}) : super(key: key);

  @override
  _MainTabPageState createState() => _MainTabPageState();
}

class _MainTabPageState extends State<MainTabPage> {
  int _currentIndex = 0;
  List _tabTitles = ["首页", "活动", "社区", "我的"];
  List _tabIcons = [
    "images/shouye@3x.png",
    "images/huodong@3x.png",
    "images/shequ@3x.png",
    "images/wode@3x.png"
  ];
  List _tabSelectIcons = [
    "images/shouye_sel@3x.png",
    "images/huodong_sel@3x.png",
    "images/shequ_sel@3x.png",
    "images/wode_sel@3x.png"
  ];

  List<BottomNavigationBarItem> _barItems() {
    List<BottomNavigationBarItem> _list = [];
    for (var title in _tabTitles) {
      int index = _tabTitles.indexOf(title);
      _list.add(
        BottomNavigationBarItem(
          icon: Image.asset(
              index == _currentIndex
                  ? _tabSelectIcons[index]
                  : _tabIcons[index],
              width: 20,
              height: 20),
          title: Text(title),
        ),
      );
    }

    return _list;
  }

  @override
  void initState() {
    super.initState();
    hideHUD();
    fetchUser();

    DartNotificationCenter.subscribe(
      channel: kForceLogoutNotification,
      observer: this,
      onNotification: (options) {
        logoutAcctount();
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) {
              return MainTabPage();
            },
          ),
          (route) => route == null,
        );
      },
    );

    ///分享
    ShareSDKRegister register = ShareSDKRegister();
    register.setupQQ("1109430201", "A38yI0RNse97TRqn");
    register.setupWechat(
        "wx0c0e0c0d17f638a3", "32b5999f5d354c2557367c9875064fff", null);
    register.setupSinaWeibo("1254272916", "16e07baa55e95a87fef1cd8d4294311f",
        "http://www.sharesdk.cn");

    SharesdkPlugin.regist(register);
  }

  @override
  void dispose() {
    DartNotificationCenter.unsubscribe(
        observer: this, channel: kRefreshAccountNotification);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: <Widget>[
          HomePage(),
          ActivityPage(),
          CommunityPage(),
          MinePage()
        ],
        index: _currentIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: _barItems(),
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(
              () {
                _currentIndex = index;
              },
            );
          },
          backgroundColor: Colors.white,
          selectedLabelStyle: TextStyle(color: kMainColor),
          selectedFontSize: 10,
          unselectedLabelStyle: TextStyle(color: Colors.black54),
          unselectedFontSize: 10,
          selectedItemColor: kMainColor,
          unselectedItemColor: Colors.black54,
          type: BottomNavigationBarType.fixed,
          elevation: 0),
    );
  }
}
