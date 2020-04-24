import 'package:flutter/material.dart';
import 'package:ideaclass/pages/activity/api/activityapi.dart';
import 'package:ideaclass/pages/activity/views/activityhotswiper.dart';
import 'package:ideaclass/pages/commons/emptyplaceholder.dart';
import 'package:ideaclass/public/public.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ActivityHot extends StatefulWidget {
  kObjectFunctionBlock hotSearchHandle;

  ActivityHot({this.hotSearchHandle});

  @override
  _ActivityHotState createState() => _ActivityHotState();
}

class _ActivityHotState extends State<ActivityHot> {
  ActivityHotSwiper _hotSwiper;
  List _hotSearch = [];
  List _banners = [];
  List _excellent = [];
  List _lectors = [];

  RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  bool _refreshing = true;

  void _requestData() {
    _refreshing = true;

    ActivityApi().getActivityIndex(
      (data, msg) {
        if (data != null) {
          _banners = data["banners"] == null ? [] : data["banners"];
          _hotSearch = data["hostSearch"] == null ? [] : data["hostSearch"];
          _excellent = data["excellent"] == null ? [] : data["excellent"];
          _lectors = data["lectors"] == null ? [] : data["lectors"];

          _hotSwiper = ActivityHotSwiper(
            banners: _banners,
          );

          if (this.widget.hotSearchHandle != null && _hotSearch != null) {
            this.widget.hotSearchHandle(_hotSearch);
          }

          Future.delayed(
            Duration(milliseconds: 600),
            () {
              _refreshController.refreshCompleted();
              _refreshController.loadNoData();
              _refreshing = false;
              setState(
                () {},
              );
            },
          );
        } else {
          showToast(msg, context);

          _refreshController.refreshCompleted();
          _refreshing = false;
          setState(
            () {},
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return functionRefresher(
      _refreshController,
      ListView.builder(
        itemCount: (_excellent.length == 0 && _lectors.length == 0) ? 2 : 3,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _hotSwiper == null ? Container() : _hotSwiper;
          } else {
            return (_excellent.length == 0 && _lectors.length == 0)
                ? EmptyPlaceholder(
                    loading: _refreshing,
                  )
                : Container();
          }
        },
      ),
      onRefresh: () {
        this._requestData();
      },
    );
  }
}
