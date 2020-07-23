import 'package:flutter/material.dart';
import './views/homepage/infosectioncell.dart';
import '../../public/public.dart';

class MineEditPage extends StatefulWidget {
  MineEditPage({Key key}) : super(key: key);

  @override
  _MineEditPageState createState() => _MineEditPageState();
}

class _MineEditPageState extends State<MineEditPage> {
  //保存
  void _saveInfoAction() {}
  //基本信息
  List _baseInfoNameList = [
    "呢称",
    "生日",
    "性别",
    "学历",
    "位置",
    "身高",
    "体重",
    "关于我",
    "联系方式",
  ];
  //详细信息
  List _moreInfoNameList = [
    "居住",
    "孩子",
    "抽烟",
    "饮酒习惯",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      appBar: customAppBar(
        title: "编辑主页",
        elevation: 0.5,
        rightItems: [
          Center(
            child: Container(
              width: 54,
              height: 27,
              margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [rgba(255, 44, 96, 1), rgba(255, 114, 81, 1)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerLeft,
                ),
                borderRadius: BorderRadius.circular(27 / 2),
              ),
              child: FlatButton(
                padding: EdgeInsets.fromLTRB(0, 4.5, 0, 4.5),
                onPressed: () {
                  this._saveInfoAction();
                },
                child: Text(
                  "保存",
                  style: TextStyle(
                    color: rgba(255, 255, 255, 1),
                    fontSize: 13,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(27 / 2),
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        // padding: EdgeInsets.zero,
        children: <Widget>[
          InfoBaseSection(
            title: "基本信息",
          ),
          Column(
            children: _baseInfoNameList.map((name) {
              int index = _baseInfoNameList.indexOf(name);
              return InfoBaseCell(
                name: name,
                value: "内容",
                hideLine:
                    (index == _baseInfoNameList.length - 1) ? true : false,
              );
            }).toList(),
          ),
          InfoBaseSection(
            title: "详细信息",
          ),
          Column(
            children: _moreInfoNameList.map((name) {
              int index = _moreInfoNameList.indexOf(name);
              return InfoBaseCell(
                name: name,
                value: "内容",
                hideLine:
                    (index == _moreInfoNameList.length - 1) ? true : false,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
