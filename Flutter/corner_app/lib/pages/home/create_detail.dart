import 'package:corner_app/pages/home/create_complete.dart';
import 'package:corner_app/pages/home/create_rule.dart';
import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

class CreateDetail extends StatefulWidget {
  CreateDetail({Key key}) : super(key: key);

  @override
  _CreateDetailState createState() => _CreateDetailState();
}

class _CreateDetailState extends State<CreateDetail> {
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
  double _classifySpace = 23.5;
  int _classifyIndex = -1;

  // 规则
  void _showRules() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return CreateRule();
      }),
    );
  }

  // 完成
  void _createComplete() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return CreateComplete();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rgba(255, 255, 255, 1),
      appBar: customAppBar(
        leftItems: [
          Container(
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Row(
                children: [
                  Image.asset(
                    "images/base_back@3x.png",
                    width: 11,
                    height: 20,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "返回",
                    style: TextStyle(
                      fontSize: 18,
                      color: rgba(51, 51, 51, 1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        rightItems: [
          Container(
            width: 72,
            height: 28,
            decoration: BoxDecoration(
              color: rgba(235, 102, 91, 1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: FlatButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                this._createComplete();
              },
              child: Text(
                "完成",
                style: TextStyle(
                  fontSize: 14,
                  color: rgba(241, 241, 241, 1),
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 16, right: 16, top: 26),
        children: [
          Row(
            children: [
              // 封面
              Container(
                child: networkImage(
                  "",
                  Size(50.5, 50.5),
                  BorderRadius.circular(4),
                ),
                decoration: BoxDecoration(
                  color: rgba(255, 255, 255, 1),
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 4),
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Text(
                  "每日一食记",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 20,
                    color: rgba(50, 50, 50, 1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 28,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            decoration: BoxDecoration(
              color: rgba(247, 246, 245, 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              maxLines: 5,
              style: TextStyle(
                fontSize: 14,
                color: rgba(50, 50, 50, 1),
              ),
              decoration: InputDecoration(
                hintText: "请输入角落简介",
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: rgba(153, 153, 153, 1),
                ),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
            height: 22,
          ),
          Text(
            "选择分类",
            style: TextStyle(
              fontSize: 20,
              color: rgba(50, 50, 50, 1),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 11.5,
          ),
          Wrap(
            spacing: _classifySpace,
            runSpacing: 12,
            children: _classifyList.map((classify) {
              int index = _classifyList.indexOf(classify);
              return Container(
                width: (MediaQuery.of(context).size.width -
                        _classifySpace * 3 -
                        16 * 2) /
                    4,
                height: 28,
                decoration: BoxDecoration(
                  color: _classifyIndex == index
                      ? rgba(235, 102, 91, 1)
                      : rgba(247, 246, 245, 1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: FlatButton(
                  padding: EdgeInsets.zero,
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
                          ? rgba(247, 246, 245, 1)
                          : rgba(50, 50, 50, 1),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(
            height: 60,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    Image.asset(
                      "images/detail_create_unsel@3x.png",
                      width: 12,
                      height: 12,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "我已经阅读并同意",
                      style: TextStyle(
                        fontSize: 13,
                        color: rgba(50, 50, 50, 1),
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  this._showRules();
                },
                child: Text(
                  "《街角落主规则》",
                  style: TextStyle(
                    fontSize: 13,
                    color: rgba(80, 111, 176, 1),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
