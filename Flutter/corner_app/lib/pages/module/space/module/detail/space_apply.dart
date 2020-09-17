import 'package:corner_app/pages/module/space/module/detail/space_apply_detail.dart';
import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

class SpaceApply extends StatefulWidget {
  SpaceApply({Key key}) : super(key: key);

  @override
  _SpaceApplyState createState() => _SpaceApplyState();
}

class _SpaceApplyState extends State<SpaceApply> {
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

  // 申请详情
  void _applyDetail(account, row) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return SpaceApplyDetail(
          account: account,
        );
      }),
    );
  }

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
              Column(
                children: _accountList.map((account) {
                  var row = _accountList.indexOf(account);
                  return InkWell(
                    onTap: () {
                      this._applyDetail(account, row);
                    },
                    child: Container(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        account["name"],
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: rgba(50, 50, 50, 1),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        account["content"],
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: rgba(153, 153, 153, 1),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          account["status"] == 0
                              ? Row(
                                  children: [
                                    InkWell(
                                      onTap: () {},
                                      child: Text(
                                        "忽略",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: rgba(153, 153, 153, 1),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 21,
                                    ),
                                    Container(
                                      width: 60,
                                      height: 28,
                                      decoration: BoxDecoration(
                                        color: rgba(235, 102, 91, 1),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: FlatButton(
                                        onPressed: () {},
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          "同意",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: rgba(241, 241, 241, 1),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              : Text(
                                  account["status"] == 1 ? "已忽略" : "已同意",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: rgba(153, 153, 153, 1),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          );
        },
        itemCount: _dataList.length,
      ),
    );
  }
}
