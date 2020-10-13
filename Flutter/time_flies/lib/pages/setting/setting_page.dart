import 'package:flutter/material.dart';
import 'package:time_flies/pages/setting/about_page.dart';
import 'package:time_flies/public/public.dart';

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

  // 退出登录
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
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 100), () {
      this._getCacheSize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "设置",
        defaultBack: true,
      ),
      body: ListView(
        children: [
          Material(
            color: Colors.white,
            child: ListTile(
              onTap: () {
                this._cleanCache();
              },
              title: Text(
                "清理缓存",
              ),
              trailing: Text(
                _cacheSize,
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
            ),
          ),
          Material(
            color: Colors.white,
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    return AboutPage();
                  }),
                );
              },
              title: Text(
                "关于",
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: Colors.grey,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 44),
            child: Material(
              color: Colors.white,
              child: ListTile(
                onTap: () {
                  this._logoutAction();
                },
                title: Text(
                  "退出登录",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
