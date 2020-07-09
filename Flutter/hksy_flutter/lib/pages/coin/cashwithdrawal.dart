import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hksy_flutter/function/paycode/paycodeinput.dart';
import 'package:hksy_flutter/pages/coin/api/coinapi.dart';
import 'package:hksy_flutter/pages/coin/transfercomplete.dart';
import 'package:hksy_flutter/public/public.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';

class CashWithdrawal extends StatefulWidget {
  CashWithdrawal({Key key}) : super(key: key);

  @override
  _CashWithdrawalState createState() => _CashWithdrawalState();
}

class _CashWithdrawalState extends State<CashWithdrawal> {
  TextEditingController _numberEditingController = TextEditingController();
  Map _account = {};
  double _coin = 0.0;

  void _rolloutAll() {
    setState(() {
      _numberEditingController.text = "$_coin";
    });
  }

  void _confirmRollout() {
    if (isStringEmpty(_numberEditingController.text) == true ||
        double.parse(_numberEditingController.text) <= 0.0) {
      showToast("请输入转出金额", context);
      return;
    }
    FocusScope.of(context).requestFocus(FocusNode());

    PaycodeInput(
      inputHandle: (password) {
        XsProgressHud hud = initHUD(context);
        userID((id) {
          if (isStringEmpty(id) == false) {
            CoinApi.withdrawCash(id, _numberEditingController.text, password,
                (data, msg) {
              if (data != null) {
                DartNotificationCenter.post(
                    channel: kRefreshAccountNotification);
                Future.delayed(Duration(milliseconds: 800), () {
                  hideHUD(hud);
                  this._emptyInput();

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return TransferComplete(
                          completeType: 2,
                        );
                      },
                    ),
                  );
                });
              } else {
                hideHUD(hud);
                showToast(msg, context);
              }
            });
          } else {
            hideHUD(hud);
          }
        });
      },
    ).show(context);
  }

  void _emptyInput() {
    _numberEditingController.text = "";
  }

  void _refreshAccount() {
    setState(() {
      _account = currentAcctount;
      _coin =
          double.parse(double.parse("${_account['coin']}").toStringAsFixed(2));
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
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      appBar: customAppBar(
        title: "现金提现",
        brightness: Brightness.dark,
        backgroundColor: kMainBackgroundColor,
        color: Colors.white,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(12, 24.5, 12, 37),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "金币资产",
                    style: TextStyle(
                      fontSize: 15,
                      color: rgba(145, 152, 173, 1),
                    ),
                  ),
                  Text(
                    "$_coin" + "个",
                    style: TextStyle(
                      fontSize: 15,
                      color: rgba(145, 152, 173, 1),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
                    padding: EdgeInsets.fromLTRB(20, 20.5, 10.5, 0),
                    decoration: BoxDecoration(
                      color: rgba(28, 35, 63, 1),
                      borderRadius: BorderRadius.circular(7.5),
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "提现数量",
                            style: TextStyle(
                              fontSize: 18,
                              color: rgba(255, 255, 255, 1),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: TextField(
                                  controller: _numberEditingController,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: rgba(255, 255, 255, 1),
                                  ),
                                  decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    hintText: "可提现$_coin" + "个",
                                    hintStyle: TextStyle(
                                      fontSize: 13,
                                      color: rgba(145, 152, 173, 1),
                                    ),
                                  ),
                                  inputFormatters: [
                                    WhitelistingTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(18),
                                  ],
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Material(
                                color: rgba(28, 35, 63, 1),
                                child: InkWell(
                                  onTap: () {
                                    this._rolloutAll();
                                  },
                                  child: Text(
                                    "全部转出",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: rgba(23, 96, 255, 1),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 0.5,
                                color: rgba(145, 152, 173, 0.2),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 20.5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "提现到银行卡",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: rgba(255, 255, 255, 1),
                                ),
                              ),
                              Text(
                                "招商银行",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: rgba(255, 255, 255, 1),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(
                  12, 0, 12, 48.5 + MediaQuery.of(context).padding.bottom),
              height: 49,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: rgba(23, 96, 255, 1),
                borderRadius: BorderRadius.circular(7.5),
              ),
              child: FlatButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  this._confirmRollout();
                },
                child: Text(
                  "确认",
                  style: TextStyle(
                    color: rgba(255, 255, 255, 1),
                    fontSize: 15,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.5),
                ),
              ),
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
