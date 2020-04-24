import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ideaclass/public/networking.dart';
import 'package:ideaclass/public/public.dart';

class AccountApi {
  getRegisterAgreement(Function finish) {
    Networking.requestBase(
      "/app/user/getRegisterAgreement",
      finish,
    );
  }

  ///   - mobilePhone: 手机号码
  ///   - type: 类型：1注册 2重置密码 3.绑定手机 4.提现时候
  sedPhoneCode(String mobilePhone, int type, Function finish) {
    Networking.requestBase(
      "/app/phoneCode/sedPhoneCode",
      finish,
      params: {
        "mobilePhone": mobilePhone,
        "type": type,
      },
    );
  }

  editUserInfo(parameters, Function finish) {
    Networking.requestBase(
      "/app/user/editUserInfo",
      finish,
      params: parameters,
    );
  }

  getMyInfo(Function finish) {
    Networking.requestBase(
      "/app/user/getMyInfo",
      finish,
    );
  }

  void loadLocalAccount(Function finish) {
    Map user = fetchUser();
    kLog("fetchUser");
    if (finish != null) {
      finish(user);
    }
  }

  /// - mobilePhone:        手机号码
  /// - verifyCode:         验证码
  /// - password:           如果用户使用第三方登录，没有手机号码的话，需要设置密码
  /// - confirmPassword:    如果用户使用第三方登录，没有手机号码的话，需要设置密码
  /// - oldMobilePhone:     如果是换绑，需要的旧手机号码
  bindPhone(mobilePhone, verifyCode, password, confirmPassword, oldMobilePhone,
      Function finish) {
    Networking.requestBase(
      "/app/user/bindPhone",
      finish,
      params: {
        "mobilePhone": mobilePhone,
        "verifyCode": verifyCode,
        "password": password,
        "confirmPassword": confirmPassword,
        "oldMobilePhone": oldMobilePhone,
      },
    );
  }

  fetchNewestUser(Function finish, {BuildContext context}) {
    if (accountLogin() == true) {
      getMyInfo(
        (data, msg) {
          if (data != null) {
            kLog("更新用户信息");
            if (isStringEmpty("${data["token"]}") == true) {
              String token = fetchToken();
              if (isStringEmpty(token) == false) {
                data["token"] = "$token";
                recordUserInfo(data);
              }
            }
            if (finish != null) {
              finish(null);
            }
          } else {
            if (finish != null) {
              finish(msg);
            }

            if (context != null) {
              showToast(msg, context);
            }
          }
        },
      );
    } else {
      if (finish != null) {
        finish(null);
      }
    }
  }

  register(
      String referrerPhone,
      String nickname,
      String password,
      String confirmPassword,
      String mobilePhone,
      String verifyCode,
      Function finish) {
    Networking.requestBase(
      "/app/user/register",
      finish,
      params: {
        "nickname": nickname,
        "verifyCode": verifyCode,
        "mobilePhone": mobilePhone,
        "password": password,
        "confirmPassword": confirmPassword,
        "referrerPhone": referrerPhone,
      },
    );
  }

  login(String mobilePhone, String password, Function finish) {
    Networking.requestBase(
      "/app/user/login",
      finish,
      params: {
        "mobilePhone": mobilePhone,
        "password": password,
      },
    );
  }

  bindAccount(type, bindId, Function finish) {
    Networking.requestBase(
      "/app/user/bindAccount",
      finish,
      params: {
        "type": type,
        "bindId": bindId,
      },
    );
  }

  unBindAccount(type, Function finish) {
    Networking.requestBase(
      "/app/user/unBindAccount",
      finish,
      params: {
        "type": type,
      },
    );
  }

  Widget functionTextField({
    double offSet = 0.0,
    EdgeInsets padding,
    String placeholder,
    bool isSecureTextEntry = false,
    int maxLength = 0,
    TextEditingController controller,
    TextInputFormatter inputFormatter,
    ValueChanged<String> onChanged,
    TextInputType keyboardType = TextInputType.text,
    Widget prefix,
    Widget suffix,
  }) {
    List<TextInputFormatter> _inputFormatters = [];
    if (maxLength > 0) {
      _inputFormatters.add(
        LengthLimitingTextInputFormatter(maxLength),
      );
    }

    if (inputFormatter != null) {
      _inputFormatters.add(inputFormatter);
    }

    return Container(
      height: 38,
      padding: padding == null ? EdgeInsets.fromLTRB(42, 0, 42, 0) : padding,
      margin: EdgeInsets.fromLTRB(0, offSet, 0, 0),
      child: TextField(
        style: TextStyle(
          fontSize: 15,
          color: rgba(23, 23, 23, 1),
        ),
        obscureText: isSecureTextEntry,
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: placeholder,
          hintStyle: TextStyle(
            color: rgba(136, 136, 136, 1),
          ),
          hasFloatingPlaceholder: false,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: rgba(237, 237, 237, 1),
              width: 1,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: rgba(237, 237, 237, 1),
              width: 1,
            ),
          ),
          prefixIcon: prefix,
          suffixIcon: suffix,
        ),
        inputFormatters: _inputFormatters,
        onChanged: onChanged,
      ),
    );
  }
}
