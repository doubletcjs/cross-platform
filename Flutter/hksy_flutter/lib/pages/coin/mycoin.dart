import 'package:flutter/material.dart';
import 'package:hksy_flutter/pages/coin/api/coinapi.dart';
import 'package:hksy_flutter/pages/coin/views/coinheader.dart';
import 'package:hksy_flutter/pages/coin/views/coinsectioncell.dart';
import 'package:hksy_flutter/public/public.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyCoinPage extends StatefulWidget {
  MyCoinPage({Key key}) : super(key: key);

  @override
  _MyCoinPageState createState() => _MyCoinPageState();
}

class _MyCoinPageState extends State<MyCoinPage> {
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
    userID((id) {
      if (isStringEmpty(id) == false) {
        CoinApi.queryBalance(id, _page, _limit, (data, msg) {
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
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      appBar: customAppBar(
        title: "我的金币",
        brightness: Brightness.dark,
        backgroundColor: kMainBackgroundColor,
        color: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(12, 20, 12, 0),
        child: Column(
          children: <Widget>[
            CoinHeader(),
            Expanded(
              child: functionRefresher(
                _refreshController,
                ListView.builder(
                  padding: EdgeInsets.fromLTRB(
                      0, 20, 0, MediaQuery.of(context).padding.bottom),
                  itemBuilder: (context, index) {
                    return CoinSection(
                      title: "交易明细",
                      emptyPlaceholder: "暂无交易记录～",
                      cells: _dataList.map((data) {
                        var index = _dataList.indexOf(data);
                        return CoinCell(
                          detail: data,
                          showLine:
                              index == _dataList.length - 1 ? false : true,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
