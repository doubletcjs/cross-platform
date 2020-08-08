import 'package:flutter/material.dart';
import '../../public/public.dart';
import 'login_register.dart';

class AccountMainPage extends StatefulWidget {
  AccountMainPage({Key key}) : super(key: key);

  @override
  _AccountMainPageState createState() => _AccountMainPageState();
}

class _AccountMainPageState extends State<AccountMainPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          transparentAppBar(),
          Container(
            padding: EdgeInsets.fromLTRB(
                30, 0, 30, (64 + MediaQuery.of(context).padding.bottom)),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    height: 80 - MediaQuery.of(context).padding.top,
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        "Yue Mei",
                        style: TextStyle(
                          fontSize: 54,
                          color: rgba(255, 255, 255, 1),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 12.5,
                      ),
                      Text(
                        "Welcome to Yue Mei and start your mysterious journey.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          color: rgba(255, 255, 255, 1),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      //注册
                      Container(
                        height: 44,
                        width: MediaQuery.of(context).size.width,
                        child: FlatButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return LoginRegisterPage(
                                    isRegister: true,
                                  );
                                },
                              ),
                            );
                          },
                          child: Text(
                            "注册",
                            style: TextStyle(
                              fontSize: 16,
                              color: rgba(255, 45, 85, 1),
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(44 / 2),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: rgba(255, 255, 255, 1),
                          borderRadius: BorderRadius.circular(44 / 2),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      //登录
                      Container(
                        height: 44,
                        width: MediaQuery.of(context).size.width,
                        child: FlatButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return LoginRegisterPage();
                                },
                              ),
                            );
                          },
                          child: Text(
                            "登录",
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
                        height: 47.5,
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
                                color: rgba(204, 204, 204, 1),
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Text(
                                "用户协议和隐私政策",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: rgba(204, 204, 204, 1),
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            rgba(255, 132, 96, 1),
            rgba(193, 50, 148, 1),
            rgba(59, 48, 220, 1),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}
