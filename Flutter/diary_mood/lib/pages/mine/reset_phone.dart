import 'dart:async';

import 'package:common_utils/common_utils.dart';
import 'package:diary_mood/public/public.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobsms/mobsms.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';
import 'package:country_list_pick/country_list_pick.dart' hide CountryListPick;
import 'package:diary_mood/public/widget/country_list_pick_ext.dart';

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
  String _areaCode = "86"; //国家区号

  //开启倒计时
  void _startCountDown() {
    _countDownSecond = 60;
    _verifyString = "$_countDownSecond" + "s";

    _countdownTimer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        if (_countDownSecond > 0) {
          _countDownSecond -= 1;
          _verifyString = "$_countDownSecond" + "s";
        } else {
          _verifyString = "获取验证码";
          _countdownTimer.cancel();
          _countdownTimer = null;
        }
        setState(() {});
      },
    );

    setState(() {});
  }

  //获取验证码
  void _sendVerifyCode() {
    if (_countDownSecond != 0) {
      return;
    }

    if (ObjectUtil.isEmptyString(_phoneEditingController.text) == true) {
      showToast("请输入手机号！");
      return;
    }

    if (RegexUtil.isMobileExact(_phoneEditingController.text) == false) {
      showToast("请输入合法手机号！");
      return;
    }

    FocusScope.of(context).requestFocus(FocusNode());
    XsProgressHud.show(context);
    Smssdk.getTextCode(_phoneEditingController.text, _areaCode, null,
        (ret, err) {
      XsProgressHud.hide();
      if (ObjectUtil.isNotEmpty(err)) {
        showToast(err.toString());
      } else {
        // 开始倒计时
        this._startCountDown();
      }
    });
  }

  //输入框
  Widget _functionTextField({
    String placeholder = "",
    TextInputType keyboardType = TextInputType.number,
    int maxLength = 0,
    String suffix = "",
    TextStyle suffixStyle,
    String prefix = "",
    TextStyle prefixStyle,
    List<TextInputFormatter> inputFormatters,
    TextEditingController controller,
  }) {
    List<TextInputFormatter> _inputFormatters = [];
    if (inputFormatters != null) {
      _inputFormatters.addAll(inputFormatters);
    }

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

    if (prefixStyle == null) {
      prefixStyle = TextStyle(
        fontSize: 12,
        color: rgba(51, 51, 51, 1),
      );
    }

    return Container(
      padding: EdgeInsets.fromLTRB(16, 4, suffix.length > 0 ? 11 : 24, 4),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          prefix.length > 0
              ? CountryListPick(
                  initialSelection: "+" + _areaCode,
                  theme: CountryTheme(
                    isShowFlag: false,
                    isShowTitle: false,
                  ),
                  onChanged: (CountryCode code) {
                    _areaCode = code.dialCode.replaceAll("+", "");
                    setState(() {});
                  },
                )
              : Container(),
          prefix.length > 0
              ? SizedBox(
                  width: 8,
                )
              : SizedBox(
                  width: 0,
                ),
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
                  padding: EdgeInsets.only(left: 12, right: 12),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  minWidth: 0,
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
    if (ObjectUtil.isEmptyString(_phoneEditingController.text) == true) {
      showToast("请输入手机号！");
      return;
    }

    if (RegexUtil.isMobileExact(_phoneEditingController.text) == false) {
      showToast("请输入合法手机号！");
      return;
    }

    if (ObjectUtil.isEmptyString(_verifycodeEditingController.text) == true) {
      showToast("请输入验证码！");
      return;
    }

    FocusScope.of(context).requestFocus(FocusNode());
    XsProgressHud.show(context);

    // 提交短信验证码
    Smssdk.commitCode(_phoneEditingController.text, _areaCode,
        _verifycodeEditingController.text, (ret, err) {
      XsProgressHud.hide();
      if (ObjectUtil.isNotEmpty(err)) {
        showToast(err.toString());
      } else {
        // 短信验证码验证成功 提交更改手机号
      }
    });
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
      appBar: AppBar(
        title: Text("更改手机号"),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SafeArea(
          child: ListView(
            children: <Widget>[
              //手机号
              _functionTextField(
                placeholder: "新手机号",
                maxLength: 11,
                suffix: _verifyString,
                controller: _phoneEditingController,
                prefix: _areaCode,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
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
      ),
    );
  }
}
