import 'package:flutter/material.dart';
import 'package:repayment_flutter/pages/mine/aboutuspage.dart';
import 'package:repayment_flutter/pages/mine/helptippage.dart';
import 'package:repayment_flutter/public/public.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  List<String> _settingList = [
    "使用帮助",
    "关于我们",
    "清除缓存",
    "退出当前账号"
  ]; //["使用帮助", "关于我们", "清除缓存"]

  void _logoutAction() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "提示",
          ),
          content: Text(
            "是否退出当前账号",
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "取消",
              ),
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
                Future.delayed(
                  Duration(milliseconds: 300),
                  () {
                    // showHUD();
                    // logoutAcctount();
                    // Future.delayed(
                    //   Duration(milliseconds: 10),
                    //   () {
                    //     DartNotificationCenter.post(
                    //         channel: kForceLogoutNotification, options: null);
                    //   },
                    // );
                  },
                );
              },
              child: Text(
                "确定",
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "设置",
        backgroundColor: kMainColor,
        color: Colors.white,
        brightness: Brightness.dark,
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return buttonWidget(
            Container(
              height: 50,
              padding: EdgeInsets.fromLTRB(16, 0, 8, 0),
              child: index == 3
                  ? Center(
                      child: Text(
                        _settingList[index],
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          _settingList[index],
                        ),
                        Row(
                          children: <Widget>[
                            index == 2
                                ? Text(
                                    "0.00KB",
                                  )
                                : Container(),
                            Icon(
                              Icons.chevron_right,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ],
                    ),
            ),
            context,
            onTap: () {
              if (index == 3) {
                this._logoutAction();
              } else if (index == 0) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return HelptipPage();
                    },
                  ),
                );
              } else if (index == 1) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return AboutusPage();
                    },
                  ),
                );
              } else if (index == 2) {}
            },
            color: Colors.white,
          );
        },
        separatorBuilder: (context, index) {
          return (index == 1 || index == 2)
              ? Container(
                  height: 12,
                )
              : Row(
                  children: <Widget>[
                    Container(
                      width: 16,
                      height: 1,
                      color: Colors.white,
                    ),
                    Expanded(
                      child: Container(
                        height: 1,
                      ),
                    ),
                  ],
                );
        },
        itemCount: _settingList.length,
      ),
    );
  }
}
