import 'dart:async';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';
import '../../public/public.dart';
import 'views/settingsectioncell.dart';
import '../account/api/accountapi.dart';
import '../function/datapicker.dart';

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
  List _areaCodeList = [];

  //获取国家区号
  void _getCountryCode(kVoidFunctionBlock finish) {
    XsProgressHud.show(context);
    AccountApi.countryCode((data, msg) {
      if (data != null) {
        var _list = List.from(data);
        setState(() {
          XsProgressHud.hide();
          _areaCodeList = _list;
          if (finish != null) {
            finish();
          }
        });
      } else {
        XsProgressHud.hide();
        showToast(msg, context);
      }
    });
  }

  //选择国家区号
  void _selectCountryCode() {
    void _showing() {
      List _list = _areaCodeList.map((e) {
        return e["area_code"];
      }).toList();

      DataPicker.showDatePicker(
        context,
        datas: _list,
        selectedIndex: _list.indexOf(_areaCode),
        onConfirm: (data) {
          setState(() {
            _areaCode = data;
          });
        },
      );
    }

    if (_areaCodeList.length == 0) {
      this._getCountryCode(() {
        _showing();
      });
    } else {
      _showing();
    }
  }

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
    XsProgressHud.show(context);

    AccountApi.verifyCode(
        _phoneEditingController.text, "modify_mobile", _areaCode, (data, msg) {
      XsProgressHud.hide();
      if (data != null) {
        // 开始倒计时
        this._startCountDown();
      } else {
        showToast(msg, context);
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

    if (prefixStyle == null) {
      prefixStyle = TextStyle(
        fontSize: 12,
        color: rgba(51, 51, 51, 1),
      );
    }

    return Container(
      padding: EdgeInsets.fromLTRB(16, 0, suffix.length > 0 ? 11 : 24, 0),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          prefix.length > 0
              ? Material(
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {
                      this._selectCountryCode();
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: <Widget>[
                          Text(
                            _areaCode,
                            style: TextStyle(
                              color: rgba(51, 51, 51, 1),
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Image.asset(
                            "images/Arrow down@3x.png",
                            width: 11,
                            height: 7.5,
                          ),
                        ],
                      ),
                    ),
                  ),
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

  //提交
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

    AccountApi.modifyMobile(
        _phoneEditingController.text, _verifycodeEditingController.text,
        (data, msg) {
      XsProgressHud.hide();
      if (data != null) {
        showToast("更改手机号成功!", context);
        Navigator.of(context).pop();
      } else {
        showToast("$msg", context);
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
              prefix: _areaCode,
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
