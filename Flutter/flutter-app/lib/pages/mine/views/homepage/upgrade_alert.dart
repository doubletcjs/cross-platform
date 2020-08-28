import 'dart:async';
import 'dart:io';

import 'package:banner_view/banner_view.dart';
import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';
import '../../../function/general_dialog.dart';
import '../../../../public/public.dart';
import '../../../wallet/api/wallet_api.dart';
import '../../../function/base_webview.dart';
import '../../../../public/networking.dart';

class UpgradeAlert extends StatefulWidget {
  UpgradeAlert({Key key}) : super(key: key);

  @override
  _UpgradeAlertState createState() => _UpgradeAlertState();

  show(BuildContext context) {
    GeneralDialog().show(
      context,
      backgroundPadding: EdgeInsets.fromLTRB(9.5, 0, 9.5, 0),
      backgroundAlignment: Alignment.topCenter,
      borderRadius: BorderRadius.circular(7),
      containerContent: this,
      barrierDismissible: false,
      backgroundColor: rgba(1, 1, 1, 0.5),
      contentBackgroundColor: rgba(0, 0, 0, 0),
    );
  }
}

class _UpgradeAlertState extends State<UpgradeAlert> {
  int _currentIndex = 0;
  List _bannerColors = [
    [rgba(0, 128, 221, 1), rgba(61, 228, 200, 1)],
    [rgba(76, 48, 210, 1), rgba(235, 87, 182, 1)],
    [rgba(255, 49, 90, 1), rgba(251, 161, 74, 1)],
    [rgba(28, 205, 249, 1), rgba(20, 67, 212, 1)],
    [rgba(255, 82, 28, 1), rgba(255, 201, 74, 1)],
  ];

  List _bannerIcons = [
    "images/upgrade_biaoshi@3x.png",
    "images/upgrade_chakan@3x.png",
    "images/upgrade_like@3x.png",
    "images/upgrade_tuijie@3x.png",
    "images/upgrade_liwu@3x.png",
  ];

  List _bannerTitles = [
    "VIP尊贵标识",
    "无限查看",
    "查看访客和喜欢您的人",
    "更多推荐",
    "更多特权",
  ];

  List _bannerContents = [
    "尊贵的标识让您与众不同",
    "随心所欲特权查看无限畅快",
    "查看谁看过你谁喜欢过你不错过缘分",
    "每个月可以获得更多推荐优质用户",
    "更多VIP特权惊喜等您来发现",
  ];

  //获取会员金额列表
  List _memberList = [];
  void _appleMemberPayList() {
    XsProgressHud.show(context);
    WalletApi.applePayList(1, (data, msg) {
      if (data != null) {
        setState(() {
          _memberList = data;

          Future.delayed(Duration(milliseconds: 200), () {
            XsProgressHud.hide();
          });
        });
      } else {
        XsProgressHud.hide();
        showToast(msg, context);
      }
    });
  }

  //开通会员
  void _buyMember() {
    if (Platform.isIOS) {
      XsProgressHud.show(context);
      var info = _memberList[_currentIndex];
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
  }

  //恢复购买
  void _restoredPay() {
    if (Platform.isIOS) {
      XsProgressHud.show(context);
      FlutterInappPurchase.instance.getPurchaseHistory().then((list) {
        XsProgressHud.hide();
        kLog("list:$list");
      }).catchError((error) {
        XsProgressHud.hide();
        kLog("error:$error");
      });
    } else {
      showToast("暂时只支持iOS支付", context);
    }
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
        } else if (_state == TransactionState.failed) {
          FlutterInappPurchase.instance.finishTransaction(productItem);
          showToast("交易失败！", context);
        } else if (_state == TransactionState.restored) {
          showToast("已经购买过该商品！", context);
          //上传凭证
          this._uploadPayCredentials(productItem);
        } else if (_state == TransactionState.purchasing) {
          kLog("商品添加进列表");
          FlutterInappPurchase.instance.finishTransaction(productItem);
        } else {
          FlutterInappPurchase.instance.finishTransaction(productItem);
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

        //关闭交易事件
        FlutterInappPurchase.instance.finishTransaction(item);
        Future.delayed(Duration(milliseconds: 1000), () {
          XsProgressHud.hide();
          Navigator.of(context).pop();
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
      this._appleMemberPayList();

      if (Platform.isIOS) {
        this._initPlatformState();
      }
    });
  }

  @override
  void dispose() {
    this._endPurchase();
    super.dispose();
    kLog("dispose");
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(0, 28 + MediaQuery.of(context).padding.top,
          0, 23 + MediaQuery.of(context).padding.bottom),
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 211.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                ),
                child: BannerView(
                  _bannerColors.map((list) {
                    int index = _bannerColors.indexOf(list);
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(7),
                          topRight: Radius.circular(7),
                        ),
                        gradient: LinearGradient(
                          colors: list,
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                        ),
                      ),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 19,
                          ),
                          //升级会员
                          Text(
                            "升级会员",
                            style: TextStyle(
                              color: rgba(255, 255, 255, 1),
                              fontSize: 21,
                            ),
                          ),
                          SizedBox(
                            height: 20.5,
                          ),
                          //logo
                          Image.asset(
                            _bannerIcons[index],
                            width: 67,
                            height: 67,
                          ),
                          SizedBox(
                            height: 9,
                          ),
                          //标题
                          Text(
                            _bannerTitles[index],
                            style: TextStyle(
                              color: rgba(255, 255, 255, 1),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          //内容
                          Text(
                            _bannerContents[index],
                            style: TextStyle(
                              color: rgba(255, 255, 255, 1),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  intervalDuration: Duration(seconds: 5),
                  log: false,
                  indicatorMargin: 5,
                  indicatorNormal: Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      color: rgba(255, 255, 255, 0.3),
                      borderRadius: BorderRadius.circular(4 / 2),
                    ),
                  ),
                  indicatorSelected: Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      color: rgba(255, 255, 255, 1),
                      borderRadius: BorderRadius.circular(4 / 2),
                    ),
                  ),
                  indicatorBuilder: (context, indicator) {
                    return Stack(
                      children: <Widget>[
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            alignment: Alignment.center,
                            child: indicator,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(7),
                    bottomRight: Radius.circular(7),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 159,
                      child: ListView(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        scrollDirection: Axis.horizontal,
                        children: _memberList.map((item) {
                          String _month = "${item['info']['month']}";
                          String _price = "${item['info']['price']}";
                          String _monthPrice = "${item['info']['month_price']}";

                          int index = _memberList.indexOf(item);
                          Color _textColor = rgba(153, 153, 153, 1);
                          Color _priceColor = rgba(255, 45, 85, 0.5);
                          if (_currentIndex == index) {
                            _textColor = rgba(66, 66, 66, 1);
                            _priceColor = rgba(255, 45, 85, 1);
                          }
                          return InkWell(
                            onTap: () {
                              setState(() {
                                _currentIndex = index;
                              });
                            },
                            child: Container(
                              width: (MediaQuery.of(context).size.width -
                                      10 * 4 -
                                      9.5 * 2) /
                                  3,
                              margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                              decoration: BoxDecoration(
                                color: _currentIndex == index
                                    ? rgba(254, 247, 248, 1)
                                    : rgba(245, 245, 245, 1),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  width: 1.5,
                                  color: index == _currentIndex
                                      ? rgba(255, 88, 120, 1)
                                      : _currentIndex == index
                                          ? rgba(254, 247, 248, 1)
                                          : rgba(245, 245, 245, 1),
                                ),
                              ),
                              child: Stack(
                                children: <Widget>[
                                  Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        //月份数
                                        Text(
                                          "$_month",
                                          style: TextStyle(
                                            color: _textColor,
                                            fontSize: 36,
                                          ),
                                        ),
                                        Text(
                                          "个月",
                                          style: TextStyle(
                                            color: _textColor,
                                            fontSize: 15,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          "¥$_monthPrice/月",
                                          style: TextStyle(
                                            color: rgba(153, 153, 153, 1),
                                            fontSize: 14,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 13.5,
                                        ),
                                        Text(
                                          "¥$_price",
                                          style: TextStyle(
                                            color: _priceColor,
                                            fontSize: 19,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  item == "6"
                                      ? Positioned(
                                          left: 0,
                                          top: 0,
                                          right: 0,
                                          child: Container(
                                            height: 20,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  rgba(255, 114, 81, 1),
                                                  rgba(255, 44, 96, 1),
                                                ],
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                              ),
                                              borderRadius: BorderRadius.only(
                                                topLeft:
                                                    Radius.circular(12 - 1.5),
                                                topRight:
                                                    Radius.circular(12 - 1.5),
                                              ),
                                            ),
                                            child: Text(
                                              "最受欢迎",
                                              style: TextStyle(
                                                color: rgba(255, 255, 255, 1),
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(
                      height: 21.5,
                    ),
                    //继续
                    Container(
                      height: 44,
                      margin: EdgeInsets.fromLTRB(46, 0, 46, 0),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            rgba(255, 114, 81, 1),
                            rgba(255, 44, 96, 1),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(44 / 2),
                      ),
                      child: FlatButton(
                        onPressed: () {
                          this._buyMember();
                        },
                        child: Text(
                          "继续",
                          style: TextStyle(
                            color: rgba(255, 255, 255, 1),
                            fontSize: 17,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(44 / 2),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 21,
                    ),
                    //再想想
                    Material(
                      color: rgba(0, 0, 0, 0),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "再想想",
                          style: TextStyle(
                            color: rgba(153, 153, 153, 1),
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.5,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(15.5, 11.5, 15.5, 0),
          child: Column(
            children: <Widget>[
              Text(
                "已有1,683,467人开通VIP。订阅可随时取消。购买订阅的费用将从您的iTunes账户收取，到期前24小时会自动扣费并续订服务，购买后随时前往iTunes商店的设置页面取消订阅。点击按钮即表示同意我们的",
                style: TextStyle(
                  color: rgba(189, 189, 189, 1),
                  fontSize: 12,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: ["使用条款", "隐私政策", "恢复购买"].map((item) {
                  return InkWell(
                    onTap: () {
                      if (item == "恢复购买") {
                        this._restoredPay();
                      } else if (item == "隐私政策") {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return BaseWebView(
                                url: "${kServerURL + "/page/" + "1"}",
                                title: "隐私政策",
                              );
                            },
                          ),
                        );
                      } else if (item == "使用条款") {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return BaseWebView(
                                url: "${kServerURL + "/page/" + "7"}",
                                title: "使用条款",
                              );
                            },
                          ),
                        );
                      }
                    },
                    child: Text(
                      item,
                      style: TextStyle(
                        color: rgba(255, 255, 255, 1),
                        fontSize: 12,
                        decoration: TextDecoration.underline,
                        decorationColor: rgba(204, 204, 204, 1),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
