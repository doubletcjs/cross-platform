import 'dart:async';

import 'package:common_utils/common_utils.dart';
import 'package:country_list_pick/country_list_pick.dart' hide CountryListPick;
import 'package:diary_mood/public/public.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobsms/mobsms.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';
import 'package:diary_mood/public/widget/country_list_pick_ext.dart';

// ignore: must_be_immutable
class LoginRegisterPage extends StatefulWidget {
  bool isRegister = false;
  LoginRegisterPage({Key key, this.isRegister = false}) : super(key: key);

  @override
  _LoginRegisterPageState createState() => _LoginRegisterPageState();
}

class _LoginRegisterPageState extends State<LoginRegisterPage> {
  TextEditingController _phoneEditingController = TextEditingController();
  TextEditingController _verifycodeEditingController = TextEditingController();
  TextEditingController _passwordEditingController = TextEditingController();
  TextEditingController _verifyPasswordEditingController =
      TextEditingController();
  TextEditingController _nameEditingController = TextEditingController();

  String _areaCode = "86"; //国家区号
  String _verifyString = "获取验证码";
  int _countDownSecond = 0;
  Timer _countdownTimer;

  //开启倒计时
  void _startCountDown() {
    setState(() {
      _countDownSecond = 60;
      _verifyString = "$_countDownSecond" + "秒后重新获取";

      _countdownTimer = Timer.periodic(
        Duration(seconds: 1),
        (timer) {
          setState(() {
            if (_countDownSecond > 0) {
              _countDownSecond -= 1;
              _verifyString = "$_countDownSecond" + "秒后重新获取";
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

  //登录、注册
  void _onConfirm() {
    if (this.widget.isRegister) {
      if (ObjectUtil.isEmptyString(_nameEditingController.text) == true) {
        showToast("请输入昵称！");
        return;
      }
    }

    if (ObjectUtil.isEmptyString(_phoneEditingController.text) == true) {
      showToast("请输入手机号！");
      return;
    }

    if (RegexUtil.isMobileExact(_phoneEditingController.text) == false) {
      showToast("请输入合法手机号！");
      return;
    }

    if (this.widget.isRegister) {
      if (ObjectUtil.isEmptyString(_verifycodeEditingController.text) == true) {
        showToast("请输入验证码！");
        return;
      }

      if (ObjectUtil.isEmptyString(_passwordEditingController.text) == true) {
        showToast("请输入密码！");
        return;
      }

      var regex = RegExp(r'[a-zA-Z0-9_]{6,12}');
      if (regex.hasMatch(_passwordEditingController.text) == false) {
        showToast("密码必须是6-12位数字，英文结合！");
        return;
      }

      if (_passwordEditingController.text !=
          _verifyPasswordEditingController.text) {
        showToast("两次输入密码不一致！");
        return;
      }
    } else {
      if (ObjectUtil.isEmptyString(_passwordEditingController.text) == true) {
        showToast("请输入密码！");
        return;
      }
    }

    FocusScope.of(context).requestFocus(FocusNode());
    XsProgressHud.show(context);

    if (this.widget.isRegister) {
      // 提交短信验证码
      Smssdk.commitCode(_phoneEditingController.text, _areaCode,
          _verifycodeEditingController.text, (ret, err) {
        XsProgressHud.hide();
        if (ObjectUtil.isNotEmpty(err)) {
          showToast(err.toString());
        } else {
          // 短信验证码验证成功 提交注册
        }
      });
    } else {
      // 登录
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
    String prefix = "",
    TextStyle prefixStyle,
    List<TextInputFormatter> inputFormatters,
    bool obscureText = false,
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
      margin: EdgeInsets.fromLTRB(21, 0, 21, 0),
      padding: EdgeInsets.fromLTRB(22, 0, suffix.length > 0 ? 11 : 24, 0),
      decoration: BoxDecoration(
        color: rgba(245, 245, 245, 1),
        borderRadius: BorderRadius.circular(44 / 2),
      ),
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
                    setState(() {
                      _areaCode = code.dialCode.replaceAll("+", "");
                    });
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
              obscureText: obscureText,
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

  //web浏览器
  void _showWebView(int type) {}

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
      appBar: AppBar(
        title: Text(this.widget.isRegister == true ? "注册" : "登录"),
        actions: this.widget.isRegister == true
            ? []
            : [
                FlatButton(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  minWidth: 0,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return LoginRegisterPage(
                          isRegister: true,
                        );
                      }),
                    );
                  },
                  child: Text(
                    "注册",
                    style: TextStyle(
                      color: rgba(255, 255, 255, 1),
                      fontSize: 17,
                    ),
                  ),
                ),
              ],
      ),
      body: SafeArea(
        child: GestureDetector(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              SizedBox(
                height: 60,
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
              // 手机号
              this.widget.isRegister == false
                  ? _functionTextField(
                      placeholder: "请输入手机号码",
                      maxLength: 11,
                      controller: _phoneEditingController,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    )
                  : Column(
                      children: [
                        // 昵称
                        _functionTextField(
                          placeholder: "昵称。一旦注册不能修改！",
                          maxLength: 12,
                          controller: _nameEditingController,
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        _functionTextField(
                          placeholder: "手机号",
                          maxLength: 11,
                          suffix: _verifyString,
                          controller: _phoneEditingController,
                          prefix: _areaCode,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ],
                    ),
              SizedBox(
                height: 20,
              ),
              this.widget.isRegister == false
                  ? // 密码登录
                  _functionTextField(
                      placeholder: "请输入密码",
                      maxLength: 12,
                      obscureText: true,
                      controller: _passwordEditingController,
                    )
                  : Column(
                      children: [
                        // 验证码
                        _functionTextField(
                          placeholder: "验证码",
                          maxLength: 6,
                          controller: _verifycodeEditingController,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        // 密码
                        _functionTextField(
                          placeholder: "密码必须是6-12位数字，英文结合",
                          maxLength: 12,
                          obscureText: true,
                          controller: _passwordEditingController,
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        // 验证密码
                        _functionTextField(
                          placeholder: "再次输入密码",
                          maxLength: 12,
                          obscureText: true,
                          controller: _verifyPasswordEditingController,
                          keyboardType: TextInputType.text,
                        ),
                      ],
                    ),
              SizedBox(
                height: 44,
              ),
              //登录、注册
              Container(
                height: 44,
                margin: EdgeInsets.fromLTRB(23, 0, 23, 0),
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
                      onTap: () {
                        this._showWebView(6);
                      },
                      child: Text(
                        "用户协议",
                        style: TextStyle(
                          fontSize: 13,
                          color: rgba(153, 153, 153, 1),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    Text(
                      "和",
                      style: TextStyle(
                        fontSize: 13,
                        color: rgba(153, 153, 153, 1),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        this._showWebView(1);
                      },
                      child: Text(
                        "隐私政策",
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
              SizedBox(
                height: 44,
              ),
            ],
          ),
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
        ),
      ),
    );
  }
}
