import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/material.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';
import '../../public/public.dart';
import 'rechargerecord.dart';
import 'api/walletapi.dart';

class WalletPage extends StatefulWidget {
  WalletPage({Key key}) : super(key: key);

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  List _payList = [];
  //充值记录
  void _rechargeRecord() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return RechargeRecord();
      }),
    );
  }

  //获取金币充值金额列表
  void _applePayList() {
    XsProgressHud.show(context);
    WalletApi.applePayList(2, (data, msg) {
      if (data != null) {
        setState(() {
          _payList = data;

          Future.delayed(Duration(milliseconds: 400), () {
            XsProgressHud.hide();
          });
        });
      } else {
        XsProgressHud.hide();
        showToast(msg, context);
      }
    });
  }

  Map _account = {};
  //获取用户信息
  void _refreshAccount() {
    setState(() {
      _account = currentAcctount;
    });
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 200), () {
      this._applePayList();
    });

    DartNotificationCenter.subscribe(
      channel: kAccountHandleNotification,
      observer: this,
      onNotification: (option) {
        //type 0 登录 1 请求账号信息刷新 2 登出 3 请求账号信息结束，刷新本地记录用户信息
        if (option["type"] == 3) {
          this._refreshAccount();
        }
      },
    );

    setState(() {
      _account = currentAcctount;
    });
  }

  @override
  void dispose() {
    super.dispose();

    DartNotificationCenter.unsubscribe(observer: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      appBar: customAppBar(
        title: "钱包",
        elevation: 0.5,
        rightItems: [
          Container(
            padding: EdgeInsets.fromLTRB(0, 8, 15, 8),
            child: InkWell(
              onTap: () {
                this._rechargeRecord();
              },
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "充值记录",
                  style: TextStyle(
                    color: rgba(51, 51, 51, 1),
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          //头部背景
          Stack(
            children: <Widget>[
              //背景图片
              Image.asset(
                "images/wallet_backgroud@3x.png",
              ),
              //我的金币数
              Positioned(
                bottom: 16 + 19.0,
                left: 60,
                right: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    //金币数
                    Text(
                      "${_account['number_of_balance']}",
                      style: TextStyle(
                        fontSize: 31,
                        color: rgba(53, 33, 0, 1),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    //我的金币
                    Text(
                      "我的金币",
                      style: TextStyle(
                        fontSize: 14,
                        color: rgba(53, 33, 0, 1),
                      ),
                    ),
                  ],
                ),
              ),
              //圆角
              Positioned(
                bottom: -1,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    color: Colors.white,
                  ),
                  height: 19,
                ),
              )
            ],
          ),
          //金币、金额列表
          Container(
            padding: EdgeInsets.fromLTRB(15, 3, 0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Column(
                  children: _payList.map((info) {
                    return Container(
                      height: 63.5,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: rgba(231, 231, 231, 1),
                            width: 0.25,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                //金币图标
                                Image.asset(
                                  "images/wallet_jinbi@3x.png",
                                  width: 29,
                                  height: 29,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(
                                    "${info['name']}",
                                    style: TextStyle(
                                      color: rgba(51, 51, 51, 1),
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          //价格
                          Container(
                            height: 26,
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.fromLTRB(18, 3, 18, 2),
                                  child: Text(
                                    "${info['info']['price']}元",
                                    style: TextStyle(
                                      color: rgba(255, 255, 255, 1),
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: FlatButton(
                                    onPressed: () {},
                                    child: null,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(31 / 2),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  rgba(255, 44, 96, 1),
                                  rgba(255, 114, 81, 1),
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(31 / 2),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16.5,
          ),
          //金币使用说明
          Container(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Text(
              "金币使用说明：",
              style: TextStyle(
                color: rgba(51, 51, 51, 1),
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 9,
          ),
          //说明
          Container(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Text(
              "1.金币可以用于查看认真视频。（对方喜欢你免费查看）\n2.金币可以用于查看联系方式。（对方喜欢你免费查看）\n3.如果对方喜欢你，查看联系方式和认证视频、信使服务、聊天等等所有功能都是自由使用。",
              style: TextStyle(
                color: rgba(153, 153, 153, 1),
                fontSize: 12,
              ),
            ),
          ),
          SizedBox(
            height: 109.5,
          ),
        ],
      ),
    );
  }
}
