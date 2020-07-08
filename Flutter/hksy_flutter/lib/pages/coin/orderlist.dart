import 'package:flutter/material.dart';
import 'package:hksy_flutter/pages/coin/api/coinapi.dart';
import 'package:hksy_flutter/pages/coin/views/ordersectioncell.dart';
import 'package:hksy_flutter/public/public.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class OrderList extends StatefulWidget {
  int type = 0;
  OrderList({Key key, this.type = 0}) : super(key: key);

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  List _dataList = [];
  int _page = 1;
  int _limit = 20;
  bool _showLoadMore = false;

  void _loadMoreData() {
    setState(() {
      _page += 1;
      this._requestData();
    });
  }

  void _refreshData() {
    setState(() {
      _page = 1;
      this._requestData();
    });
  }

  void _requestData() {
    if (this.widget.type == 0) {
      CoinApi.queryOfflinePayDetail(currentAcctount["userId"], _page, _limit,
          (data, msg) {
        this._handData(data, msg);
      });
    } else if (this.widget.type == 1) {
      CoinApi.queryTbWithdrawadLog(currentAcctount["userId"], _page, _limit,
          (data, msg) {
        this._handData(data, msg);
      });
    } else if (this.widget.type == 2) {
      CoinApi.queryGoldExchange(currentAcctount["userId"], _page, _limit,
          (data, msg) {
        this._handData(data, msg);
      });
    }
  }

  void _handData(data, msg) {
    if (data != null) {
      if (data is String) {
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

        if (_dataList.length > 0) {
          _showLoadMore = true;
        } else {
          _showLoadMore = false;
        }
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
          return OrderSection(
            emptyPlaceholder: "暂无订单信息～",
            cells: _dataList.map((order) {
              var orderIndex = _dataList.indexOf(order);
              var newOrder = order;
              if (this.widget.type == 0) {
                newOrder["type"] = 47;
              } else if (this.widget.type == 1) {
                newOrder["type"] = 33;
              } else if (this.widget.type == 2) {
                newOrder["type"] = 24;
              }

              return OrderCell(
                order: newOrder,
                showLine: orderIndex == _dataList.length - 1 ? false : true,
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
