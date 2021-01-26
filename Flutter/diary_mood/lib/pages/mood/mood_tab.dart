import 'package:diary_mood/pages/mood/mood_list.dart';
import 'package:diary_mood/public/widget/scale_tabbar.dart';
import 'package:flutter/material.dart';

class MoodTabPage extends StatefulWidget {
  MoodTabPage({Key key}) : super(key: key);

  @override
  _MoodTabPageState createState() => _MoodTabPageState();
}

class _MoodTabPageState extends State<MoodTabPage>
    with TickerProviderStateMixin {
  TabController _tabController;
  List<String> _tabs = ["最新", "最热", "我的"];
  PageController _pageController;

  // tab页面
  List<MoodListPage> _pageList = [];

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: _tabs.length, vsync: this);
    _pageList = [
      MoodListPage(
        type: 0,
      ),
      MoodListPage(
        type: 1,
      ),
      MoodListPage(
        type: 2,
      )
    ];
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ScaleTabBar(
          controller: _tabController,
          tabs: _tabs.map((tab) {
            return Text("$tab");
          }).toList(),
          indicator: RoundUnderlineTabIndicator(
            borderSide: BorderSide(
              width: 3,
              color: Theme.of(context).buttonColor,
            ),
            insets: EdgeInsets.fromLTRB(0, 0, 0, -12),
          ),
          labelStyle: TextStyle(
            fontSize: 18,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 17,
          ),
          onTap: (value) {
            _pageController.jumpToPage(value);
            setState(() {});
          },
        ),
      ),
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: _pageList,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.create,
          size: 24,
        ),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.padded,
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
