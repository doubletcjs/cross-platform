import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../public/public.dart';
import 'views/settingsectioncell.dart';
import '../account/blocklistpage.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
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
            value: "182****8820",
            tapHandle: () {},
          ),
          SettingBaseCell(
            name: "注销账号",
            tapHandle: () {},
          ),
          // 清理缓存
          SettingBaseSection(),
          SettingBaseCell(
            name: "清理缓存",
            value: "7.09M",
            hideLine: true,
            tapHandle: () {},
          ),
          // 意见反馈
          SettingBaseSection(),
          SettingBaseCell(
            name: "意见反馈",
            hideLine: true,
            tapHandle: () {},
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
              onPressed: () {},
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
