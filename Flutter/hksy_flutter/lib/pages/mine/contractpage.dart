import 'package:flutter/material.dart';
import 'package:hksy_flutter/function/emptypage.dart';
import 'package:hksy_flutter/pages/mine/api/mineapi.dart';
import 'package:hksy_flutter/public/networking.dart';
import 'package:hksy_flutter/public/public.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ContractPage extends StatefulWidget {
  ContractPage({Key key}) : super(key: key);

  @override
  _ContractPageState createState() => _ContractPageState();
}

class _ContractPageState extends State<ContractPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List _dataList = [];
  int _page = 1;
  int _limit = 20;
  bool _showLoadMore = false;

  void _loadMoreData() {
    setState(() {
      _page += 1;
      this._requestContracts();
    });
  }

  void _refreshData() {
    setState(() {
      _page = 1;
      this._requestContracts();
    });
  }

  void _requestContracts() {
    MineApi.getContractDetail(currentAcctount["userId"], _page, _limit,
        (data, msg) {
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
  void initState() {
    super.initState();

    MineApi.createContract(currentAcctount["userId"], (data, msg) {
      if (data != null) {
        this._refreshData();
      } else {
        showToast(msg, context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      appBar: customAppBar(
        title: "合同下载",
        brightness: Brightness.dark,
        backgroundColor: kMainBackgroundColor,
        color: Colors.white,
      ),
      body: functionRefresher(
        _refreshController,
        _dataList.length == 0
            ? BaseEmptyPage(
                title: "暂无合同",
                content: "若已购买存储器，请稍后重试~",
              )
            : ListView.separated(
                itemBuilder: (context, index) {
                  Map contract = _dataList[index];

                  return Container(
                    padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                    height: 62,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Image.asset(
                          "images/word@3x.png",
                          width: 22.5,
                          height: 22.5,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            "${contract["contractNumber"]}",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: rgba(255, 255, 255, 1),
                              fontSize: 13,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          icon: Image.asset(
                            "images/ico-download@3x.png",
                            width: 15,
                            height: 15.75,
                          ),
                          onPressed: () {
                            String fileUrl = kQrcodeURL +
                                "/" +
                                "${contract["contractNumber"]}";
                          },
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.fromLTRB(44.5, 0, 12, 0),
                    child: Container(
                      height: 1,
                      color: rgba(145, 152, 173, 0.2),
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
      ),
    );
  }
}
