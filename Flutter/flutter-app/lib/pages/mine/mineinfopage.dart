import 'dart:convert';

import 'package:city_pickers/city_pickers.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';
import 'views/homepage/infosectioncell.dart';
import 'views/homepage/covergridview.dart';
import '../../public/public.dart';
import 'contactlist.dart';
import '../account/api/accountapi.dart';
import '../function/datapicker.dart';
import '../../public/networking.dart';

class MineInfoPage extends StatefulWidget {
  MineInfoPage({Key key}) : super(key: key);

  @override
  _MineInfoPageState createState() => _MineInfoPageState();
}

class _MineInfoPageState extends State<MineInfoPage> {
  TextEditingController _nameEditingController = TextEditingController();
  TextEditingController _signatureEditingController = TextEditingController();
  CoverGridView _gridView;

  List _coverList = [];
  Map _account = {}; //用户信息
  //获取用户信息
  void _refreshAccount() {
    XsProgressHud.show(context);
    AccountApi.profile((data, msg) {
      XsProgressHud.hide();
      if (data != null) {
        //处理用户信息数据
        Map<String, Object> _info = {};
        Map _data = Map.from(data);
        _account = _data;

        _info["nickname"] = ObjectUtil.isEmpty(_data["nickname"]) == true
            ? ""
            : _data["nickname"];
        _info["birthday"] = ObjectUtil.isEmpty(_data["birthday"]) == true
            ? ""
            : _data["birthday"];
        _info["education"] = ObjectUtil.isEmpty(_data["education"]) == true
            ? 0
            : _data["education"];
        _info["height"] =
            ObjectUtil.isEmpty(_data["height"]) == true ? 0 : _data["height"];
        _info["weight"] =
            ObjectUtil.isEmpty(_data["weight"]) == true ? "" : _data["weight"];
        _info["signature"] = ObjectUtil.isEmpty(_data["signature"]) == true
            ? ""
            : _data["signature"];
        _info["living_status"] =
            ObjectUtil.isEmpty(_data["living_status"]) == true
                ? 0
                : _data["living_status"];
        _info["child_nums"] = ObjectUtil.isEmpty(_data["child_nums"]) == true
            ? 0
            : _data["child_nums"];
        _info["smoking_habit"] =
            ObjectUtil.isEmpty(_data["smoking_habit"]) == true
                ? 0
                : _data["smoking_habit"];
        _info["drinking_habit"] =
            ObjectUtil.isEmpty(_data["drinking_habit"]) == true
                ? 0
                : _data["drinking_habit"];
        //省市区
        _info["province"] = ObjectUtil.isEmpty(_data["province"]) == true
            ? 0
            : _data["province"];
        _info["city"] =
            ObjectUtil.isEmpty(_data["city"]) == true ? 0 : _data["city"];
        _info["province_name"] =
            ObjectUtil.isEmpty(_data["province_name"]) == true
                ? ""
                : _data["province_name"];
        _info["city_name"] = ObjectUtil.isEmpty(_data["city_name"]) == true
            ? ""
            : _data["city_name"];

        _account["photo"] = ObjectUtil.isEmpty(_account["photo"]) == true
            ? []
            : _account["photo"];
        _coverList = _account["photo"];
        setState(() {
          _infoPackage = Map.from(_info);
          _nameEditingController.text = _infoPackage["nickname"];
          _signatureEditingController.text = _infoPackage["signature"];

          _gridView = CoverGridView(
            coverAddition: true,
            coverList: List.from(_coverList),
            gridWidth: MediaQuery.of(context).size.width - 8.5 * 2,
            updateHandle: (list) {
              setState(() {
                _coverList = List.from(list);
              });
            },
          );
        });
      } else {
        showToast(msg, context);
      }
    });
  }

  //基本信息
  List _baseInfoList = [
    {
      "nickname": "昵称",
    },
    {
      "birthday": "生日",
    },
    {
      "education": "学历",
    },
    {
      "location": "位置",
    },
    {
      "height": "身高",
    },
    {
      "weight": "体重",
    },
    {
      "signature": "关于我",
    },
    {
      "contact": "联系方式",
    },
  ];
  //详细信息
  List _moreInfoList = [
    {
      "living_status": "居住",
    },
    {
      "child_nums": "孩子",
    },
    {
      "smoking_habit": "抽烟",
    },
    {
      "drinking_habit": "饮酒习惯",
    },
  ];

  //编辑内容
  Map<String, Object> _infoPackage = {
    "nickname": "", //昵称
    "birthday": "", //生日
    "education": 0, //学历 0：保密 1：小学 2：初中 3：高中 4：专科 5：本科 6：硕士 7：博士
    "height": 0, //身高
    "weight": "", //体重
    "signature": "", //个性签名（关于我）
    "living_status": 0, //居住状态 0：保密 1：一个人 2：和家人 3：和某人 4：和朋友
    "child_nums": 0, //小孩数量
    "smoking_habit": 0, //抽烟习惯 0：保密 1：从不 2：偶尔 3：经常
    "drinking_habit": 0, //喝酒习惯 0：保密 1：从不 2：偶尔 3：经常

    "province": 0, //省编码
    "city": 0, //市编码
    "province_name": "", //省
    "city_name": "", //市
  };

  //名称对应显示内容
  String _valueOfName(key) {
    if (key == "height") {
      return "${_infoPackage['height']}cm";
    } else if (key == "child_nums") {
      return "${_infoPackage['child_nums']} ";
    } else if (key == "education") {
      List _educations = ["保密", "小学", "初中", "高中", "专科", "本科", "硕士", "博士"];
      return _educations[_infoPackage["education"]];
    } else if (key == "living_status") {
      List _livingstatus = ["保密", "一个人", "和家人", "和某人", "和朋友"];
      return _livingstatus[_infoPackage["living_status"]];
    } else if (key == "drinking_habit") {
      List _drinkinghabit = ["保密", "从不", "偶尔", "经常"];
      return _drinkinghabit[_infoPackage["drinking_habit"]];
    } else if (key == "smoking_habit") {
      List _smokinghabit = ["保密", "从不", "偶尔", "经常"];
      return _smokinghabit[_infoPackage["smoking_habit"]];
    } else if (key == "location") {
      return _infoPackage["province"] == 0
          ? ""
          : "${_infoPackage["province_name"]}" +
              "-" +
              "${_infoPackage["city_name"]}";
    } else {
      return _infoPackage[key];
    }
  }

  //修改内容
  void _infoPageTab(key) {
    if (key == "contact") {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) {
          return ContactListPage(
            account: _account,
            refreshHandle: () {
              this._refreshAccount();
            },
          );
        }),
      );
    } else if (key == "birthday") {
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
    } else if (key == "education") {
      //学历 0：保密 1：小学 2：初中 3：高中 4：专科 5：本科 6：硕士 7：博士
      List _educations = ["保密", "小学", "初中", "高中", "专科", "本科", "硕士", "博士"];
      DataPicker.showDatePicker(
        context,
        datas: _educations,
        selectedIndex: _infoPackage["education"],
        onConfirm: (data) {
          setState(() {
            _infoPackage["education"] = _educations.indexOf(data);
          });
        },
      );
    } else if (key == "height") {
      List<String> _heights = [];
      for (var i = 0; i < 61; i++) {
        _heights.add("${140 + i}");
      }
      DataPicker.showDatePicker(
        context,
        datas: _heights,
        selectedIndex: int.parse("${_infoPackage['height']}") - 140,
        onConfirm: (data) {
          setState(() {
            _infoPackage["height"] = int.parse(data);
          });
        },
      );
    } else if (key == "weight") {
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
    } else if (key == "living_status") {
      //居住状态 0：保密 1：一个人 2：和家人 3：和某人 4：和朋友
      List _livingstatus = ["保密", "一个人", "和家人", "和某人", "和朋友"];
      DataPicker.showDatePicker(
        context,
        datas: _livingstatus,
        selectedIndex: _infoPackage["living_status"],
        onConfirm: (data) {
          setState(() {
            _infoPackage["living_status"] = _livingstatus.indexOf(data);
          });
        },
      );
    } else if (key == "child_nums") {
      List<String> _childs = [];
      for (var i = 0; i < 10; i++) {
        _childs.add("$i");
      }

      DataPicker.showDatePicker(
        context,
        datas: _childs,
        selectedIndex: _infoPackage["child_nums"],
        onConfirm: (data) {
          setState(() {
            _infoPackage["child_nums"] = _childs.indexOf(data);
          });
        },
      );
    } else if (key == "smoking_habit") {
      //抽烟习惯 0：保密 1：从不 2：偶尔 3：经常
      List _smokinghabit = ["保密", "从不", "偶尔", "经常"];
      DataPicker.showDatePicker(
        context,
        datas: _smokinghabit,
        selectedIndex: _infoPackage["smoking_habit"],
        onConfirm: (data) {
          setState(() {
            _infoPackage["smoking_habit"] = _smokinghabit.indexOf(data);
          });
        },
      );
    } else if (key == "drinking_habit") {
      //喝酒习惯 0：保密 1：从不 2：偶尔 3：经常
      List _drinkinghabit = ["保密", "从不", "偶尔", "经常"];
      DataPicker.showDatePicker(
        context,
        datas: _drinkinghabit,
        selectedIndex: _infoPackage["drinking_habit"],
        onConfirm: (data) {
          setState(() {
            _infoPackage["drinking_habit"] = _drinkinghabit.indexOf(data);
          });
        },
      );
    } else if (key == "location") {
      CityPickers.showCityPicker(
        showType: ShowType.pc,
        context: context,
        locationCode:
            _infoPackage["city"] != 0 ? "${_infoPackage["city"]}" : "110000",
      ).then((result) {
        if (result != null) {
          setState(() {
            _infoPackage["province"] = int.parse(result.provinceId);
            _infoPackage["city"] = int.parse(result.cityId);
            _infoPackage["province_name"] = result.provinceName;
            _infoPackage["city_name"] = result.cityName;
          });
        }
      });
    }
  }

  //提交保存
  void _saveInfoAction() {
    FocusScope.of(context).requestFocus(FocusNode());
    XsProgressHud.show(context);

    //上传用户信息
    void _baseInfoUpload() {
      AccountApi.editProfile(_infoPackage, (data, msg) {
        XsProgressHud.hide();
        if (data != null) {
          Navigator.of(context).pop();
        } else {
          showToast("$msg", context);
        }
      });
    }

    //处理封面图片列表上传
    List _tempCoverList = List.from(_coverList);
    var index = 0;
    void _uploadCovers() {
      if (index == _tempCoverList.length) {
        kLog("$_tempCoverList");
        _infoPackage["photo"] =
            JsonDecoder().convert(JsonEncoder().convert(_tempCoverList));
        _baseInfoUpload();
      } else {
        if (_tempCoverList[index] is List<int>) {
          List<int> _imageData = _tempCoverList[index];
          Networking.uploadFiles("/api/v1/upload", [_imageData], (data, msg) {
            if (data != null) {
              List urls = data;
              if (urls.length > 0) {
                _tempCoverList[index] = "${urls.first}";
                index += 1;

                _uploadCovers();
              } else {
                showToast("部分图片上传失败！请稍后重试。", context);
              }
            } else {
              showToast("部分图片上传失败！请稍后重试。", context);
            }
          });
        } else {
          index += 1;
          _uploadCovers();
        }
      }
    }

    if (_tempCoverList.length > 0) {
      _uploadCovers();
    } else {
      if (_account["photo"].length > 0) {
        _infoPackage["photo"] =
            JsonDecoder().convert(JsonEncoder().convert(_tempCoverList));
      }
      _baseInfoUpload();
    }
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 300), () {
      this._refreshAccount();
    });
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
                  _gridView == null ? Container() : _gridView,
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
              children: _baseInfoList.map((dict) {
                int index = _baseInfoList.indexOf(dict);
                String key = Map.from(dict).keys.first;
                String value = dict[key];

                return InfoBaseCell(
                  name: value,
                  value: this._valueOfName(key),
                  valueWidget: index == 0
                      ? TextField(
                          textAlign: TextAlign.right,
                          controller: _nameEditingController,
                          style: TextStyle(
                            fontSize: 15,
                            color: rgba(166, 166, 166, 1),
                          ),
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
                      : index == 6
                          ? TextField(
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 15,
                                color: rgba(166, 166, 166, 1),
                              ),
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
                  hideLine: (index == _baseInfoList.length - 1) ? true : false,
                  tapHandle: index == 0 || index == 6
                      ? null
                      : () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          this._infoPageTab(key);
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
              children: _moreInfoList.map((dict) {
                int index = _moreInfoList.indexOf(dict);
                String key = Map.from(dict).keys.first;
                String value = dict[key];

                return InfoBaseCell(
                  name: value,
                  value: this._valueOfName(key),
                  hideLine: (index == _moreInfoList.length - 1) ? true : false,
                  tapHandle: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    this._infoPageTab(key);
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
