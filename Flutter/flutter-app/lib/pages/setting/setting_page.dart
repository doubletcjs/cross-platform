import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';
import 'feedback.dart';
import 'reset_phone.dart';
import 'cancel_account.dart';
import '../../public/public.dart';
import 'views/setting_section_cell.dart';
import '../account/block_list_page.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  ImageCache get imageData => PaintingBinding.instance.imageCache;
  String _cacheSize = ""; //缓存大小

  //缓存大小
  void _getCacheSize() {
    int byteData = imageData.currentSizeBytes;
    setState(() {
      _cacheSize = "${(byteData / (1024 * 8) / 1024).toStringAsFixed(2)}" + "M";
    });
  }

  //清理缓存
  void _cleanCache() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text("确定要清空缓存吗？"),
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
                imageData.clear();
                setState(() {
                  this._getCacheSize();
                });
              },
            ),
          ],
        );
      },
    );
  }

  //退出登录
  void _handleLogout() {
    XsProgressHud.show(context);
    recordToken("");
    recordUserID("");

    DartNotificationCenter.post(
      channel: kAccountHandleNotification,
      options: {
        "type": 2,
      },
    );
    Future.delayed(Duration(milliseconds: 600), () {
      XsProgressHud.hide();
      Navigator.of(context).popUntil(ModalRoute.withName("/"));
    });
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

  Map _account = {};
  //获取用户信息
  void _refreshAccount() {
    setState(() {
      _account = currentAccount;
    });
  }

  @override
  void initState() {
    super.initState();

    DartNotificationCenter.subscribe(
      channel: kAccountHandleNotification,
      observer: this,
      onNotification: (option) {
        //type 0 登录 1 请求账号信息刷新 2 登出 3 请求账号信息结束，刷新本地记录用户信息
        if (option["type"] == 3) {
          this._refreshAccount();
        }
      },
    );

    setState(() {
      _account = currentAccount;
    });

    Future.delayed(Duration(milliseconds: 100), () {
      this._getCacheSize();
    });
  }

  @override
  void dispose() {
    super.dispose();

    DartNotificationCenter.unsubscribe(observer: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rgba(248, 248, 248, 1),
      appBar: customAppBar(
        title: "设置",
        elevation: 0.5,
      ),
      body: ListView(
        children: <Widget>[
          // 黑名单
          SettingBaseSection(),
          SettingBaseCell(
            name: "黑名单",
            hideLine: true,
            tapHandle: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return BlockListPage();
                }),
              );
            },
          ),
          // 新消息提醒
          SettingBaseSection(
            title: "新消息提醒",
          ),
          SettingBaseCell(
            name: "声音",
            valueWidget: CupertinoSwitch(
              activeColor: rgba(255, 45, 85, 1),
              value: true,
              onChanged: (isOn) {},
            ),
          ),
          SettingBaseCell(
            name: "震动",
            hideLine: true,
            valueWidget: CupertinoSwitch(
              activeColor: rgba(255, 45, 85, 1),
              value: true,
              onChanged: (isOn) {},
            ),
          ),
          // 隐私
          SettingBaseSection(
            title: "隐私",
          ),
          SettingBaseCell(
            name: "不再出现“附件的人”",
            hideLine: true,
            valueWidget: CupertinoSwitch(
              activeColor: rgba(255, 45, 85, 1),
              value: false,
              onChanged: (isOn) {},
            ),
          ),
          // 账号与安全
          SettingBaseSection(
            title: "账号与安全",
          ),
          SettingBaseCell(
            name: "更改手机号",
            value: _account != null && _account["mobile"] != null
                ? _account["mobile"]
                : "",
            tapHandle: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return ResetPhonePage();
                }),
              );
            },
          ),
          SettingBaseCell(
            name: "注销账号",
            hideLine: true,
            tapHandle: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return CancelAccountPage();
                }),
              );
            },
          ),
          // 清理缓存
          SettingBaseSection(),
          SettingBaseCell(
            name: "清理缓存",
            value: _cacheSize,
            hideLine: true,
            tapHandle: () {
              this._cleanCache();
            },
          ),
          // 意见反馈
          SettingBaseSection(),
          SettingBaseCell(
            name: "意见反馈",
            hideLine: true,
            tapHandle: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return FeedBackPage();
                }),
              );
            },
          ),
          // 退出
          Container(
            margin: EdgeInsets.fromLTRB(23, 14.5, 23, 32.5),
            height: 44,
            width: MediaQuery.of(context).size.width,
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
          )
        ],
      ),
    );
  }
}
