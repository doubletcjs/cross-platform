import 'package:flutter/material.dart';
import 'package:ideaclass/pages/activity/api/activityapi.dart';
import 'package:ideaclass/pages/activity/views/activitylocation.dart';
import 'package:ideaclass/pages/commons/emptyplaceholder.dart';
import 'package:ideaclass/public/public.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ActivityNear extends StatefulWidget {
  ActivityNear({Key key}) : super(key: key);

  @override
  _ActivityNearState createState() => _ActivityNearState();
}

class _ActivityNearState extends State<ActivityNear> {
  String _areaId = "";
  List _nearbyAvtivitys = [];
  List _nearbyLectors = [];

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  bool _refreshing = true;

  void _requestData() {
    _refreshing = true;

    if (_areaId.length > 0) {
      ActivityApi().getNearbyAvtivityIndex(
        _areaId,
        (data, msg) {
          if (data != null) {
            _nearbyAvtivitys =
                data["nearbyAvtivitys"] == null ? [] : data["nearbyAvtivitys"];
            _nearbyLectors =
                data["hostSearch"] == null ? [] : data["nearbyLectors"];

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
    } else {
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return functionRefresher(
      _refreshController,
      ListView.builder(
        itemCount: (_nearbyAvtivitys.length == 0 && _nearbyLectors.length == 0)
            ? 2
            : 3,
        itemBuilder: (context, index) {
          return index == 0
              ? ActivityLocation(
                  areaHandle: (areaId) {
                    _areaId = areaId;
                    _refreshController.requestRefresh();
                  },
                )
              : (_nearbyAvtivitys.length == 0 && _nearbyLectors.length == 0)
                  ? EmptyPlaceholder(
                      loading: _refreshing,
                    )
                  : Container();
        },
      ),
      onRefresh: () {
        this._requestData();
      },
    );
  }
}
