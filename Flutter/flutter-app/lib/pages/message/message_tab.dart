import 'dart:math';

import 'package:flutter/material.dart';
import '../function/generalalert.dart';
import 'views/messagecell.dart';
import '../../public/public.dart';
import '../mine/views/homepage/upgradealert.dart';
import '../account/functionrecord.dart';
import '../chat/chatmainpage.dart';

class MessagePage extends StatefulWidget {
  MessagePage({Key key}) : super(key: key);

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  List _dataList = [
    "优雅知性之心的人",
    "汪焯翼",
    "Kole Bednar",
    "Shane Hammes",
    "韩辰缶",
    "aaaa",
    "bbbb",
    "cccc",
    "dddd",
    "eeee",
    "ffff",
  ];

  List<Widget> _loadCellList() {
    List<Widget> _list = [];

/*
    _list.add(
      MessageCell(
        padding: EdgeInsets.fromLTRB(13.5, 12.5, 14.5, 12.5),
        redCount: 8,
        title: "谁看过我",
        content: "看看有多少人想看你哟~",
        subContent: "07:00",
        icon: "images/kan@3x.png",
      ),
    );

    _list.add(
      MessageCell(
        padding: EdgeInsets.fromLTRB(13.5, 12.5, 14.5, 12.5), 
        redCount: 4,
        title: "谁看过我",
        content: "喜欢你的人有谁呢？",
        subContent: "07:00",
        icon: "images/like@3x.png",
        tapHandle: () {
          GeneralAlert(
            title: "解锁",
            content: "升级会员可查看【谁喜欢我】\n不要错过缘分哦。",
            confirm: "升级会员",
            confirmHandle: () {
              Future.delayed(Duration(milliseconds: 200), () {
                UpgradeAlert().show(context);
              });
            },
          ).show(context);
        },
      ),
    );
*/
    _list.add(
      Container(
        height: 1,
        padding: EdgeInsets.fromLTRB(13.5, 0, 0, 0),
        color: Colors.white,
        child: Divider(
          height: 1,
          color: rgba(231, 231, 231, 1),
        ),
      ),
    );

    _list.add(
      MessageCell(
        padding: EdgeInsets.fromLTRB(13.5, 10, 14.5, 10),
        redCount: 2,
        title: "约妹",
        content: "Hi！欢迎你使用约妹，祝你使用愉快！",
        subContent: "07:00",
        icon: "images/heart@3x.png",
      ),
    );

    _dataList.forEach((element) {
      int index = _dataList.indexOf(element);
      _list.add(
        MessageCell(
          padding: EdgeInsets.fromLTRB(13.5, 10, 14.5, 10),
          redCount: Random().nextInt(100),
          title: "$element",
          content: "Hi！你好",
          subContent: "07-12 22:30",
          icon:
              "https://upload.jianshu.io/users/upload_avatars/14072228/980d845b-ffda-4a82-8d4e-67ffe82ad13b?imageMogr2/auto-orient/strip|imageView2/1/w/96/h/96",
          tapHandle: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return ChatMainPage();
              }),
            );
          },
        ),
      );
    });

    return _list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rgba(248, 248, 248, 1),
      body: Stack(
        children: <Widget>[
          transparentAppBar(
            brightness: Brightness.light,
          ),
          Positioned(
            left: 0,
            bottom: 0,
            top: 0,
            right: 0,
            child: Column(
              children: <Widget>[
                MessageTitleView(
                  title: "消息",
                ),
                //谁看过我
                MessageCell(
                  padding: EdgeInsets.fromLTRB(13.5, 12.5, 14.5, 12.5),
                  redCount: 8,
                  title: "谁看过我",
                  content: "看看有多少人想看你哟~",
                  subContent: "07:00",
                  icon: "images/kan@3x.png",
                  tapHandle: () {
                    GeneralAlert(
                      title: "解锁",
                      content: "升级会员可查看【谁看过我】\n不要错过缘分哦。",
                      confirm: "升级会员",
                      confirmHandle: () {
                        Future.delayed(Duration(milliseconds: 200), () {
                          UpgradeAlert().show(context);

                          // Navigator.of(context).push(
                          //   MaterialPageRoute(builder: (context) {
                          //     return FunctionRecord(
                          //       recordType: 0,
                          //     );
                          //   }),
                          // );
                        });
                      },
                    ).show(context);
                  },
                ),
                //谁喜欢我
                MessageCell(
                  padding: EdgeInsets.fromLTRB(13.5, 12.5, 14.5, 12.5),
                  redCount: 4,
                  title: "谁喜欢我",
                  content: "喜欢你的人有谁呢？",
                  subContent: "07:00",
                  icon: "images/like@3x.png",
                  tapHandle: () {
                    GeneralAlert(
                      title: "解锁",
                      content: "升级会员可查看【谁喜欢我】\n不要错过缘分哦。",
                      confirm: "升级会员",
                      confirmHandle: () {
                        Future.delayed(Duration(milliseconds: 200), () {
                          //UpgradeAlert().show(context);

                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) {
                              return FunctionRecord(
                                recordType: 1,
                              );
                            }),
                          );
                        });
                      },
                    ).show(context);
                  },
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.only(
                      top: 0,
                    ),
                    children: _loadCellList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageTitleView extends StatelessWidget {
  String title = "";
  MessageTitleView({Key key, this.title = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          16.5, MediaQuery.of(context).padding.top + 8, 16.5, 0),
      width: MediaQuery.of(context).size.width,
      color: rgba(255, 255, 255, 1),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 23,
          fontWeight: FontWeight.bold,
          color: rgba(18, 18, 18, 1),
        ),
      ),
    );
  }
}
