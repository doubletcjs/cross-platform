import 'dart:async';

import 'package:common_utils/common_utils.dart';
import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../public/public.dart';
import './infoinput.dart';

class LoginRegisterPage extends StatefulWidget {
  bool isRegister = false;
  LoginRegisterPage({Key key, this.isRegister = false}) : super(key: key);

  @override
  _LoginRegisterPageState createState() => _LoginRegisterPageState();
}

class _LoginRegisterPageState extends State<LoginRegisterPage> {
  TextEditingController _phoneEditingController = TextEditingController();
  TextEditingController _verifycodeEditingController = TextEditingController();

  String _verifyString = "获取验证码";
  int _countDownSecond = 0;
  Timer _countdownTimer;

  //开启倒计时
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

  //获取验证码
  void _sendVerifyCode() {
    if (_countDownSecond != 0) {
      return;
    }

    if (ObjectUtil.isEmptyString(_phoneEditingController.text) == true) {
      showToast("请输入手机号！", context);
      return;
    }

    if (RegexUtil.isMobileExact(_phoneEditingController.text) == false) {
      showToast("请输入合法手机号！", context);
      return;
    }

    FocusScope.of(context).requestFocus(FocusNode());
  }

  //登录、注册
  void _onConfirm() {
    if (this.widget.isRegister) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) {
          return InfoInputPage();
        }),
      );
    } else {
      Navigator.of(context).popUntil(
        ModalRoute.withName("/"),
      );
      DartNotificationCenter.post(
        channel: kAccountHandleNotification,
        options: {
          "type": 0,
        },
      );
    }
  }

  //输入框
  Widget _functionTextField({
    String placeholder = "",
    TextInputType keyboardType = TextInputType.number,
    int maxLength = 0,
    String suffix = "",
    TextStyle suffixStyle,
    TextEditingController controller,
  }) {
    List<TextInputFormatter> _inputFormatters = [];
    if (maxLength > 0) {
      _inputFormatters.add(
        LengthLimitingTextInputFormatter(maxLength),
      );
    }

    if (suffixStyle == null) {
      suffixStyle = TextStyle(
        fontSize: 12,
        color: rgba(255, 45, 85, 1),
      );
    }

    return Container(
      margin: EdgeInsets.fromLTRB(21, 0, 21, 0),
      padding: EdgeInsets.fromLTRB(22, 0, suffix.length > 0 ? 11 : 24, 0),
      decoration: BoxDecoration(
        color: rgba(245, 245, 245, 1),
        borderRadius: BorderRadius.circular(44 / 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: TextField(
              scrollPadding: EdgeInsets.zero,
              controller: controller,
              style: TextStyle(
                color: rgba(0, 0, 0, 1),
                fontSize: 14,
              ),
              decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: placeholder,
                hintStyle: TextStyle(
                  color: rgba(188, 188, 188, 1),
                  fontSize: 14,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
              inputFormatters: _inputFormatters,
              keyboardType: keyboardType,
            ),
          ),
          suffix.length > 0
              ? FlatButton(
                  padding: EdgeInsets.zero,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onPressed: () {
                    this._sendVerifyCode();
                  },
                  child: Text(
                    suffix,
                    style: suffixStyle,
                  ),
                )
              : Container(),
        ],
      ),
    );
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
      appBar: customAppBar(),
      backgroundColor: kMainBackgroundColor,
      body: GestureDetector(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 23.5,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(35, 0, 35, 0),
              child: Text(
                "Hi，欢迎来到 Yue Mei",
                style: TextStyle(
                  fontSize: 17,
                  color: rgba(153, 153, 153, 1),
                ),
              ),
            ),
            SizedBox(
              height: 17.5,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(35, 0, 35, 0),
              child: Text(
                this.widget.isRegister ? "注册" : "登录",
                style: TextStyle(
                  fontSize: 34,
                  color: rgba(51, 51, 51, 1),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 46,
            ),
            _functionTextField(
              placeholder: "手机号",
              maxLength: 11,
              suffix: _verifyString,
              controller: _phoneEditingController,
            ),
            SizedBox(
              height: 20,
            ),
            _functionTextField(
              placeholder: "验证码",
              maxLength: 6,
              // keyboardType: TextInputType.text,
              controller: _verifycodeEditingController,
            ),
            SizedBox(
              height: 44,
            ),
            //登录、注册
            Container(
              height: 44,
              margin: EdgeInsets.fromLTRB(23, 0, 23, 0),
              width: MediaQuery.of(context).size.width,
              child: FlatButton(
                onPressed: () {
                  this._onConfirm();
                },
                child: Text(
                  this.widget.isRegister ? "注册" : "登录",
                  style: TextStyle(
                    fontSize: 16,
                    color: rgba(255, 255, 255, 1),
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(44 / 2),
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(44 / 2),
                gradient: LinearGradient(
                  colors: [
                    rgba(255, 44, 96, 1),
                    rgba(255, 114, 81, 1),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),
            SizedBox(
              height: 27,
            ),
            //隐私政策
            Material(
              color: rgba(0, 0, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "已同意",
                    style: TextStyle(
                      fontSize: 13,
                      color: rgba(153, 153, 153, 1),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      "用户协议和隐私政策",
                      style: TextStyle(
                        fontSize: 13,
                        color: rgba(153, 153, 153, 1),
                        decoration: TextDecoration.underline,
                      ),
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
    );
  }
}
