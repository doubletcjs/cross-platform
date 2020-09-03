import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

class StoreDetailApply extends StatefulWidget {
  StoreDetailApply({Key key}) : super(key: key);

  @override
  _StoreDetailApplyState createState() => _StoreDetailApplyState();
}

class _StoreDetailApplyState extends State<StoreDetailApply> {
  List _dataList = [
    {
      "date": "2020.07.11",
      "accountList": [
        {
          "avatar": "",
          "name": "小红鱼",
          "content": "热爱美食，来学习了~",
          "status": 0, //0 未处理 1 忽略 2 同意
          "area": "广东 广州", //地区
          "block": true, //黑名单
          "id": 1
        },
        {
          "avatar": "",
          "name": "晨曦",
          "content": "鱼儿拉我进去，我是晨曦~",
          "status": 0, //0 未处理 1 忽略 2 同意
          "area": "广东 广州", //地区
          "block": false, //黑名单
          "id": 2
        },
        {
          "avatar": "",
          "name": "布丁",
          "content": "我是你的布姐姐呀， 我来你...",
          "status": 0, //0 未处理 1 忽略 2 同意
          "area": "广东 广州", //地区
          "block": false, //黑名单
          "id": 13
        },
      ]
    },
    {
      "date": "2020.07.10",
      "accountList": [
        {
          "avatar": "",
          "name": "假懒猫",
          "content": "健身游泳，了解一下~",
          "status": 1, //0 未处理 1 忽略 2 同意
          "area": "广东 广州", //地区
          "block": false, //黑名单
          "id": 1123
        },
        {
          "avatar": "",
          "name": "风里",
          "content": "终于等到你角落开启了~陶器...",
          "status": 2, //0 未处理 1 忽略 2 同意
          "area": "广东 广州", //地区
          "block": false, //黑名单
          "id": 123445
        },
        {
          "avatar": "",
          "name": "寻忆味道",
          "content": "姐姐的陶器太好看了~~~~想买~",
          "status": 2, //0 未处理 1 忽略 2 同意
          "area": "广东 广州", //地区
          "block": false, //黑名单
          "id": 12431
        },
        {
          "avatar": "",
          "name": "亦城",
          "content": "美食呀~拉我进去~",
          "status": 2, //0 未处理 1 忽略 2 同意
          "area": "广东 广州", //地区
          "block": false, //黑名单
          "id": 2345
        },
      ]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rgba(255, 255, 255, 1),
      appBar: customAppBar(
        title: "新的申请",
        defaultBack: true,
      ),
      body: ListView.builder(
        itemBuilder: (context, section) {
          var _data = _dataList[section];
          List _accountList = _data["accountList"];
          return Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                color: rgba(247, 246, 245, 1),
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  "${_data['date']}",
                  style: TextStyle(
                    fontSize: 16,
                    color: rgba(112, 112, 112, 1),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                ),
                child: Column(
                  children: _accountList.map((account) {
                    var row = _accountList.indexOf(account);
                    return Container(
                      padding: EdgeInsets.fromLTRB(16, 14, 16, 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                networkImage(
                                  account["avatar"],
                                  Size(40, 40),
                                  BorderRadius.circular(40 / 2),
                                ),
                                SizedBox(
                                  width: 18.5,
                                ),
                                Expanded(
                                  child: Column(
                                    children: [],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        },
        itemCount: _dataList.length,
      ),
    );
  }
}
