import 'package:flutter/material.dart';
import 'package:ideaclass/pages/activity/activityhot.dart';
import 'package:ideaclass/pages/activity/activitynear.dart';
import 'package:ideaclass/pages/commons/searchcenter.dart';
import 'package:ideaclass/pages/main/views/homebottomsheet.dart';
import 'package:ideaclass/public/public.dart';

class ActivityPage extends StatefulWidget {
  ActivityPage({Key key}) : super(key: key);

  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<String> _tabs = ["\t\t精选\t\t", "\t\t附近\t\t"];
  List _hotSearch = [];

  void _itemBottomSheet() {
    HomeBottomSheet _bottomSheet = HomeBottomSheet(
      selectHandle: (item) {},
    );
    _bottomSheet.show(context);
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
        titleView: TabBar(
          controller: _tabController,
          labelColor: rgba(24, 159, 251, 1),
          labelStyle: TextStyle(
            fontSize: 20,
          ),
          unselectedLabelColor: Colors.black,
          unselectedLabelStyle: TextStyle(
            fontSize: 17,
          ),
          indicatorColor: rgba(24, 159, 251, 1),
          indicatorSize: TabBarIndicatorSize.label,
          tabs: _tabs.map(
            (tab) {
              return Tab(
                text: tab,
              );
            },
          ).toList(),
        ),
        leftItem: IconButton(
          icon: Image.asset(
            "images/nav-daohang@3x.png",
            color: Colors.grey,
            width: 19,
          ),
          onPressed: () {
            this._itemBottomSheet();
          },
        ),
        rightItems: [
          IconButton(
            icon: Image.asset("images/nav-search@3x.png"),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return SearchCenterPage(
                      hotSearch: _hotSearch,
                      searchType: 1,
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          ActivityHot(
            hotSearchHandle: (list) {
              _hotSearch = List.from(list);
            },
          ),
          ActivityNear(),
        ],
      ),
    );
  }
}
