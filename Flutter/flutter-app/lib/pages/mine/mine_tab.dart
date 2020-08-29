import 'package:common_utils/common_utils.dart';
import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../setting/feedback.dart';
import 'views/mine_cell.dart';
import 'views/mine_header.dart';
import '../../public/public.dart';
import '../../public/networking.dart';
import '../account/api/account_api.dart';
import '../function/base_webview.dart';
import '../mine/views/homepage/cover_grid_view.dart';
import '../mine/mine_info_page.dart';

class MinePage extends StatefulWidget {
  MinePage({Key key}) : super(key: key);

  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  Map _account;
  //刷新用户信息
  void _refreshAccount() {
    AccountApi.profile((data, msg) {
      if (data != null) {
        kLog("刷新用户信息");
        currentAccount = Map.from(data);
        setState(() {
          _account = currentAccount;
        });

        DartNotificationCenter.post(
            channel: kAccountHandleNotification,
            options: {
              "type": 3,
            });
      }

      _refreshController.refreshCompleted();
    });
  }

  void _readAccount() {
    setState(() {
      _account = currentAccount;
    });
  }

  //个人资料
  void _personalInfo() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return MineInfoPage();
      }),
    );
  }

  @override
  void initState() {
    super.initState();

    // Future.delayed(Duration(milliseconds: 500), () {
    //   _refreshController.requestRefresh();
    // });

    DartNotificationCenter.subscribe(
      channel: kAccountHandleNotification,
      observer: this,
      onNotification: (option) {
        //type 0 登录 1 请求账号信息刷新 2 登出 3 请求账号信息结束，刷新本地记录用户信息
        if (option["type"] == 3) {
          this._readAccount();
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();

    DartNotificationCenter.unsubscribe(observer: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rgba(248, 248, 248, 1),
      body: Stack(
        children: <Widget>[
          transparentAppBar(
            brightness: Brightness.light,
          ),
          functionRefresher(
            _refreshController,
            ListView(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
              children: [
                // 头
                MineHeader(),
                (_account == null || ObjectUtil.isEmpty(_account["photo"]))
                    ? Container()
                    : Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                        padding: EdgeInsets.fromLTRB(10.5, 12, 10.5, 16.5),
                        decoration: BoxDecoration(
                          color: rgba(255, 255, 255, 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: InkWell(
                          onTap: () {
                            this._personalInfo();
                          },
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "我的相册",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: rgba(38, 38, 38, 1),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "添加相册快速增加曝光度",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: rgba(254, 52, 90, 1),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 9.5,
                              ),
                              CoverGridView(
                                coverList: List.from(_account["photo"]),
                                bottomSpace: 0,
                                gridWidth: MediaQuery.of(context).size.width -
                                    10.5 * 2 -
                                    10 * 2,
                              ),
                            ],
                          ),
                        ),
                      ),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: ClipRRect(
                        child: MineCell(
                          icon: "images/icon_mine_helpcenter@3x.png",
                          text: "帮助中心",
                          showLine: false,
                          tapHandle: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return BaseWebView(
                                    url: "${kServerURL + "/page/" + "8"}",
                                    title: "帮助中心",
                                  );
                                },
                              ),
                            );
                          },
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: rgba(0, 0, 0, 0.06),
                            offset: Offset(0, 2),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: ClipRRect(
                        child: MineCell(
                          icon: "images/icon_mine_feedback@3x.png",
                          text: "意见反馈",
                          showLine: false,
                          tapHandle: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) {
                                return FeedBackPage();
                              }),
                            );
                          },
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: rgba(0, 0, 0, 0.06),
                            offset: Offset(0, 2),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ClipRRect(
                        child: MineCell(
                          icon: "images/icon_mine_cooperation@3x.png",
                          text: "商务合作",
                          showLine: false,
                          tapHandle: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return BaseWebView(
                                    url: "${kServerURL + "/page/" + "9"}",
                                    title: "商务合作",
                                  );
                                },
                              ),
                            );
                          },
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: rgba(0, 0, 0, 0.06),
                            offset: Offset(0, 2),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            onRefresh: () {
              this._refreshAccount();
            },
            enableLoadMore: false,
          ),
        ],
      ),
    );
  }
}
