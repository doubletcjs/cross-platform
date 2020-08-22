import 'dart:async';
import 'dart:io';

import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import '../../public/public.dart';
import 'recharge_record.dart';
import 'api/wallet_api.dart';
import '../account/api/account_api.dart';

class WalletPage extends StatefulWidget {
  WalletPage({Key key}) : super(key: key);

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  //金币信息
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
  // List<IAPItem> _onLineIAPItems = [];
  void _applePayList() {
    XsProgressHud.show(context);
    WalletApi.applePayList(2, (data, msg) {
      if (data != null) {
        setState(() {
          _payList = data;

          Future.delayed(Duration(milliseconds: 200), () {
            XsProgressHud.hide();
          });

          // if (Platform.isIOS) {
          //   this._handleOnlineProducts();
          // } else {
          //   Future.delayed(Duration(milliseconds: 200), () {
          //     XsProgressHud.hide();
          //   });
          // }
        });
      } else {
        XsProgressHud.hide();
        showToast(msg, context);
      }

      _refreshController.refreshCompleted();
    });
  }

  // //获取商品
  // Future _handleOnlineProducts() async {
  //   final List<String> _productLists = [];
  //   _payList.forEach((info) {
  //     _productLists.add("${info['id']}");
  //   });
  //   List<IAPItem> items =
  //       await FlutterInappPurchase.instance.getProducts(_productLists);

  //   setState(() {
  //     _onLineIAPItems = items;
  //     kLog("${_onLineIAPItems.toString()}");
  //     Future.delayed(Duration(milliseconds: 200), () {
  //       XsProgressHud.hide();
  //     });
  //   });
  // }

  Map _account = currentAccount;
  //获取用户信息
  void _refreshAccount() {
    AccountApi.profile((data, msg) {
      if (data != null) {
        kLog("刷新用户信息");
        currentAccount = Map.from(data);
        setState(() {
          _account = currentAccount;
        });
      }

      this._applePayList();
    });
  }

  //购买金币
  void _buyCoin(info) {
    if (Platform.isIOS) {
      XsProgressHud.show(context);
      FlutterInappPurchase.instance
          .getProducts(["${info['id']}"]).then((items) {
        kLog("items:$items");
        if (items != null && items.length > 0) {
          Map<String, dynamic> json = {
            "price": "${info['info']['price']}",
            "productId": "${info['id']}",
          };

          kLog("json:$json");
          IAPItem item = IAPItem.fromJSON(json);
          FlutterInappPurchase.instance.requestPurchase(item.productId);
        } else {
          XsProgressHud.hide();
          showToast("苹果服务异常，请稍后重试！", context);
        }
      }).catchError((error) {
        XsProgressHud.hide();
        showToast("$error", context);
      }).timeout(Duration(seconds: 30), onTimeout: () {
        XsProgressHud.hide();
        showToast("苹果服务超时，请稍后重试！", context);
      });
    } else {
      showToast("暂时只支持iOS支付", context);
    }
    // if (_onLineIAPItems != null && _onLineIAPItems.length > 0) {
    //   if (Platform.isIOS) {
    //     XsProgressHud.show(context);
    //     Map<String, dynamic> json = {
    //       "price": "${info['info']['price']}",
    //       "productId": "${info['id']}",
    //     };

    //     kLog("json:$json");
    //     IAPItem item = IAPItem.fromJSON(json);
    //     FlutterInappPurchase.instance.requestPurchase(item.productId);
    //   } else {
    //     showToast("暂时只支持iOS支付", context);
    //   }
    // } else {
    //   showToast("苹果服务异常，请稍后重试！", context);
    // }
  }

  //内付费
  StreamSubscription _purchaseUpdatedSubscription;
  StreamSubscription _purchaseErrorSubscription;
  //初始化支付
  Future<void> _initPlatformState() async {
    // prepare
    var result = await FlutterInappPurchase.instance.initConnection;
    kLog("result: $result");

    // 判断容器是否加载
    if (!mounted) return;

    // 更新购买订阅消息
    _purchaseUpdatedSubscription =
        FlutterInappPurchase.purchaseUpdated.listen((productItem) {
      XsProgressHud.hide();
      if (Platform.isIOS) {
        TransactionState _state = productItem.transactionStateIOS;
        if (_state == TransactionState.purchased) {
          kLog("购买完成,向自己的服务器验证");
          //上传凭证
          this._uploadPayCredentials(productItem);
          //关闭交易事件
          FlutterInappPurchase.instance.finishTransaction(productItem);
        } else if (_state == TransactionState.failed) {
          FlutterInappPurchase.instance.finishTransaction(productItem);
          showToast("交易失败！", context);
        } else if (_state == TransactionState.restored) {
          //上传凭证
          this._uploadPayCredentials(productItem);
          FlutterInappPurchase.instance.finishTransaction(productItem);
          showToast("已经购买过该商品！", context);
        } else if (_state == TransactionState.purchasing) {
          kLog("商品添加进列表");
        }
      }
      kLog("purchase-updated: ${productItem.toString()}");
    });
    // 购买报错订阅消息
    _purchaseErrorSubscription =
        FlutterInappPurchase.purchaseError.listen((purchaseError) {
      XsProgressHud.hide();
      showToast(purchaseError.message, context);
      kLog("purchase-error: $purchaseError");
    });
  }

  //结束支付
  Future<void> _endPurchase() async {
    await FlutterInappPurchase.instance.endConnection;
    _purchaseUpdatedSubscription.cancel();
    _purchaseUpdatedSubscription = null;
    _purchaseErrorSubscription.cancel();
    _purchaseErrorSubscription = null;
  }

  //上传支付凭证
  void _uploadPayCredentials(PurchasedItem item) {
    XsProgressHud.show(context);
    WalletApi.applePay("${item.transactionReceipt}", (data, msg) {
      if (data != null) {
        //更新用户信息
        DartNotificationCenter.post(
            channel: kAccountHandleNotification,
            options: {
              "type": 1,
            });

        Future.delayed(Duration(milliseconds: 400), () {
          XsProgressHud.hide();
        });
      } else {
        XsProgressHud.hide();
        showToast(msg, context);
      }
    });
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 200), () {
      if (Platform.isIOS) {
        this._initPlatformState();
      }

      _refreshController.requestRefresh();
    });
  }

  @override
  void dispose() {
    this._endPurchase();
    super.dispose();
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
      body: functionRefresher(
        _refreshController,
        ListView(
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
                                      onPressed: () {
                                        this._buyCoin(info);
                                      },
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
                "1.金币可以用于查看认证视频。\n2.金币可以用于查看联系方式。",
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
        onRefresh: () {
          this._refreshAccount();
        },
        enableLoadMore: false,
      ),
    );
  }
}
