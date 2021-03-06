import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hksy_flutter/function/paycode/paycodeinput.dart';
import 'package:hksy_flutter/pages/calculate/hkcrule.dart';
import 'package:hksy_flutter/pages/coin/api/coinapi.dart';
import 'package:hksy_flutter/pages/coin/transfercomplete.dart';
import 'package:hksy_flutter/public/public.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';

class CoinTransfer extends StatefulWidget {
  bool isHKC = false;
  CoinTransfer({Key key, this.isHKC = false}) : super(key: key);

  @override
  _CoinTransferState createState() => _CoinTransferState();
}

class _CoinTransferState extends State<CoinTransfer> {
  TextEditingController _countEditingController = TextEditingController();
  TextEditingController _phoneEditingController = TextEditingController();
  Map _account = {};

  void _refreshAccount() {
    setState(() {
      _account = currentAcctount;
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

  void _rolloutAll() {
    setState(() {
      _countEditingController.text = "${_account['coin']}";
    });
  }

  void _confirmRollout() {
    String msg = "";
    if (isStringEmpty(_countEditingController.text) == true ||
        double.parse("${_countEditingController.text}") == 0.0) {
      msg = "请输入转出金额";
    } else if (isStringEmpty(_phoneEditingController.text) == true) {
      msg = "请输入账户";
    } else if (regularMatch(_phoneEditingController.text, kPhoneRegExp) ==
        false) {
      msg = "请输入正确的手机号";
    } else if (_account["phone"] == _phoneEditingController.text) {
      msg = "无法转入当前登录账户";
    }

    if (isStringEmpty(msg) == false) {
      showToast(msg, context);

      return;
    }

    functionAlertView(
      context,
      title: "您确认转账到 ${_phoneEditingController.text} ？",
      content: "转账金币：${_countEditingController.text}个",
      contentTextAlign: TextAlign.center,
      titleTextStyle: TextStyle(
        fontSize: 15,
        color: rgba(51, 51, 51, 1),
      ),
      titlePadding: EdgeInsets.fromLTRB(20, 40, 20, 0),
      contentTextStyle: TextStyle(
        fontSize: 15,
        color: rgba(23, 96, 255, 1),
      ),
      contentPadding: EdgeInsets.fromLTRB(20, 20.5, 20, 39),
      cancel: "取消",
      confirm: "确认",
      confirmHandle: () {
        Future.delayed(
          Duration(milliseconds: 400),
          () {
            if (this.widget.isHKC) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return TransferComplete(
                      completeType: 4,
                    );
                  },
                ),
              );

              Future.delayed(Duration(milliseconds: 400), () {
                this._emptyInput();
              });
            } else {
              PaycodeInput(
                inputHandle: (password) {
                  XsProgressHud hud = initHUD(context);
                  userID((id) {
                    if (isStringEmpty(id) == false) {
                      CoinApi.transfer(id, _phoneEditingController.text,
                          password, _countEditingController.text, (data, msg) {
                        hideHUD(hud);
                        if (data != null) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return TransferComplete(
                                  completeType: 3,
                                );
                              },
                            ),
                          );

                          Future.delayed(Duration(milliseconds: 400), () {
                            this._emptyInput();
                          });
                        } else {
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
          },
        );
      },
    );
  }

  void _emptyInput() {
    _countEditingController.text = "";
    _phoneEditingController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      appBar: customAppBar(
        title: this.widget.isHKC ? "HKC互转" : "金币互转",
        brightness: Brightness.dark,
        backgroundColor: kMainBackgroundColor,
        color: Colors.white,
        rightItems: this.widget.isHKC
            ? [
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return HkcRulePage();
                      }),
                    );
                  },
                  child: Text(
                    "HKC规则",
                    style: TextStyle(
                      fontSize: 15,
                      color: rgba(255, 255, 255, 1),
                    ),
                  ),
                ),
              ]
            : [],
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
                    this.widget.isHKC ? "可用HKC" : "金币资产",
                    style: TextStyle(
                      fontSize: 15,
                      color: rgba(145, 152, 173, 1),
                    ),
                  ),
                  Text(
                    this.widget.isHKC
                        ? "342580.48HKC"
                        : "${_account['coin']}" + "个",
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
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
                    padding: EdgeInsets.fromLTRB(20, 20.5, 20, 0),
                    decoration: BoxDecoration(
                      color: rgba(28, 35, 63, 1),
                      borderRadius: BorderRadius.circular(7.5),
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            this.widget.isHKC ? "转出HKC" : "转出数量",
                            style: TextStyle(
                              fontSize: 18,
                              color: rgba(255, 255, 255, 1),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5.5,
                        ),
                        Container(
                          height: 60.5,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: rgba(145, 152, 173, 0.2),
                                width: 0.5,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: TextField(
                                  controller: _countEditingController,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: rgba(255, 255, 255, 1),
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    labelText: this.widget.isHKC
                                        ? "可转出342580.48HKC"
                                        : "可转出${_account['coin']}个",
                                    labelStyle: TextStyle(
                                      fontSize: 13,
                                      color: rgba(145, 152, 173, 1),
                                    ),
                                    contentPadding:
                                        EdgeInsets.fromLTRB(0, 0, 0, 13),
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
                        ),
                        Container(
                          height: 60.5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "对方账户",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: rgba(255, 255, 255, 1),
                                ),
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: TextField(
                                    controller: _phoneEditingController,
                                    textAlign: TextAlign.right,
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: rgba(255, 255, 255, 1),
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      labelText: "请输入对方账户手机号码",
                                      labelStyle: TextStyle(
                                        fontSize: 13,
                                        color: rgba(145, 152, 173, 1),
                                      ),
                                      contentPadding:
                                          EdgeInsets.fromLTRB(0, 0, 0, 13),
                                    ),
                                    inputFormatters: [
                                      WhitelistingTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(11),
                                    ],
                                    keyboardType: TextInputType.number,
                                  ),
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
                  "确认转出",
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
