import 'package:corner_app/pages/function/general_alert.dart';
import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

class StoreDetailMember extends StatefulWidget {
  StoreDetailMember({Key key}) : super(key: key);

  @override
  _StoreDetailMemberState createState() => _StoreDetailMemberState();
}

class _StoreDetailMemberState extends State<StoreDetailMember> {
  List _dataList = [
    {
      "cover": "",
      "name": "红鱼",
      "member": 2, // 0 普通用户 1 管理员 2 博主
    },
    {
      "cover": "",
      "name": "晨曦",
      "member": 1,
    },
    {
      "cover": "",
      "name": "布丁",
      "member": 1,
    },
    {
      "cover": "",
      "name": "懒猫",
      "member": 0,
    },
    {
      "cover": "",
      "name": "风里",
      "member": 0,
    },
    {
      "cover": "",
      "name": "寻忆味道",
      "member": 0,
    },
  ];
  List _sectionDataList = [];
  bool _edittingList = false;
  int _selectCount = 0;

  // 处理数据
  void _handleSectionData() {
    List _adminList = [];
    List _list = [];

    for (var data in _dataList) {
      data["select"] = false;
      if (data["member"] > 0) {
        _adminList.add(data);
      } else {
        _list.add(data);
      }
    }

    setState(() {
      _sectionDataList.add({
        "section": "落主、管理员",
        "list": _adminList,
      });
      _sectionDataList.add({
        "section": "成员",
        "list": _list,
      });
    });
  }

  // 弹出菜单
  List<PopupMenuItem> _menuItems(String sectionName, int section, int row) {
    List _list = [
      "取消管理员",
      "转让落主",
      "批量管理",
      "删除该成员",
    ];

    if (sectionName == "成员") {
      _list = [
        "设置管理员",
        "批量管理",
        "删除该成员",
      ];
    }

    return _list.map((e) {
      return PopupMenuItem(
        enabled: false,
        child: InkWell(
          child: Container(
            height: 48,
            alignment: Alignment.center,
            child: Text(
              e,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: rgba(50, 50, 50, 1),
                fontSize: 16,
              ),
            ),
          ),
          onTap: () {
            Navigator.of(context).pop();
            var name = _sectionDataList[section]["list"][row]["name"];

            Future.delayed(Duration(milliseconds: 400), () {
              if (e == "批量管理") {
                setState(() {
                  _edittingList = true;
                });
              } else if (e == "设置管理员") {
                GeneralAlert(
                  content: "是否设置成员【$name】为管理员",
                  confirm: "设置管理员",
                  confirmColor: rgba(235, 102, 91, 1),
                ).show(context);
              } else if (e == "转让落主") {
                GeneralAlert(
                  content: "是否设置【$name】为落主，转让后则你成为普通成员",
                  confirm: "转让落主",
                  confirmColor: rgba(235, 102, 91, 1),
                ).show(context);
              } else if (e == "删除该成员") {
                GeneralAlert(
                  content: "是否删除成员【$name】",
                  confirm: "删除",
                  confirmColor: rgba(235, 102, 91, 1),
                ).show(context);
              }
            });
          },
        ),
      );
    }).toList();
  }

  // 会员选择
  void _selectCountCheck() {
    int _count = 0;
    for (var section in _sectionDataList) {
      for (var row in section["list"]) {
        if (row["select"] == true) {
          _count += 1;
        }
      }
    }

    setState(() {
      _selectCount = _count;
    });
  }

  void _memberSelection(int section, int row) {
    setState(() {
      _sectionDataList[section]["list"][row]["select"] = true;
    });

    this._selectCountCheck();
  }

  // 取消选择
  void _cancelSection() {
    for (var i = 0; i < _sectionDataList.length; i++) {
      List list = _sectionDataList[i]["list"];
      for (var j = 0; j < list.length; j++) {
        list[j]["select"] = false;
      }
      _sectionDataList[i]["list"] = list;
    }

    setState(() {
      _selectCount = 0;
    });
  }

  // 批量删除
  void _batchDelete() {
    if (_selectCount > 0) {
      var section = 0;
      var row = 0;
      for (var i = 0; i < _sectionDataList.length; i++) {
        List list = _sectionDataList[i]["list"];
        for (var j = 0; j < list.length; j++) {
          if (list[j]["select"] == true) {
            section = i;
            row = j;
            break;
          }
        }
      }

      var name = _sectionDataList[section]["list"][row]["name"];
      GeneralAlert(
        content: _selectCount == 1
            ? "是否删除成员【$name】"
            : "是否删除成员【$name】等，共$_selectCount人",
        confirm: "删除",
        confirmColor: rgba(235, 102, 91, 1),
      ).show(context);
    }
  }

  @override
  void initState() {
    super.initState();

    this._handleSectionData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rgba(255, 255, 255, 1),
      appBar: customAppBar(
        title: "角落成员",
        defaultBack: true,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 20,
              bottom: 8,
            ),
            color: rgba(255, 255, 255, 1),
            child: Container(
              height: 32,
              padding: EdgeInsets.only(
                left: 12,
                right: 12,
              ),
              decoration: BoxDecoration(
                color: rgba(247, 246, 245, 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Image.asset(
                    "images/detail_member@3x.png",
                    width: 16,
                    height: 16,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: TextField(
                      scrollPadding: EdgeInsets.zero,
                      style: TextStyle(
                        fontSize: 14,
                        color: rgba(50, 50, 50, 1),
                      ),
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                          top: -18,
                        ),
                        hintText: "搜索成员",
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: rgba(153, 153, 153, 1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(
                bottom: _edittingList == true
                    ? 0
                    : MediaQuery.of(context).padding.bottom,
              ),
              itemBuilder: (context, section) {
                List _list = _sectionDataList[section]["list"];
                return Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(16, 20, 16, 6),
                      decoration: BoxDecoration(
                        color: rgba(255, 255, 255, 1),
                        border: section > 0
                            ? Border(
                                top: BorderSide(
                                  width: 12,
                                  color: rgba(247, 246, 245, 1),
                                ),
                              )
                            : Border(),
                      ),
                      child: Text(
                        _sectionDataList[section]["section"],
                        style: TextStyle(
                          fontSize: 16,
                          color: rgba(153, 153, 153, 1),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Column(
                      children: _list.map((data) {
                        var row = _list.indexOf(data);
                        return Material(
                          color: rgba(255, 255, 255, 1),
                          child: InkWell(
                            onTap: data["member"] == 2 ? null : () {},
                            onTapDown: (details) {
                              if (_edittingList == false &&
                                  data["member"] != 2) {
                                showMenu(
                                  context: context,
                                  position: RelativeRect.fromLTRB(
                                    details.globalPosition.dx,
                                    details.globalPosition.dy,
                                    MediaQuery.of(context).size.width -
                                        details.globalPosition.dx,
                                    MediaQuery.of(context).size.height -
                                        details.globalPosition.dy,
                                  ),
                                  items: this._menuItems(
                                    _sectionDataList[section]["section"],
                                    section,
                                    row,
                                  ),
                                );
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 16, right: 16, top: 14, bottom: 14),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        networkImage(
                                          data["cover"],
                                          Size(40, 40),
                                          BorderRadius.circular(40 / 2),
                                        ),
                                        SizedBox(
                                          width: 18.5,
                                        ),
                                        Expanded(
                                          child: Text(
                                            data["name"],
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: rgba(50, 50, 50, 1),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  data["member"] > 0
                                      ? Row(
                                          children: [
                                            Container(
                                              width: 50.5,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                color: data["member"] == 2
                                                    ? rgba(235, 102, 91, 1)
                                                    : rgba(255, 255, 255, 1),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20 / 2),
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                data["member"] == 2
                                                    ? "落主"
                                                    : "管理员",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: data["member"] == 2
                                                      ? rgba(255, 255, 255, 1)
                                                      : rgba(153, 153, 153, 1),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: (_edittingList == true &&
                                                      data["member"] != 2)
                                                  ? 38.5
                                                  : 0,
                                            ),
                                            (_edittingList == true &&
                                                    data["member"] != 2)
                                                ? Material(
                                                    child: InkWell(
                                                      onTap: () {
                                                        this._memberSelection(
                                                          section,
                                                          row,
                                                        );
                                                      },
                                                      child: Image.asset(
                                                        data["select"] == true
                                                            ? "images/detail_member_chose_sel@3x.png"
                                                            : "images/detail_member_chose@3x.png",
                                                        width: 20,
                                                        height: 20,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20 / 2),
                                                    ),
                                                  )
                                                : Container()
                                          ],
                                        )
                                      : Container(
                                          child: _edittingList == true
                                              ? Material(
                                                  child: InkWell(
                                                    onTap: () {
                                                      this._memberSelection(
                                                        section,
                                                        row,
                                                      );
                                                    },
                                                    child: Image.asset(
                                                      data["select"] == true
                                                          ? "images/detail_member_chose_sel@3x.png"
                                                          : "images/detail_member_chose@3x.png",
                                                      width: 20,
                                                      height: 20,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20 / 2),
                                                  ),
                                                )
                                              : Container(),
                                        ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                );
              },
              itemCount: _sectionDataList.length,
            ),
          ),
          _edittingList == true
              ? Container(
                  height: 48 + MediaQuery.of(context).padding.bottom,
                  color: rgba(255, 255, 255, 1),
                  child: Stack(
                    children: [
                      Container(
                        height: 48,
                        padding: EdgeInsets.only(
                          left: 16,
                          right: 16,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "已选",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: rgba(112, 112, 112, 1),
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "$_selectCount",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: rgba(27, 27, 27, 1),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Material(
                                  color: rgba(255, 255, 255, 1),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        _edittingList = false;
                                      });
                                      this._cancelSection();
                                    },
                                    child: Text(
                                      "取消",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: rgba(50, 50, 50, 1),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 26.5,
                                ),
                                Container(
                                  width: 109,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    color: rgba(235, 102, 91, 1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: FlatButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      this._batchDelete();
                                    },
                                    child: Text(
                                      "删除成员",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: rgba(241, 241, 241, 1),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
