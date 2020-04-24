import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ideaclass/pages/account/api/accountapi.dart';
import 'package:ideaclass/public/public.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  List<String> _placeholders = [
    "请输入邀请人手机号",
    "请输入您的用户名",
    "请输入您的密码",
    "请再次输入您的密码",
    "请输入您的手机号",
    "请输入您的手机验证码"
  ];

  List<TextEditingController> _controllerList = [];

  TextEditingController _inviterEditingController = TextEditingController();
  TextEditingController _nameEditingController = TextEditingController();
  TextEditingController _passwordEditingController = TextEditingController();
  TextEditingController _verifyPasswordEditingController =
      TextEditingController();
  TextEditingController _phoneEditingController = TextEditingController();
  TextEditingController _verifyCodeController = TextEditingController();
  bool _registerAble = false;

  Timer _timer;
  int _countdownTime = 0;
  String _countdownString = "获取";
  void _startCountdownTimer() {
    const oneSec = const Duration(seconds: 1);
    setState(() {
      _countdownTime = 60;
      _countdownString = "$_countdownTime" + "S";
    });

    var _callback = (timer) {
      setState(
        () {
          if (_countdownTime <= 1) {
            _countdownTime = 0;
            _timer.cancel();
            _countdownString = "获取";
          } else {
            _countdownTime = _countdownTime - 1;
            _countdownString = "$_countdownTime" + "S";
          }
        },
      );
    };

    _timer = Timer.periodic(oneSec, _callback);
  }

  void _checkRegisterAble() {
    setState(
      () {
        _registerAble = false;
        if (isStringEmpty(_nameEditingController.text) == false &&
            isStringEmpty(_passwordEditingController.text) == false &&
            isStringEmpty(_verifyPasswordEditingController.text) == false &&
            isStringEmpty(_phoneEditingController.text) == false &&
            isStringEmpty(_verifyCodeController.text) == false) {
          _registerAble = true;
        }
      },
    );
  }

  void _getVerifyCode() {
    if (regularMatch(_phoneEditingController.text, kPhoneRegExp) == false) {
      showToast(
        "请输入正确的手机号",
        context,
      );

      return;
    }

    //获取验证码
    if (_countdownTime == 0) {
      showHUD(); 
      AccountApi().sedPhoneCode(
        _phoneEditingController.text,
        1,
        (data, msg) {
          if (data != null) {
            _countdownTime = 0;
            FocusScope.of(context).requestFocus(FocusNode());
            this._startCountdownTimer();
          } else {
            _countdownTime = 0;
            showToast(msg, context);
          }

          hideHUD();
        },
      );
    }
  }

  void _registerAction() {
    if (isStringEmpty(_inviterEditingController.text) == false) {
      if (regularMatch(_inviterEditingController.text, kPhoneRegExp) == false) {
        showToast(
          "请输入正确邀请人手机号",
          context,
        );

        return;
      }
    }

    if (regularMatch(_phoneEditingController.text, kPhoneRegExp) == false) {
      showToast(
        "请输入正确的手机号",
        context,
      );

      return;
    }

    FocusScope.of(context).requestFocus(FocusNode());
    showHUD(message: "正在注册...");
    AccountApi().register(
      _inviterEditingController.text,
      _nameEditingController.text,
      _passwordEditingController.text,
      _verifyPasswordEditingController.text,
      _phoneEditingController.text,
      _verifyCodeController.text,
      (data, msg) {
        if (data != null) {
          Future.delayed(
            Duration(milliseconds: 400),
            () {
              hideHUD();
              Navigator.of(context).pop(_phoneEditingController.text);
            },
          );
        } else {
          hideHUD();
          showToast(msg, context);
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();

    _controllerList.add(_inviterEditingController);
    _controllerList.add(_nameEditingController);
    _controllerList.add(_passwordEditingController);
    _controllerList.add(_verifyPasswordEditingController);
    _controllerList.add(_phoneEditingController);
    _controllerList.add(_verifyCodeController);
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "注册",
        rightItems: [
          buttonWidget(
            Container(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
              alignment: Alignment.center,
              child: Text(
                "登录",
                style: TextStyle(
                  fontSize: 17,
                  color: rgba(51, 51, 51, 1),
                ),
              ),
            ),
            context,
            loginIntercept: false,
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: GestureDetector(
        child: Container(
          color: Colors.white,
          child: ListView.builder(
            padding: EdgeInsets.fromLTRB(0, 91, 0, 0),
            itemBuilder: (context, index) {
              return index == _placeholders.length
                  ? Container(
                      padding: EdgeInsets.fromLTRB(42, 0, 42, 0),
                      margin: EdgeInsets.fromLTRB(0, 66, 0, 44),
                      height: 53,
                      child: FlatButton(
                        color: rgba(21, 159, 251, 1),
                        disabledColor: rgba(136, 207, 253, 1),
                        onPressed: _registerAble == true
                            ? () {
                                this._registerAction();
                              }
                            : null,
                        child: Text(
                          "注册",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(53 / 2),
                        ),
                      ),
                    )
                  : AccountApi().functionTextField(
                      placeholder: _placeholders[index],
                      offSet: 12,
                      inputFormatter: (index == 0 || index == 4 || index == 5) ? WhitelistingTextInputFormatter.digitsOnly
                              : null,
                      keyboardType: (index == 0 || index == 4)
                          ? TextInputType.phone
                          : index == 5
                              ? TextInputType.number
                              : TextInputType.text,
                      maxLength: (index == 0 || index == 4)
                          ? 11
                          : index == 1
                              ? 5
                              : (index == 2 || index == 3)
                                  ? 16
                                  : index == 5 ? 6 : 0,
                      suffix: index == 0
                          ? Container(
                              alignment: Alignment.center,
                              width: 40,
                              child: Text(
                                "(选填)",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: rgba(51, 51, 51, 1),
                                ),
                              ),
                            )
                          : index == 5
                              ? Container(
                                  width: 40,
                                  alignment: Alignment.center,
                                  child: buttonWidget(
                                    Container(
                                      height: 18,
                                      width: 40,
                                      alignment: Alignment.center,
                                      child: Text(
                                        _countdownString,
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    context,
                                    loginIntercept: false,
                                    color: Colors.black45,
                                    radius: BorderRadius.circular(18 / 2),
                                    onTap: () {
                                      this._getVerifyCode();
                                    },
                                  ),
                                )
                              : null,
                      controller: _controllerList[index],
                      isSecureTextEntry:
                          (index == 2 || index == 3) ? true : false,
                      onChanged: (text) {
                        this._checkRegisterAble();
                      },
                    );
            },
            itemCount: _placeholders.length + 1,
          ),
        ),
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
      ),
    );
  }
}
