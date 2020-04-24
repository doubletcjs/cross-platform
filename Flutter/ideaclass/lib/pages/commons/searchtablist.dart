import 'package:flutter/material.dart';
import 'package:ideaclass/pages/activity/activitylistpage.dart';
import 'package:ideaclass/pages/course/courselistpage.dart';
import 'package:ideaclass/pages/course/lecturerlistpage.dart';
import 'package:ideaclass/public/public.dart';

class SearchTabList extends StatefulWidget {
  String keyword;
  int searchType = 0; // 0 课程 1 活动
  SearchTabList({this.keyword = "", this.searchType = 0});

  @override
  _SearchTabListState createState() => _SearchTabListState();
}

class _SearchTabListState extends State<SearchTabList>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<String> _tabItems = ["课程", "活动", "机构", "老师"];
  int _currentIndex = 0;
  CourseListPage _courseListPage;
  ActivityListPage _activityListPage;
  LecturerListPage _institutionsListPage;
  LecturerListPage _lecturerListPage;

  void _switchTab(index) {
    _tabController.index = index;
    _currentIndex = index;

    setState(
      () {},
    );
  }

  @override
  void initState() {
    super.initState();

    _courseListPage = CourseListPage(
      keyword: this.widget.keyword,
    );

    _activityListPage = ActivityListPage(
      keyword: this.widget.keyword,
    );

    _institutionsListPage = LecturerListPage(
      keyword: this.widget.keyword,
      type: 2,
    );

    _lecturerListPage = LecturerListPage(
      keyword: this.widget.keyword,
      type: 1,
    );

    _tabController = TabController(length: _tabItems.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: this.widget.keyword,
      ),
      body: this.widget.searchType == 1
          ? _activityListPage
          : Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: TabBarView(
                    controller: _tabController,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      _courseListPage,
                      _activityListPage,
                      _institutionsListPage,
                      _institutionsListPage,
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  color: rgba(240, 240, 240, 1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: _tabItems.map(
                      (item) {
                        return buttonWidget(
                          Container(
                            width: MediaQuery.of(context).size.width /
                                _tabItems.length,
                            height: 50,
                            child: Stack(
                              children: <Widget>[
                                Center(
                                  child: Text(
                                    item,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: item == _tabItems[_currentIndex]
                                          ? rgba(150, 150, 150, 1)
                                          : rgba(23, 23, 23, 1),
                                    ),
                                  ),
                                ),
                                item == _tabItems[_currentIndex]
                                    ? Positioned(
                                        bottom: -10,
                                        left: 0,
                                        right: 0,
                                        child: Icon(Icons.arrow_drop_up,
                                            color: Colors.white),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                          context,
                          onTap: () {
                            var index = _tabItems.indexOf(item);
                            this._switchTab(index);
                          },
                        );
                      },
                    ).toList(),
                  ),
                ),
              ],
            ),
    );
  }
}
