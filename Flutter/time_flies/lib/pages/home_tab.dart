import 'package:flutter/material.dart';
import 'package:time_flies/pages/home/home_page.dart';
import 'package:time_flies/pages/home/menu_page.dart';
import 'package:time_flies/pages/topic/topic_list.dart';
import 'package:time_flies/public/public.dart';

class HomeTabPage extends StatefulWidget {
  HomeTabPage({Key key}) : super(key: key);

  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  // 个人主页
  void _homePage() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return HomePage();
      }),
    );
  }

  // 话题动态列表
  void _topicList() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return TopicListPage();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        leftItems: [
          Builder(
            builder: (context) {
              return IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(
                  Icons.menu_rounded,
                  size: 32,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: MenuPage(),
      ),
    );
  }
}
