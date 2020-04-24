import 'package:flutter/material.dart';
import 'package:ideaclass/pages/commons/emptyplaceholder.dart';
import 'package:ideaclass/pages/course/api/courseapi.dart';
import 'package:ideaclass/public/public.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class LecturerListPage extends StatefulWidget {
  String keyword;
  int type; //2 机构 1 老师
  LecturerListPage({this.keyword, this.type = 2});

  _LecturerListPageState _state;
  @override
  _LecturerListPageState createState() {
    _state = _LecturerListPageState();
    return _state;
  }
}

class _LecturerListPageState extends State<LecturerListPage> {
  List _dataList = [];

  RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  int _currPage = 1;
  int _pageSize = 20;
  bool _loading = true;

  void _refreshData() {
    _currPage = 1;
    _loading = true;
    this._requestData();
  }

  void _loadMoreData() {
    _currPage += 1;
    this._requestData();
  }

  void _requestData() {
    CourseApi().searchLector(
      _currPage,
      _pageSize,
      this.widget.keyword,
      this.widget.type,
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

        _loading = false;
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return functionRefresher(
      _refreshController,
      _dataList.length == 0
          ? EmptyPlaceholder(
              loading: _loading,
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Container();
              },
              itemCount: _dataList.length,
            ),
      onRefresh: () {
        this._refreshData();
      },
      onLoadMore: () {
        this._loadMoreData();
      },
      enableLoadMore: _dataList.length == 0 ? false : true,
    );
  }
}
