import 'package:flutter/material.dart';
import 'package:ideaclass/pages/commons/emptyplaceholder.dart';
import 'package:ideaclass/pages/community/api/communityapi.dart';
import 'package:ideaclass/pages/course/lecturerlistview.dart';
import 'package:ideaclass/public/public.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CommunityRecommend extends StatefulWidget {
  CommunityRecommend({Key key}) : super(key: key);

  @override
  _CommunityRecommendState createState() => _CommunityRecommendState();
}

class _CommunityRecommendState extends State<CommunityRecommend> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  bool _enableLoadMore = false;
  bool _refreshing = true;

  List _lectorRecommend = [];
  List _newRecommend = [];
  List _hotRecommend = [];

  void _requestData() {
    _refreshing = true;

    CommunityApi().getInterestingRecommend(
      (data, msg) {
        if (data != null) {
          _lectorRecommend =
              data["lectorRecommend"] == null ? [] : data["lectorRecommend"];
          _newRecommend =
              data["newRecommend"] == null ? [] : data["newRecommend"];
          _hotRecommend =
              data["hotRecommend"] == null ? [] : data["hotRecommend"];

          Future.delayed(
            Duration(milliseconds: 600),
            () {
              _refreshController.refreshCompleted();
              _refreshing = false;
              setState(() {});
            },
          );
        } else {
          showToast(msg, context);

          _enableLoadMore = false;
          _refreshing = false;
          _refreshController.refreshCompleted();
          setState(() {});
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "有趣推荐"),
      body: functionRefresher(
        _refreshController,
        (_hotRecommend.length == 0 &&
                _newRecommend.length == 0 &&
                _lectorRecommend.length == 0)
            ? EmptyPlaceholder(
                topOffset: 160,
                loading: _refreshing,
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  return index == 0
                      ? LecturerListView(
                          section: _lectorRecommend.length == 0 ? null : "老师推荐",
                          dataList: _lectorRecommend.length == 0
                              ? null
                              : _lectorRecommend,
                        )
                      : index == 1
                          ? _newRecommend.length == 0
                              ? Container()
                              : Container(
                                  height: 100,
                                  color: Colors.greenAccent,
                                )
                          : index == 2
                              ? _hotRecommend.length == 0
                                  ? Container()
                                  : Container(
                                      height: 300,
                                      color: Colors.blue,
                                    )
                              : Container();
                },
                itemCount: 3,
              ),
        onRefresh: () {
          this._requestData();
        },
        enableLoadMore: _enableLoadMore,
      ),
    );
  }
}
