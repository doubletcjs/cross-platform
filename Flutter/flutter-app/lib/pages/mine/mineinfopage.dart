import 'package:flutter/material.dart';
import 'views/homepage/infosectioncell.dart';
import 'views/homepage/covergridview.dart';
import '../../public/public.dart';
import 'contactlist.dart';

class MineInfoPage extends StatefulWidget {
  MineInfoPage({Key key}) : super(key: key);

  @override
  _MineInfoPageState createState() => _MineInfoPageState();
}

class _MineInfoPageState extends State<MineInfoPage> {
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
      backgroundColor: rgba(248, 248, 248, 1),
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
          //编辑封面
          Container(
            padding: EdgeInsets.fromLTRB(8.5, 10, 8.5, 15),
            color: rgba(255, 255, 255, 1),
            child: Column(
              children: <Widget>[
                //编辑封面
                CoverGridView(
                  coverAddition: true,
                  gridWidth: MediaQuery.of(context).size.width - 8.5 * 2,
                ),
                //温馨提醒
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(10.5, 10.5, 10.5, 10.5),
                  decoration: BoxDecoration(
                    color: rgba(243, 243, 243, 1),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 15.5,
                        height: 15.5,
                        margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
                        child: Image.asset(
                          "images/tishi@3x.png",
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          "温馨提醒：尊敬的用户，Yue Mie是一个真实的交友平台，杜绝虚假请自拍正脸视频证明照片是本人头像和视频一直才能通过审核",
                          style: TextStyle(
                            fontSize: 12,
                            color: rgba(51, 51, 51, 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          //基本信息section
          InfoBaseSection(
            title: "基本信息",
          ),
          //基本信息
          Column(
            children: _baseInfoNameList.map((name) {
              int index = _baseInfoNameList.indexOf(name);
              return InfoBaseCell(
                name: name,
                value: "内容",
                hideLine:
                    (index == _baseInfoNameList.length - 1) ? true : false,
                tapHandle: () {
                  if (name == "联系方式") {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return ContactListPage();
                      }),
                    );
                  }
                },
              );
            }).toList(),
          ),
          //详细信息section
          InfoBaseSection(
            title: "详细信息",
          ),
          //详细信息
          Column(
            children: _moreInfoNameList.map((name) {
              int index = _moreInfoNameList.indexOf(name);
              return InfoBaseCell(
                name: name,
                value: "内容",
                hideLine:
                    (index == _moreInfoNameList.length - 1) ? true : false,
                tapHandle: () {},
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
