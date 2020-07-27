import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_data_picker/flutter_cupertino_data_picker.dart';
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
  TextEditingController _nameEditingController = TextEditingController();
  TextEditingController _signatureEditingController = TextEditingController();
  //基本信息
  List _baseInfoNameList = [
    "昵称",
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

  //编辑内容
  Map _infoPackage = {
    "nickname": "", //昵称
    "birthday": "", //生日
    "gender": "男", //性别 女 男
    "education": "", //学历
    "location": "", //位置
    "height": "", //身高
    "weight": "", //体重
    "signature": "", //个性签名（关于我）
    "liveway": "", //居住
    "child": "", //孩子
    "smoke": "", //抽烟
    "drink": "", //饮酒习惯
  };

  //名称对应显示内容
  String _valueOfName(name) {
    if (name == "联系方式") {
    } else if (name == "生日") {
      return _infoPackage["birthday"];
    } else if (name == "性别") {
      return _infoPackage["gender"];
    } else if (name == "学历") {
      return _infoPackage["education"];
    } else if (name == "身高") {
      return _infoPackage["height"] +
          (ObjectUtil.isEmptyString(_infoPackage["height"]) ? "" : "cm");
    } else if (name == "体重") {
      return _infoPackage["weight"];
    } else if (name == "居住") {
      return _infoPackage["liveway"];
    } else if (name == "孩子") {
      return _infoPackage["child"];
    } else if (name == "抽烟") {
      return _infoPackage["smoke"];
    } else if (name == "饮酒习惯") {
      return _infoPackage["drink"];
    }

    return "";
  }

  //修改内容
  void _infoPageTab(name) {
    if (name == "联系方式") {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) {
          return ContactListPage();
        }),
      );
    } else if (name == "生日") {
      DateTime _date = DateTime.now();
      if (ObjectUtil.isEmptyString(_infoPackage["birthday"]) == false) {
        _date = DateTime.parse(_infoPackage["birthday"]);
      } else {
        setState(() {
          String _dataStr = DateUtil.formatDate(_date, format: "yyyy-MM-dd");
          _infoPackage["birthday"] = _dataStr;
        });
      }

      final picker = CupertinoDatePicker(
        onDateTimeChanged: (date) {
          setState(() {
            String _dataStr = DateUtil.formatDate(date, format: "yyyy-MM-dd");
            _infoPackage["birthday"] = _dataStr;
          });
        },
        initialDateTime: _date,
        mode: CupertinoDatePickerMode.date,
      );

      showCupertinoModalPopup(
          context: context,
          builder: (context) {
            return Container(
              color: Colors.white,
              height: 216,
              child: picker,
            );
          });
    } else if (name == "性别") {
      DataPicker.showDatePicker(
        context,
        datas: ["男", "女"],
        selectedIndex: ["男", "女"].indexOf(_infoPackage["gender"]),
        onConfirm: (data) {
          setState(() {
            _infoPackage["gender"] = data;
          });
        },
      );
    } else if (name == "学历") {
      DataPicker.showDatePicker(
        context,
        datas: ["初中", "中专", "高中", "大专", "本科", "硕士", "博士"],
        selectedIndex: ["初中", "中专", "高中", "大专", "本科", "硕士", "博士"]
            .indexOf(_infoPackage["education"]),
        onConfirm: (data) {
          setState(() {
            _infoPackage["education"] = data;
          });
        },
      );
    } else if (name == "身高") {
      List<String> _heights = [];
      for (var i = 0; i < 61; i++) {
        _heights.add("${140 + i}");
      }
      DataPicker.showDatePicker(
        context,
        datas: _heights,
        selectedIndex: _heights.indexOf(_infoPackage["height"]),
        onConfirm: (data) {
          setState(() {
            _infoPackage["height"] = data;
          });
        },
      );
    } else if (name == "体重") {
      DataPicker.showDatePicker(
        context,
        datas: ["苗条", "健美", "匀称", "性感", "微胖", "丰满有曲线", "肉感"],
        selectedIndex: ["苗条", "健美", "匀称", "性感", "微胖", "丰满有曲线", "肉感"]
            .indexOf(_infoPackage["weight"]),
        onConfirm: (data) {
          setState(() {
            _infoPackage["weight"] = data;
          });
        },
      );
    } else if (name == "居住") {
      DataPicker.showDatePicker(
        context,
        datas: ["一个人住", "和家人住一起", "和某人住一起", "和朋友住一起", "保密"],
        selectedIndex: ["一个人住", "和家人住一起", "和某人住一起", "和朋友住一起", "保密"]
            .indexOf(_infoPackage["liveway"]),
        onConfirm: (data) {
          setState(() {
            _infoPackage["liveway"] = data;
          });
        },
      );
    } else if (name == "孩子") {
      DataPicker.showDatePicker(
        context,
        datas: ["0", "1", "2", "3+", "保密"],
        selectedIndex:
            ["0", "1", "2", "3+", "保密"].indexOf(_infoPackage["child"]),
        onConfirm: (data) {
          setState(() {
            _infoPackage["child"] = data;
          });
        },
      );
    } else if (name == "抽烟") {
      DataPicker.showDatePicker(
        context,
        datas: ["从不抽烟", "偶尔抽烟", "经常抽烟", "保密"],
        selectedIndex:
            ["从不抽烟", "偶尔抽烟", "经常抽烟", "保密"].indexOf(_infoPackage["smoke"]),
        onConfirm: (data) {
          setState(() {
            _infoPackage["smoke"] = data;
          });
        },
      );
    } else if (name == "饮酒习惯") {
      DataPicker.showDatePicker(
        context,
        datas: ["从不饮酒", "礼仪性饮酒", "喜欢喝酒", "保密"],
        selectedIndex:
            ["从不饮酒", "礼仪性饮酒", "喜欢喝酒", "保密"].indexOf(_infoPackage["drink"]),
        onConfirm: (data) {
          setState(() {
            _infoPackage["drink"] = data;
          });
        },
      );
    }
  }

  //提交保存
  void _saveInfoAction() {
    kLog(_infoPackage);
  }

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
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: ListView(
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
                  value: this._valueOfName(name),
                  valueWidget: index == 0
                      ? TextField(
                          textAlign: TextAlign.right,
                          controller: _nameEditingController,
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          onChanged: (text) {
                            setState(() {
                              _infoPackage["nickname"] = text;
                            });
                          },
                        )
                      : index == 7
                          ? TextField(
                              textAlign: TextAlign.right,
                              controller: _signatureEditingController,
                              decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                              onChanged: (text) {
                                setState(() {
                                  _infoPackage["signature"] = text;
                                });
                              },
                            )
                          : null,
                  hideLine:
                      (index == _baseInfoNameList.length - 1) ? true : false,
                  tapHandle: index == 0
                      ? null
                      : () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          this._infoPageTab(name);
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
                  value: this._valueOfName(name),
                  hideLine:
                      (index == _moreInfoNameList.length - 1) ? true : false,
                  tapHandle: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    this._infoPageTab(name);
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
