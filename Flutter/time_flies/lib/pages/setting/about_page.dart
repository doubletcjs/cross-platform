import 'package:flutter/material.dart';
import 'package:time_flies/public/public.dart';

class AboutPage extends StatefulWidget {
  AboutPage({Key key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "关于",
        defaultBack: true,
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: 66,
              bottom: 66,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // logo
                networkImage(
                  "",
                  Size(108, 108),
                  BorderRadius.circular(108 / 2),
                ),
                SizedBox(
                  height: 20,
                ),
                // 版本号
                Text(
                  "Version 1.0.9 Build 1009",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Material(
            color: Colors.white,
            child: ListTile(
              onTap: () {},
              title: Text(
                "隐私政策",
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: Colors.grey,
              ),
            ),
          ),
          Material(
            color: Colors.white,
            child: ListTile(
              onTap: () {},
              title: Text(
                "服务协议",
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: Colors.grey,
              ),
            ),
          ),
          SizedBox(
            height: 44,
          ),
        ],
      ),
    );
  }
}
