import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../public/public.dart';
import 'api/wallet_api.dart';

class RechargeRecord extends StatefulWidget {
  RechargeRecord({Key key}) : super(key: key);

  @override
  _RechargeRecordState createState() => _RechargeRecordState();
}

class _RechargeRecordState extends State<RechargeRecord> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  List _dataList = [];
  int _page = 1;
  int _perPage = 15;
  bool _showLoadMore = false;

  //加载更多
  void _loadMoreData() {
    setState(() {
      _page += 1;
      this._requestData();
    });
  }

  //刷新
  void _refreshData() {
    setState(() {
      _page = 1;
      this._requestData();
    });
  }

  //请求
  void _requestData() {
    kLog("_requestData");
    WalletApi.consumptionList(this._page, this._perPage, (data, msg) {
      if (data != null) {
        Map pagination = data["pagination"];
        List records = data["data"];

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

        if (_page == pagination["total_pages"]) {
          _refreshController.loadNoData();
          _showLoadMore = false;
        } else {
          _refreshController.loadComplete();
          _showLoadMore = true;
        }

        _refreshController.refreshCompleted();
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
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rgba(248, 248, 248, 1),
      appBar: customAppBar(
        title: "充值记录",
        elevation: 0.5,
      ),
      body: _dataList.length > 0
          ? functionRefresher(
              _refreshController,
              ListView.separated(
                itemBuilder: (context, index) {
                  Map _data = _dataList[index];
                  return Container(
                    color: Colors.white,
                    padding: EdgeInsets.fromLTRB(15, 16, 15, 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              //金币图标
                              Image.asset(
                                "images/wallet_jinbi@3x.png",
                                width: 29,
                                height: 29,
                              ),
                              SizedBox(
                                width: 11,
                              ),
                              //充值日期
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  //金币充值
                                  Text(
                                    _data["content"] != null
                                        ? _data["content"]
                                        : "",
                                    style: TextStyle(
                                      color: rgba(51, 51, 51, 1),
                                      fontSize: 13,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  //充值日期
                                  Text(
                                    _data["created_at"] != null
                                        ? "${_data['created_at']}"
                                        : "",
                                    style: TextStyle(
                                      color: rgba(153, 153, 153, 1),
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        //充值金额
                        Text(
                          _data["total_price"] != null
                              ? ((_data["type"] == 2
                                      ? "+"
                                      : _data["type"] == 1 ? "-" : "") +
                                  "${_data['total_price']}")
                              : "",
                          style: TextStyle(
                            color: _data["type"] == 2
                                ? rgba(0, 186, 83, 1)
                                : rgba(255, 45, 85, 1),
                            fontSize: 19.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  //分割线
                  return Container(
                    height: 0.5,
                    padding: EdgeInsets.fromLTRB(55.5, 0, 0, 0),
                    color: Colors.white,
                    child: Container(
                      color: rgba(240, 240, 240, 1),
                    ),
                  );
                },
                itemCount: _dataList.length,
              ),
              onRefresh: () {
                this._refreshData();
              },
              onLoadMore: () {
                this._loadMoreData();
              },
              enableLoadMore: _showLoadMore,
            )
          : functionRefresher(
              _refreshController,
              _refreshController.headerStatus != RefreshStatus.completed
                  ? Container()
                  : Container(
                      child: Center(
                        child: Text(
                          "暂无充值记录",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
              onRefresh: () {
                this._refreshData();
              },
              onLoadMore: () {
                this._loadMoreData();
              },
              enableLoadMore: false,
            ),
    );
  }
}
