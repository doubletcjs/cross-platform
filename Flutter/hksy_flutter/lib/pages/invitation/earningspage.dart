import 'package:flutter/material.dart';
import 'package:hksy_flutter/pages/invitation/api/invitationapi.dart';
import 'package:hksy_flutter/pages/invitation/views/earningheader.dart';
import 'package:hksy_flutter/pages/invitation/views/invitesectioncell.dart';
import 'package:hksy_flutter/public/public.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class EarningsPage extends StatefulWidget {
  EarningsPage({Key key}) : super(key: key);

  @override
  _EarningsPageState createState() => _EarningsPageState();
}

class _EarningsPageState extends State<EarningsPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  List _dataList = [];
  int _page = 1;
  int _limit = 20;
  bool _showLoadMore = false;

  void _loadMoreData() {
    setState(() {
      _page += 1;
      this._requestEarnings();
    });
  }

  void _refreshData() {
    setState(() {
      _page = 1;
      this._requestEarnings();
    });
  }

  void _requestEarnings() {
    InvitationApi.getEarningsDetailForUser("", _page, _limit, (data, msg) {
      if (data != null) {
        if (data is String) {
          _refreshController.refreshCompleted();
          _refreshController.loadComplete();
          showToast(data, context);
        } else {
          List records = data["records"];
          setState(() {
            if (_page == 1) {
              _dataList = records;
            } else {
              _dataList = _dataList + records;
            }

            if (records.length == 0 && _page > 1) {
              _page -= 1;
            }
          });

          _refreshController.refreshCompleted();
          if (_page == data["pages"] || data["pages"] == 0) {
            _refreshController.loadNoData();
          } else {
            _refreshController.refreshCompleted();
          }

          _showLoadMore = true;
        }
      } else {
        setState(() {
          if (_page > 1) {
            _page -= 1;
          }
        });

        _refreshController.refreshCompleted();
        _refreshController.loadComplete();
        showToast(msg, context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.fromLTRB(
        12,
        20,
        12,
        MediaQuery.of(context).padding.bottom,
      ),
      itemBuilder: (context, index) {
        return index == 0
            ? Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 35),
                child: EarningHeader(),
              )
            : InvitationSection(
                title: "邀请收益明细",
                emptyPlaceholder: "暂无收益信息～",
                cells: _dataList.map((data) {
                  return InvitationCell(
                    detail: {},
                  );
                }).toList(),
              );
      },
      itemCount: 2,
    );
  }
}
