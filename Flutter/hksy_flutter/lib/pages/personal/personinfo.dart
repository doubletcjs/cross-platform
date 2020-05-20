import 'package:flutter/material.dart';
import 'package:hksy_flutter/pages/personal/views/infosectioncell.dart';
import 'package:hksy_flutter/public/public.dart';

class PersonInfo extends StatefulWidget {
  PersonInfo({Key key}) : super(key: key);

  @override
  _PersonInfoState createState() => _PersonInfoState();
}

class _PersonInfoState extends State<PersonInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      appBar: customAppBar(
        title: "个人信息",
        brightness: Brightness.dark,
        backgroundColor: kMainBackgroundColor,
        color: Colors.white,
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(12, 20, 12, 0),
        children: <Widget>[
          InfoSection(
            cells: [
              InfoCell(
                name: "头像",
                isPortrait: true,
              ),
              InfoCell(
                name: "昵称",
                value: "ID12347865",
              ),
              InfoCell(
                name: "实名认证",
                showLine: false,
                showArrow: false,
                value: "151*****3552",
              ),
            ],
          ),
          InfoSection(
            topSpace: 20,
            cells: [
              InfoCell(
                name: "实名认证",
                showLine: false,
                value: "未认证",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
