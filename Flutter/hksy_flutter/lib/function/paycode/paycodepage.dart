import 'dart:async';

import 'package:common_utils/common_utils.dart';
import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hksy_flutter/function/account/api/accountapi.dart';
import 'package:hksy_flutter/function/infosectioncell.dart';
import 'package:hksy_flutter/public/public.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';

class PaycodePage extends StatefulWidget {
  bool isReset = false;
  PaycodePage({Key key, this.isReset = false}) : super(key: key);

  @override
  _PaycodePageState createState() => _PaycodePageState();
}

class _PaycodePageState extends State<PaycodePage> {
  Map _account = {};
  TextEditingController _passwordEditingController = TextEditingController();
  TextEditingController _verifyPasswordEditingController =
      TextEditingController();
  TextEditingController _verifyCodeEditingController = TextEditingController();

  String _sessionId = "";
  String _verifyString = "获取验证码";

  int _countDownSecond = 0;
  Timer _countdownTimer;

  void _startCountDown() {
    setState(() {
      _countDownSecond = 60;
      _verifyString = "$_countDownSecond" + "s";

      _countdownTimer = Timer.periodic(
        Duration(seconds: 1),
        (timer) {
          setState(() {
            if (_countDownSecond > 0) {
              _countDownSecond -= 1;
              _verifyString = "$_countDownSecond" + "s";
            } else {
              _verifyString = "获取验证码";
              _countdownTimer.cancel();
              _countdownTimer = null;
              _countDownSecond = 0;
            }
          });
        },
      );
    });
  }

  void _getVerifyCode() {
    if (_countDownSecond != 0) {
      return;
    }

    FocusScope.of(context).requestFocus(FocusNode());

    XsProgressHud hud = initHUD(context);
    AccountApi.sendMessage(
      _account["phone"],
      (data, msg) {
        hideHUD(hud);
        if (data != null) {
          if (data["sessionId"] == null || data["sessionId"].length == 0) {
            showToast("获取验证码失败!", context);
          } else {
            setState(() {
              _sessionId = data["sessionId"];
              // 开始倒计时
              this._startCountDown();
            });
          }
        } else {
          showToast(msg, context);
        }
      },
    );
  }

  void _refreshAccount() {
    setState(() {
      _account = currentAcctount;
    });
  }

  Widget _textField(
    String placeholder, {
    int maxLength = 6,
    bool obscureText = true,
    TextAlign textAlign = TextAlign.right,
    TextEditingController controller,
  }) {
    return TextField(
      style: TextStyle(
        color: rgba(255, 255, 255, 1),
        fontSize: 13,
      ),
      controller: controller,
      obscureText: obscureText,
      scrollPadding: EdgeInsets.zero,
      textAlign: textAlign,
      inputFormatters: [
        WhitelistingTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(maxLength),
      ],
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 11.5),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        hintText: placeholder,
        hintStyle: TextStyle(
          fontSize: 13,
          color: rgba(145, 152, 173, 1),
        ),
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
      ),
    );
  }

  void _onConfirm() {
    FocusScope.of(context).requestFocus(FocusNode());
    if (this.widget.isReset == true) {
      if (isStringEmpty(_verifyCodeEditingController.text) ||
          isStringEmpty(_sessionId)) {
        showToast("请输入验证码", context);
        return;
      }
    }

    if (isStringEmpty(_passwordEditingController.text) ||
        _passwordEditingController.text.length != 6) {
      showToast("请输入6位支付密码", context);
      return;
    }

    if (isStringEmpty(_verifyPasswordEditingController.text)) {
      showToast("请再次输入支付密码", context);
      return;
    }

    if (_passwordEditingController.text !=
        _verifyPasswordEditingController.text) {
      showToast("两次输入密码不一致,请重新输入", context);
      return;
    }

    XsProgressHud hud = initHUD(context);
    if (this.widget.isReset == true) {
      var params = {
        "phone": _account["phone"],
        "sessionId": _sessionId,
        "passWord": _verifyPasswordEditingController.text,
        "code": _verifyCodeEditingController.text,
      };

      AccountApi.changePaymentCode(params, (data, msg) {
        if (data != null) {
          DartNotificationCenter.post(channel: kRefreshAccountNotification);
          Future.delayed(Duration(milliseconds: 800), () {
            hideHUD(hud);
            Navigator.of(context).pop();
          });
        } else {
          hideHUD(hud);
          showToast(msg, context);
        }
      });
    } else {
      var params = {
        "userId": _account["userId"],
        "paymentCode": _verifyPasswordEditingController.text,
      };

      AccountApi.setPaymentCode(params, (data, msg) {
        if (data != null) {
          DartNotificationCenter.post(channel: kRefreshAccountNotification);
          Future.delayed(Duration(milliseconds: 800), () {
            hideHUD(hud);
            Navigator.of(context).pop();
          });
        } else {
          hideHUD(hud);
          showToast(msg, context);
        }
      });
    }
  }

  @override
  void didUpdateWidget(PaycodePage oldWidget) {
    super.didUpdateWidget(oldWidget);

    this._refreshAccount();
  }

  @override
  void initState() {
    super.initState();
    this._refreshAccount();
  }

  @override
  void dispose() {
    if (_countdownTimer != null) {
      _countdownTimer.cancel();
      _countdownTimer = null;
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      appBar: customAppBar(
        title: this.widget.isReset ? "密码重设" : "密码设置",
        brightness: Brightness.dark,
        backgroundColor: kMainBackgroundColor,
        color: Colors.white,
      ),
      body: GestureDetector(
        onTapDown: (res) {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: ListView(
          padding: EdgeInsets.fromLTRB(12, 20, 12, 0),
          children: <Widget>[
            this.widget.isReset
                ? InfoSection(
                    cells: <Widget>[
                      InfoCell(
                        name: "绑定账号",
                        value: "${_account["phone"]}".length == 11
                            ? TextUtil.hideNumber("${_account["phone"]}")
                            : "",
                        showArrow: false,
                      ),
                      InfoCell(
                        showLine: false,
                        leftChild: Container(
                          height: 22,
                          margin: EdgeInsets.fromLTRB(0, 0, 12, 0),
                          child: _textField(
                            "请输入手机验证码",
                            obscureText: false,
                            maxLength: 4,
                            textAlign: TextAlign.left,
                            controller: _verifyCodeEditingController,
                          ),
                        ),
                        rightChild: Material(
                          color: rgba(28, 35, 63, 1),
                          child: InkWell(
                            child: Text(
                              _verifyString,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: rgba(23, 96, 255, 1),
                                fontSize: 15,
                              ),
                            ),
                            onTap: "${_account["phone"]}".length == 11
                                ? () {
                                    this._getVerifyCode();
                                  }
                                : null,
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(),
            SizedBox(
              height: this.widget.isReset ? 20 : 0,
            ),
            InfoSection(
              cells: <Widget>[
                InfoCell(
                  name: "设置密码",
                  rightChild: Expanded(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      height: 22,
                      child: _textField(
                        "请输入新的6位数支付密码",
                        controller: _passwordEditingController,
                      ),
                    ),
                  ),
                ),
                InfoCell(
                  name: "再次确认",
                  showLine: false,
                  rightChild: Expanded(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      height: 22,
                      child: _textField(
                        "再次输入新的6位数支付密码",
                        controller: _verifyPasswordEditingController,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 80,
            ),
            Container(
              height: 49,
              decoration: BoxDecoration(
                color: rgba(23, 96, 255, 1),
                borderRadius: BorderRadius.circular(7.5),
              ),
              child: FlatButton(
                onPressed: () {
                  this._onConfirm();
                },
                child: Text(
                  this.widget.isReset ? "确认修改" : "确认",
                  style: TextStyle(
                    fontSize: 15,
                    color: rgba(255, 255, 255, 1),
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
    );
  }
}
