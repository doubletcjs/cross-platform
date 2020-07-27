import 'dart:async';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../public/public.dart';
import 'views/settingsectioncell.dart';

class ResetPhonePage extends StatefulWidget {
  ResetPhonePage({Key key}) : super(key: key);

  @override
  _ResetPhonePageState createState() => _ResetPhonePageState();
}

class _ResetPhonePageState extends State<ResetPhonePage> {
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
      padding: EdgeInsets.fromLTRB(16, 0, suffix.length > 0 ? 11 : 24, 0),
      color: Colors.white,
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

  //提交
  void _onConfirm() {
    FocusScope.of(context).requestFocus(FocusNode());
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
      backgroundColor: rgba(248, 248, 248, 1),
      appBar: customAppBar(
        title: "更改手机号",
        elevation: 0.5,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: ListView(
          children: <Widget>[
            SettingBaseSection(),
            //手机号
            _functionTextField(
              placeholder: "新手机号",
              maxLength: 11,
              suffix: _verifyString,
              controller: _phoneEditingController,
            ),
            Container(
              color: Colors.white,
              child: Container(
                margin: EdgeInsets.fromLTRB(16, 0, 0, 0),
                height: 0.5,
                color: rgba(233, 233, 233, 1),
              ),
            ),
            //验证码
            _functionTextField(
              placeholder: "验证码",
              maxLength: 6,
              // keyboardType: TextInputType.text,
              controller: _verifycodeEditingController,
            ),
            SizedBox(
              height: 20,
            ),
            //提交
            Container(
              height: 44,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.fromLTRB(22, 0, 22, 0),
              decoration: BoxDecoration(
                color: rgba(216, 216, 216, 1),
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
              child: FlatButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  this._onConfirm();
                },
                child: Text(
                  "提交",
                  style: TextStyle(
                    fontSize: 16,
                    color: rgba(255, 255, 255, 1),
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(44 / 2),
                ),
              ),
            ),
            SizedBox(
              height: 44,
            ),
          ],
        ),
      ),
    );
  }
}
