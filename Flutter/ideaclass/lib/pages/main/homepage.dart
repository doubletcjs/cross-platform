import 'package:flutter/material.dart';
import 'package:ideaclass/pages/course/coursedetail.dart';
import 'package:ideaclass/pages/course/courselistview.dart';
import 'package:ideaclass/pages/main/api/homeapi.dart';
import 'package:ideaclass/pages/main/views/homebottomsheet.dart';
import 'package:ideaclass/pages/main/views/homeheader.dart';
import 'package:ideaclass/public/public.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeHeader _header;
  List _courseList = [];

  RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  bool _enableLoadMore = false;

  void _requestData() {
    HomeApi().getIndexData(
      (data, msg) {
        if (data != null) {
          _courseList =
              data["boardCourseList"] == null ? [] : data["boardCourseList"];

          _header = HomeHeader(
            homeData: data,
          );

          _enableLoadMore = true;
          Future.delayed(
            Duration(milliseconds: 600),
            () {
              _refreshController.refreshCompleted();
              _refreshController.loadNoData();
              setState(() {});
            },
          );
        } else {
          showToast(msg, context);

          _enableLoadMore = false;
          _refreshController.refreshCompleted();
          setState(() {});
        }
      },
    );
  }

  void _itemBottomSheet() {
    HomeBottomSheet _bottomSheet = HomeBottomSheet(
      selectHandle: (item) {},
    );
    _bottomSheet.show(context);
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          transparentAppBar(),
          functionRefresher(
            _refreshController,
            ListView.builder(
              shrinkWrap: true,
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              itemCount: 2,
              itemBuilder: (context, index) {
                return index == 0
                    ? _header == null ? Container() : _header
                    : CourseListView(
                        dataList: _courseList,
                        section: "课程排行榜",
                        listHandle: (object) {
                          Map course = Map.from(object);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return CourseDetailPage(
                                  detailID: "${course["courseId"]}",
                                );
                              },
                            ),
                          );
                        },
                      );
              },
            ),
            onRefresh: () {
              this._requestData();
            },
            enableLoadMore: _enableLoadMore,
          ),
        ],
      ),
      floatingActionButton: buttonWidget(
        Image.asset(
          "images/icon_main_menu@3x.png",
          width: 45,
          height: 45,
        ),
        context,
        onTap: () {
          this._itemBottomSheet();
        },
        radius: BorderRadius.circular(45 / 2),
      ),
    );
  }
}
