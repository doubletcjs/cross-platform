import 'package:flutter/material.dart';
import 'package:im_flutter/apply.dart';
import 'package:im_flutter/friend.dart';
import 'package:im_flutter/group.dart';
import 'package:im_flutter/session.dart';
import 'package:tencent_im_plugin/tencent_im_plugin.dart';

class HomeTab extends StatefulWidget {
  HomeTab({Key key}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    //获得当前登录用户ID
    TencentImPlugin.getLoginUser().then(
      (value) => {
        //初始化本地存储
        TencentImPlugin.initStorage(identifier: value),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "im",
      home: Scaffold(
        body: IndexedStack(
          children: <Widget>[
            SessionPage(),
            FriendPage(),
            ApplyPage(),
            GroupPage()
          ],
          index: _currentIndex,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.comment),
              title: Text("会话"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_add),
              title: Text("好友"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              title: Text("申请列表"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group),
              title: Text("群组"),
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          elevation: 0,
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
