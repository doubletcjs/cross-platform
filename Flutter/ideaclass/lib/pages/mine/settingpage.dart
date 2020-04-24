import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ideaclass/pages/account/accountsecurity.dart';
import 'package:ideaclass/pages/account/api/accountapi.dart';
import 'package:ideaclass/pages/account/personinfopage.dart';
import 'package:ideaclass/pages/mine/aboutus.dart';
import 'package:ideaclass/pages/mine/feedback.dart';
import 'package:ideaclass/pages/mine/views/settingcell.dart';
import 'package:ideaclass/public/public.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  List<String> _settingList = [
    "账号",
    "2G/3G/4G播放和下载",
    "新消息通知",
    "账户安全",
    "意见反馈",
    "检查更新",
    "清除缓存",
    "关于纵想课堂",
    "退出当前账号"
  ];

  void _logoutAction() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "提示",
          ),
          content: Text(
            "确定退出",
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
                    showHUD();
                    logoutAcctount();
                    Future.delayed(
                      Duration(milliseconds: 10),
                      () {
                        DartNotificationCenter.post(
                            channel: kForceLogoutNotification, options: null);
                      },
                    );
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

  Map _account = {};
  void _refreshAccount() {
    AccountApi().loadLocalAccount(
      (user) { 
        setState(
          () {
            _account = user;
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    this._refreshAccount();
    DartNotificationCenter.subscribe(
      channel: kRefreshAccountNotification,
      observer: this,
      onNotification: (options) { 
        this._refreshAccount();
      },
    );
  }

  @override
  void dispose() {
    DartNotificationCenter.unsubscribe(
        observer: this, channel: kRefreshAccountNotification); 

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "设置",
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return index == _settingList.length - 1
                ? Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    height: 49,
                    child: FlatButton(
                      color: kMainColor,
                      onPressed: () {
                        this._logoutAction();
                      },
                      child: Text(
                        _settingList[index],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  )
                : index == 0
                    ? SettingAccountCell(
                        avatar: _account["avatar"],
                        nickname: _account["nickname"],
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return PersonInfoPage();
                              },
                            ),
                          );
                        },
                      )
                    : SettingCell(
                        text: _settingList[index],
                        tapHandle: () {
                          if (index == 4) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return FeedBackPage();
                                },
                              ),
                            );
                          } else if (index == 7) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return AboutUsPage();
                                },
                              ),
                            );
                          } else if (index == 3) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return AccountSecurityPage();
                                },
                              ),
                            );
                          }
                        },
                      );
          },
          separatorBuilder: (context, index) {
            return Container(
              height: (index == _settingList.length - 2)
                  ? 130
                  : ((index == 0 || index == 2) ? 7 : 1),
            );
          },
          itemCount: _settingList.length),
    );
  }
}
