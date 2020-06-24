import 'package:flutter/material.dart';
import 'package:hksy_flutter/pages/invitation/api/invitationapi.dart';
import 'package:hksy_flutter/pages/invitation/views/friendsectioncell.dart';
import 'package:hksy_flutter/public/public.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FriendPage extends StatefulWidget {
  FriendPage({Key key}) : super(key: key);

  @override
  _FriendPageState createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  List _dataList = [];
  int _page = 1;
  int _limit = 20;
  bool _showLoadMore = false;

  void _loadMoreData() {
    setState(() {
      _page += 1;
      this._requestMyFriend();
    });
  }

  void _refreshData() {
    setState(() {
      _page = 1;
      this._requestMyFriend();
    });
  }

  void _requestMyFriend() {
    userID((id) {
      if (isStringEmpty(id) == false) {
        InvitationApi.getMyFriend(id, _page, _limit, (data, msg) {
          if (data != null) {
            if (data is String) {
              _refreshController.refreshCompleted();
              _refreshController.loadComplete();
              showToast(data, context);

              setState(() {
                _showLoadMore = false;
              });
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

              if (_page == data["pages"] || data["pages"] == 0) {
                _refreshController.loadNoData();
              } else {
                _refreshController.loadComplete();
              }

              if (_dataList.length > 0) {
                _showLoadMore = true;
              } else {
                _showLoadMore = false;
              }
              _refreshController.refreshCompleted();
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
      } else {
        _refreshController.refreshCompleted();
        _refreshController.loadComplete();
        showToast("无法获取用户信息", context);

        setState(() {
          _showLoadMore = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return functionRefresher(
      _refreshController,
      ListView.builder(
        padding: EdgeInsets.fromLTRB(
          12,
          20,
          12,
          MediaQuery.of(context).padding.bottom,
        ),
        itemBuilder: (context, index) {
          return FriendSection(
            title: "邀请好友明细",
            emptyPlaceholder: "暂无好友信息～",
            cells: _dataList.map((data) {
              var index = _dataList.indexOf(data);
              return FriendCell(
                detail: data,
                showLine: index == _dataList.length - 1 ? false : true,
              );
            }).toList(),
          );
        },
        itemCount: 1,
      ),
      onRefresh: () {
        this._refreshData();
      },
      onLoadMore: () {
        this._loadMoreData();
      },
      enableLoadMore: _showLoadMore,
    );
  }
}
