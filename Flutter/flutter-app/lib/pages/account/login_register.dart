import 'dart:async';

import 'package:common_utils/common_utils.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';
import '../../public/public.dart';
import 'info_input.dart';
import 'api/account_api.dart';
import '../function/base_webview.dart';
import '../../public/networking.dart';

class LoginRegisterPage extends StatefulWidget {
  bool isRegister = false;
  LoginRegisterPage({Key key, this.isRegister = false}) : super(key: key);

  @override
  _LoginRegisterPageState createState() => _LoginRegisterPageState();
}

class _LoginRegisterPageState extends State<LoginRegisterPage> {
  TextEditingController _phoneEditingController = TextEditingController();
  TextEditingController _verifycodeEditingController = TextEditingController();

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
      showToast("请输入手机号！", context);
      return;
    }

    if (RegexUtil.isMobileExact(_phoneEditingController.text) == false) {
      showToast("请输入合法手机号！", context);
      return;
    }

    FocusScope.of(context).requestFocus(FocusNode());
    XsProgressHud.show(context);

    AccountApi.verifyCode(
        _phoneEditingController.text,
        (this.widget.isRegister == true ? "register" : "login"),
        _areaCode, (data, msg) {
      XsProgressHud.hide();
      if (data != null) {
        // 开始倒计时
        this._startCountDown();
      } else {
        showToast(msg, context);
      }
    });
  }

  //登录、注册
  void _onConfirm() {
    if (ObjectUtil.isEmptyString(_phoneEditingController.text) == true) {
      showToast("请输入手机号！", context);
      return;
    }

    if (ObjectUtil.isEmptyString(_verifycodeEditingController.text) == true) {
      showToast("请输入验证码！", context);
      return;
    }

    FocusScope.of(context).requestFocus(FocusNode());
    XsProgressHud.show(context);

    if (this.widget.isRegister) {
      AccountApi.register(
          _phoneEditingController.text, _verifycodeEditingController.text,
          (data, msg) {
        XsProgressHud.hide();
        if (data != null) {
          showToast("注册成功!", context);
          //注册成功，记录token，userId
          recordToken(data["token"]);
          recordUserID(data["id"]);
          recordUserSig(data["IMPassword"]);

          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) {
              return InfoInputPage();
            }),
            (route) => route == null,
          );
        } else {
          showToast("$msg", context);
        }
      });
    } else {
      AccountApi.smsLogin(
          _phoneEditingController.text, _verifycodeEditingController.text,
          (data, msg) {
        XsProgressHud.hide();
        if (data != null) {
          //注册成功，记录token，userId
          recordToken(data["token"]);
          recordUserID(data["id"]);
          recordUserSig(data["IMPassword"]);

          showToast(
            "登录成功!",
            context,
            duration: 1,
          );
          Future.delayed(Duration(milliseconds: 1000), () {
            //回到首页
            Navigator.of(context).popUntil(
              ModalRoute.withName("/"),
            );
            DartNotificationCenter.post(
              channel: kAccountHandleNotification,
              options: {
                "type": 0,
              },
            );
          });

          /*
          //注册步骤 0：已完成所有注册 2：第二步 3：第三步
          int registerStatus = data["register_status"];
          if (registerStatus == 0) {
            showToast("登录成功!", context);
            Future.delayed(Duration(milliseconds: 1000), () {
              //回到首页
              Navigator.of(context).popUntil(
                ModalRoute.withName("/"),
              );
              DartNotificationCenter.post(
                channel: kAccountHandleNotification,
                options: {
                  "type": 0,
                },
              );
            });
          } else if (registerStatus == 2) {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return InfoInputPage();
              }),
            );
          } else if (registerStatus == 3) {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return InputAvatarPage();
              }),
            );
          }
          */
        } else {
          showToast("$msg", context);
        }
      });
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
                  isShowFlag: false,
                  isShowTitle: false,
                  isShowCode: true,
                  isDownIcon: true,
                  initialSelection: "+" + _areaCode,
                  showEnglishName: true,
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

  //web浏览器
  void _showWebView(int type) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return BaseWebView(
            url: "${kServerURL + "/page/" + "$type"}",
            title: type == 1 ? "隐私政策" : "用户协议",
          );
        },
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
                "Hi，欢迎来到尔蒙",
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
              prefix: _areaCode,
              inputFormatters: [
                WhitelistingTextInputFormatter.digitsOnly,
              ],
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
          ],
        ),
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
      ),
    );
  }
}
