import 'package:flutter/material.dart';
import 'package:time_flies/public/public.dart';

// ignore: must_be_immutable
class HomePageHeader extends StatefulWidget {
  GlobalKey globalKey;
  HomePageHeader({
    Key key,
    @required this.globalKey,
  }) : super(key: key);

  @override
  _HomePageHeaderState createState() => _HomePageHeaderState();
}

class _HomePageHeaderState extends State<HomePageHeader> {
  List<String> _itemList = [
    "获赞",
    "·",
    "关注",
    "·",
    "粉丝",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      key: this.widget.globalKey,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 20,
        bottom: 18,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white,
            Colors.white,
            Colors.white,
            rgba(237, 237, 237, 0.3),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 头像
          networkImage(
            "",
            Size(98, 98),
            BorderRadius.circular(98 / 2),
          ),
          SizedBox(
            height: 18,
          ),
          // 用户名
          Text(
            "用户名",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          // 用户id
          Container(
            padding: EdgeInsets.fromLTRB(3, 2, 3, 0),
            decoration: BoxDecoration(
              color: Colors.limeAccent,
              borderRadius: BorderRadius.circular(3),
            ),
            child: Text(
              "ID: 12345",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          SizedBox(
            height: 22,
          ),
          // 简介
          Text(
            "暂无简介",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: _itemList.map((item) {
              if (item == "·") {
              } else {}
            }).toList(),
          ),
        ],
      ),
    );
  }
}
