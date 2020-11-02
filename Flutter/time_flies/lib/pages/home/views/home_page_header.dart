import 'package:flutter/material.dart';
import 'package:time_flies/pages/home/account_list.dart';
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

  // 粉丝列表
  void _fanList() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return AccountListPage();
      }),
    );
  }

  // 关注列表
  void _attentionList() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return AccountListPage();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: this.widget.globalKey,
      padding: EdgeInsets.only(bottom: 16),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top + 20,
          ),
          // 头像
          Stack(
            children: [
              networkImage(
                "",
                Size(98, 98),
                BorderRadius.circular(98 / 2),
              ),
              // 性别
              Positioned(
                right: 0,
                bottom: 0,
                child: Icon(
                  Icons.check_circle,
                ),
              ),
            ],
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
              color: rgba(255, 44, 96, 1),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Text(
              "ID: 12345",
              style: TextStyle(
                color: Colors.white,
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: _itemList.map((item) {
              if (item == "·") {
                return Container(
                  margin: EdgeInsets.only(left: 12, right: 12),
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(4 / 2),
                  ),
                );
              } else {
                return InkWell(
                  onTap: () {
                    if (item == "关注") {
                      this._attentionList();
                    } else if (item == "粉丝") {
                      this._fanList();
                    }
                  },
                  child: RichText(
                    text: TextSpan(
                      text: "0" + " ",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: "$item",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            }).toList(),
          ),
          SizedBox(
            height: 20,
          ),
          //编辑、关注、已关注
          FlatButton.icon(
            padding: EdgeInsets.zero,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(44 / 2),
            ),
            onPressed: () {},
            icon: Icon(
              Icons.edit,
              size: 18,
              color: Colors.grey,
            ),
            label: Text(
              "编辑",
            ),
          ),
        ],
      ),
    );
  }
}
