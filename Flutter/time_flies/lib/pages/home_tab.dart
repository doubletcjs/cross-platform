import 'package:flutter/material.dart';
import 'package:time_flies/pages/dynamic/dynamic_list.dart';
import 'package:time_flies/pages/dynamic/dynamic_post.dart';
import 'package:time_flies/pages/home/home_page.dart';
import 'package:time_flies/pages/home/menu_page.dart';
import 'package:time_flies/pages/topic/topic_list.dart';
import 'package:time_flies/public/public.dart';
import 'package:time_flies/function/scale_tabbar.dart';

class HomeTabPage extends StatefulWidget {
  HomeTabPage({Key key}) : super(key: key);

  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<String> _tabs = [
    "主页",
    "关注",
  ];

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

    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();

    _tabController.dispose();
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
        titleView: Container(
          height: AppBar().preferredSize.height,
          child: ScaleTabBar(
            controller: _tabController,
            indicator: RoundUnderlineTabIndicator(
              borderSide: BorderSide(
                width: 28,
                color: rgba(255, 44, 96, 1),
              ),
              insets: EdgeInsets.only(
                  bottom: (AppBar().preferredSize.height - 28) / 2),
            ),
            tabs: _tabs.map(
              (tab) {
                return Tab(
                  text: tab,
                );
              },
            ).toList(),
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: rgba(255, 255, 255, 1),
            isScrollable: true,
            unselectedLabelColor: rgba(102, 102, 102, 1),
            labelStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
      body: TabBarView(
        // physics: NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [
          DynamicList(),
          Container(),
        ],
      ),
      drawer: Drawer(
        child: MenuPage(),
      ),
      floatingActionButton: Container(
        width: 60,
        height: 60,
        child: FlatButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            this._postDynamic();
          },
          child: Image.asset(
            "images/dynamic_float_post@3x.png",
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60 / 2),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
