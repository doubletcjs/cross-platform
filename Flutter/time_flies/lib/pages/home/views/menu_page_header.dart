import 'package:flutter/material.dart';
import 'package:time_flies/pages/home/account_list.dart';
import 'package:time_flies/pages/home/home_page.dart';
import 'package:time_flies/public/public.dart';

class MenuPageHeader extends StatefulWidget {
  MenuPageHeader({Key key}) : super(key: key);

  @override
  _MenuPageHeaderState createState() => _MenuPageHeaderState();
}

class _MenuPageHeaderState extends State<MenuPageHeader> {
  List<String> _itemList = [
    "作品",
    "关注",
    "粉丝",
  ];

  // 个人主页
  void _homePage() {
    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return HomePage();
      }),
    );
  }

  // 粉丝列表
  void _fanList() {
    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return AccountListPage();
      }),
    );
  }

  // 关注列表
  void _attentionList() {
    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return AccountListPage();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 20 + 14.0,
              ),
              // 头像
              Stack(
                children: [
                  networkImage(
                    "",
                    Size(68, 68),
                    BorderRadius.circular(68 / 2),
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
                width: 20,
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: Colors.grey,
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
          Text(
            "ID: 12345",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: 22,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _itemList.map((item) {
              return Expanded(
                child: InkWell(
                  onTap: () {
                    if (item == "作品") {
                      this._homePage();
                    } else if (item == "关注") {
                      this._attentionList();
                    } else if (item == "粉丝") {
                      this._fanList();
                    }
                  },
                  child: Column(
                    children: [
                      Text(
                        "0",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "$item",
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
