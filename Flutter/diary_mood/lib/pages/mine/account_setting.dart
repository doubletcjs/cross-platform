import 'package:diary_mood/pages/mine/cancel_account.dart';
import 'package:diary_mood/pages/mine/reset_phone.dart';
import 'package:diary_mood/public/public.dart';
import 'package:flutter/material.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';

class AccountSetting extends StatefulWidget {
  AccountSetting({Key key}) : super(key: key);

  @override
  _AccountSettingState createState() => _AccountSettingState();
}

class _AccountSettingState extends State<AccountSetting> {
  List<String> _dataList = ["更改手机号", "注销账号"];

  //退出登录
  void _handleLogout() {
    XsProgressHud.show(context);
  }

  void _logoutAction() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text("确定要退出吗？"),
          actions: <Widget>[
            FlatButton(
              child: Text("取消"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("确定"),
              onPressed: () {
                Navigator.of(context).pop();
                this._handleLogout();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("账号设置"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return Material(
                  color: rgba(255, 255, 255, 1),
                  child: ListTile(
                    title: Text(
                      _dataList[index],
                    ),
                    onTap: () {
                      if (_dataList[index] == "更改手机号") {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) {
                            return ResetPhonePage();
                          }),
                        );
                      } else if (_dataList[index] == "注销账号") {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) {
                            return CancelAccountPage();
                          }),
                        );
                      }
                    },
                    trailing: Icon(Icons.chevron_right),
                  ),
                );
              },
              itemCount: _dataList.length,
            ),
            SizedBox(
              height: 20,
            ),
            //退出
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
                  this._logoutAction();
                },
                child: Text(
                  "退出",
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
          ],
        ),
      ),
    );
  }
}
