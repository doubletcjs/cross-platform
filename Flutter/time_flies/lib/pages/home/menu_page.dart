import 'package:flutter/material.dart';
import 'package:time_flies/pages/home/home_page.dart';
import 'package:time_flies/pages/home/views/menu_page_header.dart';
import 'package:time_flies/pages/message/message_center.dart';
import 'package:time_flies/pages/search/search_center.dart';
import 'package:time_flies/pages/setting/setting_page.dart';

class MenuPage extends StatefulWidget {
  MenuPage({Key key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  // 消息中心
  void _messagePage() {
    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return MessageCenter();
      }),
    );
  }

  // 搜索中心
  void _searchPage() {
    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return SearchCenter();
      }),
    );
  }

  // 设置
  void _settingPage() {
    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return SettingPage();
      }),
    );
  }

  // 个人主页
  void _homePage() {
    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return HomePage();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          InkWell(
            onTap: () {
              this._homePage();
            },
            child: MenuPageHeader(),
          ),
          ListTile(
            leading: Icon(
              Icons.notifications,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: Colors.grey,
            ),
            title: Align(
              child: Text(
                "消息",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.normal,
                ),
              ),
              alignment: Alignment(-1.25, 0),
            ),
            onTap: () {
              this._messagePage();
            },
          ),
          ListTile(
            leading: Icon(
              Icons.search,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: Colors.grey,
            ),
            title: Align(
              child: Text(
                "搜索",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.normal,
                ),
              ),
              alignment: Alignment(-1.25, 0),
            ),
            onTap: () {
              this._searchPage();
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: Colors.grey,
            ),
            title: Align(
              child: Text(
                "设置",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.normal,
                ),
              ),
              alignment: Alignment(-1.25, 0),
            ),
            onTap: () {
              this._settingPage();
            },
          ),
        ],
      ),
    );
  }
}
