import 'package:flutter/material.dart';
import 'package:repayment_flutter/public/public.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        leftItem: buttonWidget(
          Center(
            child: Text(
              "取消",
              style: TextStyle(
                fontSize: 16,
                color: kMainColor,
              ),
            ),
          ),
          context,
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Container(
              child: Image.asset(
                "images/placeholder@3x.png",
                width: 76,
                height: 76,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
              width: MediaQuery.of(context).size.width,
              height: 38,
              child: FlatButton(
                onPressed: () {},
                color: kMainColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "images/icon_login_wechat.png",
                      width: 22,
                      height: 18,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      "微信登录",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "当前仅支持微信登录",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
