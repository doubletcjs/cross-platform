import 'package:flutter/material.dart';
import 'package:hksy_flutter/function/paycode/paycodepage.dart';
import 'package:hksy_flutter/pages/mine/aboutuspage.dart';
import 'package:hksy_flutter/pages/mine/agreetment.dart';
import 'package:hksy_flutter/function/infosectioncell.dart';
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
                tapHandle: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return PaycodePage();
                      },
                    ),
                  );
                },
              ),
              InfoCell(
                name: "注册协议",
                showLine: false,
                tapHandle: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return AgreenMentPage();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          InfoSection(
            cells: <Widget>[
              InfoCell(
                name: "关于我们",
                showLine: false,
                tapHandle: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return AboutusPage();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
          SizedBox(
            height: 35.5,
          ),
          InfoSection(
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
                onTap: () {
                  functionAlertView(
                    context,
                    title: "注销登录",
                    content: "你确定注销当前账号？",
                    confirm: "确认",
                    cancel: "取消",
                    contentPadding: EdgeInsets.fromLTRB(25, 25, 25, 55),
                    confirmHandle: () {},
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
