import 'dart:math';

import 'package:flutter/material.dart';
import '../message/views/messagecell.dart';
import '../../public/public.dart';

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

    _list.add(
      MessageCell(
        topSpace: 12.5,
        redCount: 8,
        title: "谁看过我",
        content: "看看有多少人想看你哟~",
        subContent: "07:00",
        icon: "images/kan@3x.png",
      ),
    );

    _list.add(
      MessageCell(
        topSpace: 20,
        bottomSpace: 15,
        redCount: 4,
        title: "谁看过我",
        content: "喜欢你的人有谁呢？",
        subContent: "07:00",
        icon: "images/like@3x.png",
      ),
    );

    _list.add(
      Container(
        padding: EdgeInsets.fromLTRB(13.5, 0, 0, 0),
        child: Divider(
          height: 1,
          color: rgba(231, 231, 231, 1),
        ),
      ),
    );

    _list.add(
      MessageCell(
        topSpace: 15,
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
          topSpace: 20,
          bottomSpace: index == _dataList.length - 1 ? 20 : 0,
          redCount: Random().nextInt(100),
          title: "$element",
          content: "Hi！你好",
          subContent: "07-12 22:30",
          icon:
              "https://upload.jianshu.io/users/upload_avatars/14072228/980d845b-ffda-4a82-8d4e-67ffe82ad13b?imageMogr2/auto-orient/strip|imageView2/1/w/96/h/96",
        ),
      );
    });

    return _list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
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
                // MessageCell(
                //   topSpace: 12.5,
                //   redCount: 8,
                //   title: "谁看过我",
                //   content: "看看有多少人想看你哟~",
                //   subContent: "07:00",
                //   icon: "images/kan@3x.png",
                // ),
                // MessageCell(
                //   topSpace: 20,
                //   bottomSpace: 15,
                //   redCount: 4,
                //   title: "谁看过我",
                //   content: "喜欢你的人有谁呢？",
                //   subContent: "07:00",
                //   icon: "images/like@3x.png",
                // ),
                // Container(
                //   padding: EdgeInsets.fromLTRB(13.5, 0, 0, 0),
                //   child: Divider(
                //     height: 1,
                //     color: rgba(231, 231, 231, 1),
                //   ),
                // ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
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
