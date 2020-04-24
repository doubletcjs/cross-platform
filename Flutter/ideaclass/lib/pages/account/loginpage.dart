import 'package:flutter/material.dart';
import 'package:ideaclass/pages/account/agreementpage.dart';
import 'package:ideaclass/pages/account/api/accountapi.dart';
import 'package:ideaclass/pages/account/forgotpassword.dart';
import 'package:ideaclass/pages/account/registerpage.dart';
import 'package:ideaclass/public/public.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _loginAble = false;
  bool _agreementSelect = false;
  TextEditingController _accountController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void _checkLoginAble() {
    setState(
      () {
        _loginAble = false;
        if (isStringEmpty(_accountController.text) == false &&
            isStringEmpty(_passwordController.text) == false &&
            _agreementSelect == true) {
          _loginAble = true;
        }
      }
    );
  }

  void _loginAction() {
    showHUD();
    AccountApi().login(
      _accountController.text,
      _passwordController.text,
      (data, msg) {
        if (data != null) {
          recordUserInfo(data);
          Future.delayed(
            Duration(milliseconds: 400),
            () {
              hideHUD();
              Navigator.of(context).pop();
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "登录",
        rightItems: [
          buttonWidget(
            Container(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
              alignment: Alignment.center,
              child: Text(
                "注册",
                style: TextStyle(
                  fontSize: 17,
                  color: rgba(51, 51, 51, 1),
                ),
              ),
            ),
            context,
            loginIntercept: false,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return RegisterPage();
                  },
                ),
              ).then(
                (phone) {
                  _accountController.text = phone;
                },
              );
            },
          ),
        ],
      ),
      body: GestureDetector(
        child: Container(
          color: Colors.white,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return index == 0
                  ? Container(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 72),
                      alignment: Alignment.center,
                      child: Image.asset(
                        "images/LOGO@3x.png",
                        width: 75,
                        height: 75,
                      ),
                    )
                  : index == 1
                      ? AccountApi().functionTextField(
                          placeholder: "用户名/手机号",
                          controller: _accountController,
                          onChanged: (text) {
                            this._checkLoginAble();
                          },
                        )
                      : index == 2
                          ? AccountApi().functionTextField(
                              offSet: 4,
                              placeholder: "密码",
                              isSecureTextEntry: true,
                              controller: _passwordController,
                              onChanged: (text) {
                                this._checkLoginAble();
                              },
                            )
                          : index == 3
                              ? Container(
                                  padding: EdgeInsets.fromLTRB(0, 0, 42, 0),
                                  margin: EdgeInsets.fromLTRB(0, 11, 0, 0),
                                  alignment: Alignment.centerRight,
                                  child: buttonWidget(
                                    Text(
                                      "忘记密码",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: rgba(136, 136, 136, 1),
                                      ),
                                    ),
                                    context,
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return ForgotPassword();
                                          },
                                        ),
                                      );
                                    },
                                    loginIntercept: false,
                                  ),
                                )
                              : index == 4
                                  ? Container(
                                      padding:
                                          EdgeInsets.fromLTRB(42, 0, 42, 0),
                                      margin: EdgeInsets.fromLTRB(0, 39, 0, 0),
                                      height: 53,
                                      child: FlatButton(
                                        color: rgba(21, 159, 251, 1),
                                        disabledColor: rgba(136, 207, 253, 1),
                                        onPressed: _loginAble == true
                                            ? () {
                                                this._loginAction();
                                              }
                                            : null,
                                        child: Text(
                                          "登录",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(53 / 2),
                                        ),
                                      ),
                                    )
                                  : index == 5
                                      ? Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 14, 0, 0),
                                          padding:
                                              EdgeInsets.fromLTRB(42, 0, 42, 0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              buttonWidget(
                                                Icon(
                                                  _agreementSelect == true
                                                      ? Icons.check_box
                                                      : Icons
                                                          .check_box_outline_blank,
                                                  color: kMainColor,
                                                  size: 18,
                                                ),
                                                context,
                                                onTap: () {
                                                  setState(() {
                                                    _agreementSelect =
                                                        !_agreementSelect;
                                                    this._checkLoginAble();
                                                  });
                                                },
                                                loginIntercept: false,
                                              ),
                                              SizedBox(
                                                width: 6,
                                              ),
                                              Text(
                                                "登录即表示你同意",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: rgba(136, 136, 136, 1),
                                                ),
                                              ),
                                              buttonWidget(
                                                Text(
                                                  "《注册协议》",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: kMainColor,
                                                  ),
                                                ),
                                                context,
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) {
                                                        return AgreementPage();
                                                      },
                                                    ),
                                                  );
                                                },
                                                loginIntercept: false,
                                              ),
                                            ],
                                          ),
                                        )
                                      : index == 6
                                          ? Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 120, 0, 0),
                                              padding: EdgeInsets.fromLTRB(
                                                  42, 0, 42, 20),
                                              child: Column(
                                                children: <Widget>[
                                                  Row(
                                                    children: <Widget>[
                                                      Expanded(
                                                        child: Container(
                                                          height: 1,
                                                          color:
                                                              kBaseSeparatorColor
                                                                  .withOpacity(
                                                                      0.2),
                                                        ),
                                                      ),
                                                      Container(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                6, 0, 6, 0),
                                                        child: Text(
                                                          "其他登录方式",
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                kBaseSeparatorColor,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          height: 1,
                                                          color:
                                                              kBaseSeparatorColor
                                                                  .withOpacity(
                                                                      0.2),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 22,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children:
                                                        ["微信登录", "QQ登录"].map(
                                                      (item) {
                                                        return Column(
                                                          children: <Widget>[
                                                            item == "微信登录"
                                                                ? buttonWidget(
                                                                    Image.asset(
                                                                      "images/denglu-icon-weixin@3x.png",
                                                                      width: 44,
                                                                      height:
                                                                          44,
                                                                    ),
                                                                    context,
                                                                    onTap: () {
                                                                      kLog(
                                                                          item);
                                                                    },
                                                                    loginIntercept:
                                                                        false,
                                                                    radius: BorderRadius
                                                                        .circular(
                                                                            44 /
                                                                                2),
                                                                  )
                                                                : buttonWidget(
                                                                    Image.asset(
                                                                      "images/denglu-icon-qq@3x.png",
                                                                      width: 44,
                                                                      height:
                                                                          44,
                                                                    ),
                                                                    context,
                                                                    onTap: () {
                                                                      kLog(
                                                                          item);
                                                                    },
                                                                    loginIntercept:
                                                                        false,
                                                                    radius: BorderRadius
                                                                        .circular(
                                                                            44 /
                                                                                2),
                                                                  ),
                                                            SizedBox(
                                                              height: 4,
                                                            ),
                                                            Text(
                                                              item,
                                                              style: TextStyle(
                                                                fontSize: 9,
                                                                color:
                                                                    kBaseSeparatorColor,
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    ).toList(),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Container();
            },
            itemCount: 7,
          ),
        ),
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
      ),
    );
  }
}
