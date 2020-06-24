import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/material.dart';
import 'package:hksy_flutter/function/actionsheet.dart';
import 'package:hksy_flutter/pages/coin/cashrecharge.dart';
import 'package:hksy_flutter/pages/coin/cashwithdrawal.dart';
import 'package:hksy_flutter/pages/coin/cointransfer.dart';
import 'package:hksy_flutter/pages/coin/usdtrecharge.dart';
import 'package:hksy_flutter/pages/coin/usdtwithdrawal.dart';
import 'package:hksy_flutter/public/public.dart';

class CoinHeader extends StatefulWidget {
  CoinHeader({Key key}) : super(key: key);

  @override
  _CoinHeaderState createState() => _CoinHeaderState();
}

class _CoinHeaderState extends State<CoinHeader> {
  var _coinString;

  List<String> _functions = [
    "提现",
    "充值",
    "互转",
  ];
  List<String> _images = [
    "images/ico_mygold_list_cashout@3x.png",
    "images/ico_mygold_recharge_white@3x.png",
    "images/ico_mygold_transfer_white@3x.png",
  ];

  void _refreshAccount() {
    setState(() {
      _coinString = currentAcctount["coin"];
    });
  }

  @override
  void initState() {
    super.initState();

    DartNotificationCenter.subscribe(
      channel: kUpdateAccountNotification,
      observer: this,
      onNotification: (options) {
        this._refreshAccount();
      },
    );

    this._refreshAccount();
  }

  @override
  void dispose() {
    super.dispose();

    DartNotificationCenter.unsubscribe(observer: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 113.5,
              child: Image.asset(
                "images/gold_background@3x.png",
                fit: BoxFit.fill,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(24.5, 19, 24.5, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "金币资产（个）",
                    style: TextStyle(
                      fontSize: 15,
                      color: rgba(255, 255, 255, 1),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    _coinString != null ? "$_coinString" : "0",
                    style: TextStyle(
                      fontSize: 30,
                      color: rgba(255, 255, 255, 1),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 26,
        ),
        Row(
          children: _functions.map(
            (function) {
              var index = _functions.indexOf(function);
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (index == 0 || index == 1) {
                      String action = "提现";
                      if (index == 1) {
                        action = "充值";
                      }
                      ActionSheet(
                        titles: ["USDT" + action, "现金" + action],
                        handle: (isCancel, aIndex) {
                          if (aIndex == 0) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return index == 0
                                      ? UsdtWithdrawal()
                                      : UsdtRecharge();
                                },
                              ),
                            );
                          } else if (aIndex == 1) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return index == 0
                                      ? CashWithdrawal()
                                      : CashRecharge();
                                },
                              ),
                            );
                          }
                        },
                      ).show(context);
                    } else {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return CoinTransfer();
                          },
                        ),
                      );
                    }
                  },
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          _images[index],
                          width: 23,
                          fit: BoxFit.fitWidth,
                        ),
                        SizedBox(
                          width: 11,
                        ),
                        Text(
                          function,
                          style: TextStyle(
                            fontSize: 15,
                            color: rgba(255, 255, 255, 1),
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      border: index < _functions.length - 1
                          ? Border(
                              right: BorderSide(
                                color: rgba(255, 255, 255, 0.2),
                                width: 1,
                              ),
                            )
                          : Border(),
                    ),
                  ),
                ),
              );
            },
          ).toList(),
        ),
        SizedBox(
          height: 21,
        ),
      ],
    );
  }
}
