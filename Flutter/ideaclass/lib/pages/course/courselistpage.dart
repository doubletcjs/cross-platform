import 'package:flutter/material.dart';
import 'package:ideaclass/pages/course/api/courseapi.dart';
import 'package:ideaclass/pages/course/views/courselistcell.dart';
import 'package:ideaclass/public/public.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CourseListPage extends StatefulWidget {
  String keyword;
  CourseListPage({this.keyword});

  _CourseListPageState _state;
  @override
  _CourseListPageState createState() {
    _state = _CourseListPageState();
    return _state;
  }
}

class _CourseListPageState extends State<CourseListPage> {
  List _dataList = [];

  RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  int _currPage = 1;
  int _pageSize = 20;

  void _refreshData() {
    _currPage = 1;
    this._requestData();
  }

  void _loadMoreData() {
    _currPage += 1;
    this._requestData();
  }

  void _requestData() {
    CourseApi().getCourseList(
      _currPage,
      _pageSize,
      this.widget.keyword,
      (data, msg) {
        if (data != null) {
          List _list = data["list"];
          if (_currPage == 1) {
            _dataList = _list;
          } else {
            _dataList = _dataList + _list;
          }

          if (data["totalPage"] <= _currPage) {
            _refreshController.loadNoData();
          }

          _refreshController.refreshCompleted();
        } else {
          showToast(msg, context);
          if (_currPage > 1) {
            _currPage -= 1;
          }

          _refreshController.loadFailed();
          _refreshController.refreshCompleted();
        }

        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return functionRefresher(
      _refreshController,
      ListView.builder(
        itemBuilder: (context, index) {
          var course = _dataList[index];
          return CourselistCell(
            course: course,
          );
        },
        itemCount: _dataList.length,
      ),
      enableLoadMore: _dataList.length == 0 ? false : true,
      onRefresh: () {
        this._refreshData();
      },
      onLoadMore: () {
        this._loadMoreData();
      },
    );
  }
}
