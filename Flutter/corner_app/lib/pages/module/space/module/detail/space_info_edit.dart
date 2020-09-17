import 'package:corner_app/pages/module/space/module/detail/space_info_input.dart';
import 'package:corner_app/pages/module/space/module/detail/views/space_detail_cell.dart';
import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

class SpaceInfoEdit extends StatefulWidget {
  SpaceInfoEdit({Key key}) : super(key: key);

  @override
  _SpaceInfoEditState createState() => _SpaceInfoEditState();
}

class _SpaceInfoEditState extends State<SpaceInfoEdit> {
  List<String> _classifyList = [
    "科技",
    "教育",
    "医疗",
    "娱乐",
    "经济",
    "生活",
    "设计",
    "摄影",
  ];
  int _classifyIndex = -1;

  // 角落名称
  void _inputName() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return SpaceInfoInput(
          inputHandle: () {
            showToast("修改成功", context);
          },
        );
      }),
    );
  }

  // 角落简介
  void _inputIntroduction() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return SpaceInfoInput(
          inputType: 1,
          inputHandle: () {
            showToast("修改成功", context);
          },
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rgba(255, 255, 255, 1),
      appBar: customAppBar(
        title: "资料编辑",
        defaultBack: true,
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(16, 17.5, 16, 30.5),
            color: rgba(255, 255, 255, 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "角落头像",
                  style: TextStyle(
                    fontSize: 16,
                    color: rgba(50, 50, 50, 1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 4),
                          blurRadius: 6,
                        ),
                      ]),
                      child: networkImage(
                        "http://api.cocoachina.com/uploads/200901/afd304fd3b14961c405d22e5fe285d9b.png",
                        Size(109, 109),
                        BorderRadius.circular(4),
                      ),
                    ),
                    Positioned(
                      top: 6.5,
                      right: 2,
                      width: 52,
                      height: 52,
                      child: FlatButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        child: Image.asset(
                          "images/creation_image_addition@3x.png",
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(52 / 2),
                        ),
                      ),
                    ),
                  ],
                )
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
            child: Column(
              children: [
                SpaceDetailCell(
                  text: "角落名称",
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
                    this._inputName();
                  },
                ),
                SpaceDetailCell(
                  text: "角落简介",
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: 240,
                    ),
                    child: Text(
                      "相濡以滋味，相忘于江湖...",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        color: rgba(153, 153, 153, 1),
                      ),
                    ),
                  ),
                  onTap: () {
                    this._inputIntroduction();
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
            padding: EdgeInsets.fromLTRB(16, 28, 16, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "选择分类",
                  style: TextStyle(
                    fontSize: 16,
                    color: rgba(50, 50, 50, 1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Wrap(
                  spacing: 23.5,
                  runSpacing: 12,
                  children: _classifyList.map((classify) {
                    var index = _classifyList.indexOf(classify);
                    return Container(
                      width: (MediaQuery.of(context).size.width -
                              16 * 2 -
                              23.5 * 3) /
                          4,
                      height: 28,
                      decoration: BoxDecoration(
                        color: _classifyIndex == index
                            ? rgba(235, 102, 91, 1)
                            : rgba(247, 246, 245, 1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      alignment: Alignment.center,
                      child: FlatButton(
                        onPressed: () {
                          setState(() {
                            _classifyIndex = index;
                          });
                        },
                        child: Text(
                          classify,
                          style: TextStyle(
                            fontSize: 14,
                            color: _classifyIndex == index
                                ? rgba(255, 255, 255, 1)
                                : rgba(50, 50, 50, 1),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    );
                  }).toList(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
