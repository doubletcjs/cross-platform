import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ideaclass/pages/account/api/accountapi.dart';
import 'package:ideaclass/public/public.dart';

class BindMobilePage extends StatefulWidget {
  BindMobilePage({Key key}) : super(key: key);

  @override
  _BindMobilePageState createState() => _BindMobilePageState();
}

class _BindMobilePageState extends State<BindMobilePage> {
  TextEditingController _mobileEditingController = TextEditingController();
  TextEditingController _newMobileEditingController = TextEditingController();
  TextEditingController _verifyCodeEditingController = TextEditingController();

  Timer _timer;
  int _countdownTime = 0;
  String _countdownString = "发送验证码";
  void _startCountdownTimer() {
    const oneSec = const Duration(seconds: 1);
    setState(() {
      _countdownTime = 60;
      _countdownString = "$_countdownTime" + "S";
    });

    var _callback = (timer) {
      setState(() {
        if (_countdownTime <= 1) {
          _countdownTime = 0;
          _timer.cancel();
          _countdownString = "发送验证码";
        } else {
          _countdownTime = _countdownTime - 1;
          _countdownString = "$_countdownTime" + "S";
        }
      });
    };

    _timer = Timer.periodic(oneSec, _callback);
  }

  void _getVerifyCode() {
    if (regularMatch(_mobileEditingController.text, kPhoneRegExp) == false) {
      showToast(
        "请输入正确的已绑定手机号",
        context,
      );

      return;
    }

    if (regularMatch(_newMobileEditingController.text, kPhoneRegExp) == false) {
      showToast(
        "请输入正确的新手机号",
        context,
      );

      return;
    }

    if (_newMobileEditingController.text == _mobileEditingController.text) {
      showToast(
        "新旧手机号不能相同",
        context,
      );

      return;
    }

    //获取验证码
    if (_countdownTime == 0) {
      FocusScope.of(context).requestFocus(FocusNode());
      showHUD();
      AccountApi().sedPhoneCode(
        _newMobileEditingController.text,
        3,
        (data, msg) {
          if (data != null) {
            _countdownTime = 0;
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

  void _submitAction() {
    if (regularMatch(_mobileEditingController.text, kPhoneRegExp) == false) {
      showToast(
        "请输入正确的已绑定手机号",
        context,
      );

      return;
    }

    if (regularMatch(_newMobileEditingController.text, kPhoneRegExp) == false) {
      showToast(
        "请输入正确的新手机号",
        context,
      );

      return;
    }

    if (_newMobileEditingController.text == _mobileEditingController.text) {
      showToast(
        "新旧手机号不能相同",
        context,
      );

      return;
    }

    if (_newMobileEditingController.text == _verifyCodeEditingController.text) {
      showToast(
        "验证码不能为空",
        context,
      );

      return;
    }

    FocusScope.of(context).requestFocus(FocusNode());
    showHUD();
    AccountApi().bindPhone(
      _newMobileEditingController.text,
      _verifyCodeEditingController.text,
      "",
      "",
      _mobileEditingController.text,
      (data, msg) {
        if (data != null) {
          showToast("修改成功", context);
          AccountApi().fetchNewestUser(null, context: context);
          Future.delayed(
            Duration(milliseconds: 1800),
            () {
              hideHUD();
              Navigator.pop(context);
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
        title: "更改手机",
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          color: rgba(0, 0, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 7,
              ),
              Container(
                color: Colors.white,
                height: 44,
                padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                child: TextField(
                  controller: _mobileEditingController,
                  style: TextStyle(
                    fontSize: 14,
                    color: rgba(23, 23, 23, 1),
                  ),
                  decoration: InputDecoration(
                    hasFloatingPlaceholder: false,
                    border: InputBorder.none,
                    hintText: "请输入已绑定手机号",
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: rgba(136, 136, 136, 1),
                    ),
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(11),
                    WhitelistingTextInputFormatter.digitsOnly,
                  ],
                  keyboardType: TextInputType.phone,
                ),
              ),
              Container(
                height: 1,
              ),
              Container(
                color: Colors.white,
                height: 44,
                padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                child: TextField(
                  controller: _newMobileEditingController,
                  style: TextStyle(
                    fontSize: 14,
                    color: rgba(23, 23, 23, 1),
                  ),
                  decoration: InputDecoration(
                    hasFloatingPlaceholder: false,
                    border: InputBorder.none,
                    hintText: "请输入新手机号",
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: rgba(136, 136, 136, 1),
                    ),
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(11),
                    WhitelistingTextInputFormatter.digitsOnly,
                  ],
                  keyboardType: TextInputType.phone,
                ),
              ),
              Container(
                height: 1,
              ),
              Container(
                color: Colors.white,
                height: 44,
                padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: _verifyCodeEditingController,
                        style: TextStyle(
                          fontSize: 14,
                          color: rgba(23, 23, 23, 1),
                        ),
                        decoration: InputDecoration(
                          hasFloatingPlaceholder: false,
                          border: InputBorder.none,
                          hintText: "验证码",
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: rgba(136, 136, 136, 1),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    buttonWidget(
                      Container(
                        padding: EdgeInsets.fromLTRB(12, 4, 12, 4),
                        child: Text(
                          "$_countdownString",
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      context,
                      onTap: () {
                        this._getVerifyCode();
                      },
                      color: rgba(181, 181, 181, 1),
                      radius: BorderRadius.circular(6),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(12, 70, 12, 0),
                height: 49,
                child: FlatButton(
                  onPressed: () {
                    this._submitAction();
                  },
                  child: Text(
                    "确认修改",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                decoration: BoxDecoration(
                  color: kMainColor,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
