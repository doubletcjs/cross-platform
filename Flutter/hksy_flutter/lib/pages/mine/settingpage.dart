import 'package:flutter/material.dart';
import 'package:hksy_flutter/pages/personal/views/infosectioncell.dart';
import 'package:hksy_flutter/public/public.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      appBar: customAppBar(
        title: "设置中心",
        brightness: Brightness.dark,
        backgroundColor: kMainBackgroundColor,
        color: Colors.white,
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(12, 20, 12, 0),
        children: <Widget>[
          InfoSection(
            cells: <Widget>[
              InfoCell(
                name: "支付密码设置",
                tapHandle: () {},
              ),
              InfoCell(
                name: "注册协议",
                showLine: false,
                tapHandle: () {},
              ),
            ],
          ),
          InfoSection(
            topSpace: 20,
            cells: <Widget>[
              InfoCell(
                name: "关于我们",
                showLine: false,
                tapHandle: () {
                  kLog("any");
                },
              ),
            ],
          ),
          InfoSection(
            topSpace: 35.5,
            cells: <Widget>[
              InkWell(
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 14, 0, 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "退出登录",
                        style: TextStyle(
                          color: rgba(145, 152, 173, 1),
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
