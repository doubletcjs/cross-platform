import 'dart:async';

import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hksy_flutter/function/account/api/accountapi.dart';
import 'package:hksy_flutter/pages/mine/agreetment.dart';
import 'package:hksy_flutter/public/public.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';

class LoginRegisterPage extends StatefulWidget {
  bool isRegister = false;
  LoginRegisterPage({Key key, this.isRegister = false}) : super(key: key);

  @override
  _LoginRegisterPageState createState() => _LoginRegisterPageState();
}

class _LoginRegisterPageState extends State<LoginRegisterPage> {
  String _verifyString = "获取验证码";
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _codeController = TextEditingController();
  TextEditingController _inviteCodeController = TextEditingController();

  String _sessionId = "";
  bool _isAgreement = true;

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
            }
          });
        },
      );
    });
  }

  void _getVerifyCode() {
    FocusScope.of(context).requestFocus(FocusNode());

    XsProgressHud hud = initHUD(context);
    AccountApi.sendMessage(
      _phoneController.text,
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

  Widget _functionTextField(
    String tip,
    String placeholder, {
    int maxLength = 0,
    TextInputFormatter inputFormatter,
    TextInputType keyboardType = TextInputType.text,
    bool showSuffix = false,
    TextEditingController controller,
    FocusNode focusNode,
  }) {
    List<TextInputFormatter> _inputFormatters = [];
    if (maxLength > 0) {
      _inputFormatters.add(
        LengthLimitingTextInputFormatter(maxLength),
      );
    }

    if (inputFormatter != null) {
      if (inputFormatter == WhitelistingTextInputFormatter.digitsOnly) {
        keyboardType = TextInputType.number;
      }
      _inputFormatters.add(inputFormatter);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "$tip",
          style: TextStyle(
            fontSize: 13,
            color: rgba(255, 255, 255, 1),
          ),
        ),
        TextField(
          keyboardType: keyboardType,
          controller: controller,
          style: TextStyle(
            fontSize: 13,
            color: rgba(255, 255, 255, 1),
          ),
          decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: TextStyle(
                fontSize: 13,
                color: rgba(145, 152, 173, 1),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: InputBorder.none,
              suffixIcon: showSuffix == true
                  ? FlatButton(
                      padding: EdgeInsets.zero,
                      onPressed: _verifyString == "获取验证码"
                          ? () {
                              FocusScope.of(context).requestFocus(FocusNode());

                              Future.delayed(Duration(milliseconds: 100), () {
                                if (regularMatch(
                                        _phoneController.text, kPhoneRegExp) ==
                                    true) {
                                  this._getVerifyCode();
                                } else {
                                  showToast("请输入正确的新手机号", context);
                                }
                              });
                            }
                          : null,
                      child: Text(
                        _verifyString,
                        style: TextStyle(
                          fontSize: 15,
                          color: rgba(23, 96, 255, 1),
                        ),
                      ),
                    )
                  : null),
          inputFormatters: _inputFormatters,
        ),
        Divider(
          height: 1,
          color: rgba(145, 152, 173, 1),
        ),
      ],
    );
  }

  void _switchAction() {
    if (this.widget.isRegister) {
      Navigator.of(context).pop();
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return LoginRegisterPage(
              isRegister: true,
            );
          },
        ),
      );
    }
  }

  void _showAgreement() {
    FocusScope.of(context).requestFocus(FocusNode());
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return AgreenMentPage();
        },
      ),
    );
  }

  void _loginRegisterAction() {
    FocusScope.of(context).requestFocus(FocusNode());
    if (regularMatch(_phoneController.text, kPhoneRegExp) == false) {
      showToast("请输入正确的手机号", context);
      return;
    }

    if (isStringEmpty(_codeController.text) == false) {
      showToast("请输入验证码", context);
      return;
    }

    var params = {
      "phone": _phoneController.text,
      "code": _codeController.text,
      "sessionId": _sessionId,
    };

    if (this.widget.isRegister) {
      if (isStringEmpty(_inviteCodeController.text) == false) {
        showToast("请输入邀请码", context);
        return;
      }

      params["invitationCode"] = _inviteCodeController.text;
    }

    if (_isAgreement == false) {
      showToast("请先同意用户服务协议", context);
      return;
    }

    XsProgressHud hud = initHUD(context);
    if (this.widget.isRegister) {
      AccountApi.register(
        params,
        (data, msg) {
          hideHUD(hud);
          if (data != null) {
            showToast("注册成功!", context);

            Future.delayed(Duration(milliseconds: 1000), () {
              this._switchAction();
            });
          } else {
            showToast("$msg", context);
          }
        },
      );
    } else {
      AccountApi.login(
        params,
        (data, msg) {
          hideHUD(hud);
          if (data != null) {
            showToast("登录成功!", context);

            Future.delayed(Duration(milliseconds: 1000), () {
              DartNotificationCenter.post(channel: kRefreshAccountNotification);
            });
          } else {
            showToast("$msg", context);
          }
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
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
      body: Stack(
        children: <Widget>[
          transparentAppBar(),
          GestureDetector(
            child: ListView(
              padding: EdgeInsets.fromLTRB(
                  32, MediaQuery.of(context).padding.top + 53, 32, 0),
              children: <Widget>[
                Text(
                  "欢迎使用华科闪云",
                  style: TextStyle(
                    fontSize: 23,
                    color: rgba(255, 255, 255, 1),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "只需要手机号即可一键注册",
                  style: TextStyle(
                    fontSize: 11,
                    color: rgba(145, 152, 173, 1),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                _functionTextField(
                  "手机号（+86）",
                  "请输入手机号码",
                  inputFormatter: WhitelistingTextInputFormatter.digitsOnly,
                  maxLength: 11,
                  controller: _phoneController,
                ),
                SizedBox(
                  height: 30,
                ),
                _functionTextField(
                  "验证码",
                  "请输入手机验证码",
                  maxLength: 4,
                  inputFormatter: WhitelistingTextInputFormatter.digitsOnly,
                  showSuffix: true,
                  controller: _codeController,
                ),
                this.widget.isRegister
                    ? SizedBox(
                        height: 30,
                      )
                    : SizedBox(
                        height: 0,
                      ),
                this.widget.isRegister
                    ? _functionTextField(
                        "邀请码",
                        "请输入好友的邀请码",
                        controller: _inviteCodeController,
                      )
                    : Container(),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Material(
                      color: kMainBackgroundColor,
                      child: InkWell(
                        child: Image.asset(
                          _isAgreement
                              ? "images/ico_rectangle_selected@3x.png"
                              : "images/ico_rectangle@3x.png",
                          width: 12,
                          height: 12,
                          color: kMainColor,
                        ),
                        onTap: () {
                          setState(() {
                            _isAgreement = !_isAgreement;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "已阅读并同意",
                      style: TextStyle(
                        fontSize: 13,
                        color: rgba(145, 152, 173, 1),
                      ),
                    ),
                    Material(
                      color: kMainBackgroundColor,
                      child: InkWell(
                        child: Text(
                          "《用户服务协议》",
                          style: TextStyle(
                            fontSize: 13,
                            color: kMainColor,
                          ),
                        ),
                        onTap: () {
                          this._showAgreement();
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 91.5,
                ),
                Container(
                  height: 49,
                  child: RaisedButton(
                    color: kMainColor,
                    onPressed: () {
                      this._loginRegisterAction();
                    },
                    child: Text(
                      this.widget.isRegister ? "确认注册" : "登录",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.5),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.5),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 27.5, 0,
                      140.5 - MediaQuery.of(context).padding.bottom),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        this.widget.isRegister ? "已有账号？" : "未拥有华科闪云账号？",
                        style: TextStyle(
                          fontSize: 13,
                          color: rgba(145, 152, 173, 1),
                        ),
                      ),
                      Material(
                        color: kMainBackgroundColor,
                        child: InkWell(
                          child: Text(
                            this.widget.isRegister ? "去登录" : "去注册",
                            style: TextStyle(
                              fontSize: 13,
                              color: kMainColor,
                            ),
                          ),
                          onTap: () {
                            this._switchAction();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
          ),
        ],
      ),
    );
  }
}
