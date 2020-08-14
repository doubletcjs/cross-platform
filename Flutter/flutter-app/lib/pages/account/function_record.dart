import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';
import '../../public/public.dart';
import 'views/account_function_cell.dart';
import '../function/general_alert.dart';
import 'api/record_list_api.dart';

class FunctionRecord extends StatefulWidget {
  int recordType = 0; //记录类型 0 喜欢我 1 看过我
  FunctionRecord({Key key, this.recordType = 0}) : super(key: key);

  @override
  _FunctionRecordState createState() => _FunctionRecordState();
}

class _FunctionRecordState extends State<FunctionRecord> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  List _dataList = [];
  int _page = 1;
  int _perPage = 15;
  bool _showLoadMore = false;
  // int _total = 0; //总数

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
    void _handleData(data, msg) {
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
    }

    if (this.widget.recordType == 0) {
      //喜欢我的
      RecordListApi.loveMe(this._page, this._perPage, (data, msg) {
        _handleData(data, msg);
      });
    } else {
      //看过我的
      RecordListApi.visitors(this._page, this._perPage, (data, msg) {
        _handleData(data, msg);
      });
    }
  }

  // Map _account = {};
  // //获取用户信息
  // void _refreshAccount() {
  //   setState(() {
  //     _account = currentAccount;
  //   });
  // }

  //清除记录
  void _cleanRecords() {
    XsProgressHud.show(context);
    if (this.widget.recordType == 0) {
      //清除喜欢我的
      RecordListApi.cleanLoveMe((data, msg) {
        if (data != null) {
          //更新用户信息
          DartNotificationCenter.post(
              channel: kAccountHandleNotification,
              options: {
                "type": 1,
              });

          setState(() {
            _dataList = [];
            Future.delayed(Duration(milliseconds: 300), () {
              XsProgressHud.hide();
            });
          });
        } else {
          XsProgressHud.hide();
          showToast(msg, context);
        }
      });
    } else {
      //清除看过我的
      RecordListApi.cleanVisitors((data, msg) {
        if (data != null) {
          //更新用户信息
          DartNotificationCenter.post(
              channel: kAccountHandleNotification,
              options: {
                "type": 1,
              });

          setState(() {
            _dataList = [];
            Future.delayed(Duration(milliseconds: 300), () {
              XsProgressHud.hide();
            });
          });
        } else {
          XsProgressHud.hide();
          showToast(msg, context);
        }
      });
    }
  }

  //未读数目
  // int _unReadCount() {
  //   return this.widget.recordType == 0
  //       ? (_account != null &&
  //               _account["love_count"] != null &&
  //               int.parse("${_account['love_count']}") > 0)
  //           ? int.parse("${_account['love_count']}")
  //           : 0
  //       : (_account != null &&
  //               _account["visitor_count"] != null &&
  //               int.parse("${_account['visitor_count']}") > 0)
  //           ? int.parse("${_account['visitor_count']}")
  //           : 0;
  // }

  @override
  void initState() {
    super.initState();

    // DartNotificationCenter.subscribe(
    //   channel: kAccountHandleNotification,
    //   observer: this,
    //   onNotification: (option) {
    //     //type 0 登录 1 请求账号信息刷新 2 登出 3 请求账号信息结束，刷新本地记录用户信息
    //     if (option["type"] == 3) {
    //       this._refreshAccount();
    //     }
    //   },
    // );

    // setState(() {
    //   _account = currentAccount;
    // });
  }

  @override
  void dispose() {
    super.dispose();

    _refreshController.dispose();
    // DartNotificationCenter.unsubscribe(observer: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rgba(248, 248, 248, 1),
      appBar: customAppBar(
        title: "谁" + (this.widget.recordType == 0 ? "喜欢我" : "看过我"),
        // titleView: Container(
        //   height: AppBar().preferredSize.height,
        //   alignment: Alignment.center,
        //   width: 260,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: <Widget>[
        //       Text(
        //         "谁" +
        //             (this.widget.recordType == 0 ? "喜欢我" : "看过我") +
        //             " ${_total > 0 ? ' $_total' : ''}",
        //         style: TextStyle(
        //           fontSize: 18,
        //           color: rgba(0, 0, 0, 1),
        //           fontWeight: FontWeight.bold,
        //         ),
        //       ),
        //       //未读数目
        //       _unReadCount() == 0
        //           ? Container(
        //               width: 0,
        //               height: 15,
        //             )
        //           : Container(
        //               padding: EdgeInsets.fromLTRB(4, 1, 4, 0),
        //               margin: EdgeInsets.fromLTRB(8, 0, 0, 0),
        //               height: 15,
        //               child: Text(
        //                 "${_unReadCount()}",
        //                 style: TextStyle(
        //                   fontSize: 10,
        //                   color: rgba(255, 255, 255, 1),
        //                 ),
        //               ),
        //               decoration: BoxDecoration(
        //                 color: rgba(255, 73, 54, 1),
        //                 borderRadius: BorderRadius.circular(15 / 2),
        //               ),
        //             ),
        //     ],
        //   ),
        // ),
        rightItems: _dataList.length == 0
            ? [
                Container(
                  width: 21,
                  height: 21,
                ),
              ]
            : [
                IconButton(
                  icon: Image.asset(
                    "images/record_clean@3x.png",
                    width: 21,
                    height: 21,
                  ),
                  onPressed: () {
                    GeneralAlert(
                      title: "清除记录",
                      content: "列表中访问记录将被清除，确定么？",
                      confirm: "清楚",
                      confirmHandle: () {
                        this._cleanRecords();
                      },
                    ).show(context);
                  },
                ),
              ],
        elevation: 0.5,
      ),
      body: functionRefresher(
        _refreshController,
        ListView.builder(
          itemBuilder: (context, index) {
            return AccountFunctionCell(
              account: _dataList[index],
              custom: _dataList[index]["human_visit_at"] != null
                  ? _dataList[index]["human_visit_at"]
                  : "",
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
      // body: Column(
      //   children: <Widget>[
      //     //类型数目
      //     this.widget.recordType == 0
      //         ? MessageCell(
      //             padding: EdgeInsets.fromLTRB(13.5, 12.5, 14.5, 12.5),
      //             redCount:
      //                 _account != null && _account["visitor_count"] != null
      //                     ? _account["visitor_count"]
      //                     : 0,
      //             title: "谁看过我",
      //             content: "看看有多少人想看你哟~",
      //             subContent: "",
      //             icon: "images/kan@3x.png",
      //           )
      //         : MessageCell(
      //             padding: EdgeInsets.fromLTRB(13.5, 12.5, 14.5, 12.5),
      //             redCount: (_account != null && _account["love_count"] != null)
      //                 ? _account["love_count"]
      //                 : 0,
      //             title: "谁喜欢我",
      //             content: "喜欢你的人有谁呢？",
      //             subContent: "",
      //             icon: "images/like@3x.png",
      //           ),
      //     //分割线
      //     Container(
      //       height: 1,
      //       padding: EdgeInsets.fromLTRB(13.5, 0, 0, 0),
      //       color: Colors.white,
      //       child: Divider(
      //         height: 1,
      //         color: rgba(231, 231, 231, 1),
      //       ),
      //     ),
      //     //列表内容
      //     Expanded(
      //       child: ,
      //     ),
      //   ],
      // ),
    );
  }
}
