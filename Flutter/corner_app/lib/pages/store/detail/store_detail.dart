import 'package:corner_app/pages/function/general_complaint.dart';
import 'package:corner_app/pages/function/general_share.dart';
import 'package:corner_app/pages/store/detail/store_apply.dart';
import 'package:corner_app/pages/store/detail/store_member.dart';
import 'package:corner_app/pages/store/detail/store_info_edit.dart';
import 'package:corner_app/pages/store/detail/views/store_detail_blogger.dart';
import 'package:corner_app/pages/store/detail/views/store_detail_cell.dart';
import 'package:corner_app/pages/store/detail/views/store_detail_heaer.dart';
import 'package:corner_app/pages/store/detail/views/store_detail_stack.dart';
import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

class StoreDetailPage extends StatefulWidget {
  StoreDetailPage({Key key}) : super(key: key);

  @override
  _StoreDetailPageState createState() => _StoreDetailPageState();
}

class _StoreDetailPageState extends State<StoreDetailPage> {
  List _dataList = [
    "a",
    "b",
    "c",
    "c1",
    "c2",
    "c4",
    "c12",
    "c11",
    "c33",
    "c4556",
    "c1231",
    "c14556",
    "c31231",
  ];

  // 编辑资料
  void _editInfo() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return StoreInfoEdit();
      }),
    );
  }

  // 成员
  void _members() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return StoreDetailMember();
      }),
    );
  }

  // 申请
  void _applies() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return StoreApply();
      }),
    );
  }

  // 分享
  void _shareAction() {
    GeneralShare(
      shareHandle: (item) {
        kLog("$item");
        if (item == "report") {
          GeneralComplaint().show(context);
        }
      },
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rgba(247, 246, 245, 1),
      appBar: customAppBar(
        title: "角落详情",
        defaultBack: true,
        rightItems: [
          Center(
            child: Container(
              margin: EdgeInsets.only(right: 4),
              child: IconButton(
                icon: Image.asset(
                  "images/detail_share@3x.png",
                  width: 20,
                  height: 20,
                ),
                onPressed: () {
                  this._shareAction();
                },
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          // 头
          StoreDetailHeader(),
          StoreDetailBlogger(),
          Container(
            decoration: BoxDecoration(
              color: rgba(255, 255, 255, 1),
              border: Border(
                top: BorderSide(
                  width: 12,
                  color: rgba(247, 246, 245, 1),
                ),
              ),
            ),
            child: Column(
              children: [
                StordeDetailCell(
                  text: "编辑资料",
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: 240,
                    ),
                    child: Text(
                      "每日一食记",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        color: rgba(153, 153, 153, 1),
                      ),
                    ),
                  ),
                  onTap: () {
                    this._editInfo();
                  },
                ),
                StordeDetailCell(
                  text: "角落成员",
                  child: Row(
                    children: [
                      StoreDetailStack(
                        dataList: _dataList,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "23361人",
                        style: TextStyle(
                          fontSize: 16,
                          color: rgba(153, 153, 153, 1),
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    this._members();
                  },
                ),
                StordeDetailCell(
                  text: "新的申请",
                  child: Container(
                    height: 20,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(
                      left: 6.5,
                      right: 6.5,
                    ),
                    constraints: BoxConstraints(
                      minWidth: 20,
                    ),
                    decoration: BoxDecoration(
                      color: rgba(235, 102, 91, 1),
                      borderRadius: BorderRadius.circular(20 / 2),
                    ),
                    child: Text(
                      "1222",
                      style: TextStyle(
                        fontSize: 12,
                        color: rgba(255, 255, 255, 1),
                      ),
                    ),
                  ),
                  onTap: () {
                    this._applies();
                  },
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: rgba(255, 255, 255, 1),
              border: Border(
                top: BorderSide(
                  width: 12,
                  color: rgba(247, 246, 245, 1),
                ),
              ),
            ),
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: 20,
                    left: 16,
                    bottom: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "动态更新提示",
                        style: TextStyle(
                          fontSize: 16,
                          color: rgba(50, 50, 50, 1),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "关闭后，只有@你的消息才会提示",
                        style: TextStyle(
                          fontSize: 13,
                          color: rgba(153, 153, 153, 1),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 6,
                  child: Switch(
                    value: true,
                    activeColor: rgba(255, 255, 255, 1),
                    activeTrackColor: rgba(1, 152, 117, 1),
                    onChanged: (isOn) {},
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 62.5,
            decoration: BoxDecoration(
              color: rgba(255, 255, 255, 1),
              border: Border(
                top: BorderSide(
                  width: 12,
                  color: rgba(247, 246, 245, 1),
                ),
              ),
            ),
            child: FlatButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
              child: Text(
                "退出角落",
                style: TextStyle(
                  fontSize: 16,
                  color: rgba(235, 102, 91, 1),
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
