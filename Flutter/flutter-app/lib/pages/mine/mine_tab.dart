import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../near/near_matching.dart';
import 'views/mine_cell.dart';
import 'views/mine_header.dart';
import '../../public/public.dart';
import 'certification.dart';
import '../wallet/wallet_page.dart';
import '../setting/setting_page.dart';
import 'views/homepage/upgrade_alert.dart';
import '../gift/gift_page.dart';
import '../account/api/account_api.dart';

class MinePage extends StatefulWidget {
  MinePage({Key key}) : super(key: key);

  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  Map _account = {};
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
              padding: EdgeInsets.zero,
              children: [
                MineHeader(),
                Container(
                  margin: EdgeInsets.fromLTRB(14, 10, 14, 0),
                  child: ClipRRect(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        MineCell(
                          icon: "images/vip@3x.png",
                          text: "会员",
                          valueWidget: (_account["vip_type"] != null &&
                                  _account["vip_type"] == 1)
                              ? Container(
                                  padding: EdgeInsets.fromLTRB(0, 0, 13, 0),
                                  child: Text(
                                    "${_account['vip_validity']} 到期",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: rgba(166, 166, 166, 1),
                                    ),
                                  ),
                                )
                              : Container(), //vip类型 0非会员 1普通会员 2暗瘾会员
                          tapHandle: () {
                            UpgradeAlert().show(context);
                          },
                        ),
                        MineCell(
                          icon: "images/jinbi@3x.png",
                          text: "钱包",
                          tapHandle: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) {
                                return WalletPage();
                              }),
                            );
                          },
                        ),
                        MineCell(
                          icon: "images/renzheng@3x.png",
                          text: "认证",
                          valueWidget: (_account["audit_status"] != null &&
                                  _account["audit_status"] != 0)
                              ? Container(
                                  padding: EdgeInsets.fromLTRB(0, 0, 13, 0),
                                  child: Text(
                                    "${_account['audit_status'] == 1 ? '审核中' : _account['audit_status'] == 3 ? '已认证' : '认证失败'}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: _account["audit_status"] == 2
                                          ? rgba(254, 53, 92, 1)
                                          : rgba(166, 166, 166, 1),
                                    ),
                                  ),
                                )
                              : Container(), //audit_status	0:未认证 1：审核中 2：认证失败 3：认证成功
                          tapHandle: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) {
                                return CertificationPage();
                              }),
                            );
                          },
                        ),
                        MineCell(
                          icon: "images/setting_gift.png",
                          text: "礼物",
                          tapHandle: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) {
                                return GiftPage();
                              }),
                            );
                          },
                        ),
                        MineCell(
                          icon: "images/shezhi@3x.png",
                          text: "设置",
                          tapHandle: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) {
                                return SettingPage();
                              }),
                            );
                          },
                        ),
                        // MineCell(
                        //   icon: "images/shezhi@3x.png",
                        //   text: "匹配",
                        //   showLine: false,
                        //   tapHandle: () {
                        //     Navigator.of(context).push(
                        //       MaterialPageRoute(builder: (context) {
                        //         return NearMatchingPage();
                        //       }),
                        //     );
                        //   },
                        // ),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: rgba(0, 0, 0, 0.06),
                          offset: Offset(0, 5), //阴影xy轴偏移量
                          blurRadius: 20.0, //阴影模糊程度
                          spreadRadius: 1 //阴影扩散程度
                          ),
                    ],
                  ),
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
