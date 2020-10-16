import 'package:flutter/material.dart';
import 'package:time_flies/pages/dynamic/dynamic_post.dart';
import 'package:time_flies/pages/home/home_page.dart';
import 'package:time_flies/pages/home/menu_page.dart';
import 'package:time_flies/pages/topic/topic_list.dart';
import 'package:time_flies/public/public.dart';

class HomeTabPage extends StatefulWidget {
  HomeTabPage({Key key}) : super(key: key);

  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

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

  // 发布
  void _postDynamic() {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) {
            return DynamicPostPage();
          },
          fullscreenDialog: true),
    );
  }

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
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
        titleView: TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
          unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 17,
          ),
          indicator: BoxDecoration(),
          tabs: [
            Tab(
              text: "主页",
            ),
            Tab(
              text: "关注",
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: MenuPage(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          this._postDynamic();
        },
        child: Icon(
          Icons.add,
          size: 32,
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
