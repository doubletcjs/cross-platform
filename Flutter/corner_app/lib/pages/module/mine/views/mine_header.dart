import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MineHeader extends StatefulWidget {
  GlobalKey globalKey;
  bool isMinePage = false;
  MineHeader({
    Key key,
    this.isMinePage = false,
    @required this.globalKey,
  }) : super(key: key);

  @override
  _MineHeaderState createState() => _MineHeaderState();
}

class _MineHeaderState extends State<MineHeader> {
  List<String> _itemList = [
    "加入的角落",
    "获取的赞",
    "被收藏次数",
  ];

  List<String> _list = [
    "获取的赞",
    "被收藏次数",
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      key: this.widget.globalKey,
      children: [
        // 背景
        GestureDetector(
          onTap: () {},
          child: networkImage(
            "http://zstatic.zuimeia.com/100_640_360_mobile.jpg",
            Size(MediaQuery.of(context).size.width,
                240 + MediaQuery.of(context).padding.top),
            BorderRadius.circular(24 / 2),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 96,
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 8,
                color: rgba(247, 246, 245, 1),
              ),
            ),
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            decoration: BoxDecoration(
              color: rgba(255, 255, 255, 1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // 设置
                    this.widget.isMinePage == true
                        ? InkWell(
                            onTap: () {
                              kLog("any");
                            },
                            borderRadius: BorderRadius.circular(4),
                            child: Image.asset(
                              "images/icon_me_setting@3x.png",
                              height: 28,
                              width: 28,
                            ),
                          )
                        : Container(),
                    SizedBox(
                      width: 8,
                    ),
                    // 编辑资料
                    Container(
                      height: 28,
                      width: 88,
                      decoration: BoxDecoration(
                        color: rgba(247, 246, 245, 1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: FlatButton(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        onPressed: () {},
                        child: Text(
                          this.widget.isMinePage == true ? "编辑资料" : "ta的角落",
                          style: TextStyle(
                            fontSize: 14,
                            color: rgba(235, 102, 91, 1),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 32,
                ),
                // 用户名
                Text(
                  "是凉白开鸭",
                  style: TextStyle(
                    fontSize: 20,
                    color: rgba(27, 27, 27, 1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                // 街角号
                Text(
                  "街角号：123456",
                  style: TextStyle(
                    fontSize: 12,
                    color: rgba(153, 153, 153, 1),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                // 介绍
                Text(
                  "这个人很懒什么都没介绍",
                  style: TextStyle(
                    fontSize: 14,
                    color: rgba(50, 50, 50, 1),
                  ),
                ),
                SizedBox(
                  height: 22,
                ),
                Row(
                  children: (this.widget.isMinePage == true ? _itemList : _list)
                      .map((item) {
                    var index =
                        (this.widget.isMinePage == true ? _itemList : _list)
                            .indexOf(item);
                    return Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                            right: index <
                                    (this.widget.isMinePage == true
                                                ? _itemList
                                                : _list)
                                            .length -
                                        1
                                ? 8
                                : 0),
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "0",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: rgba(50, 50, 50, 1),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                item,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: rgba(153, 153, 153, 1),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
        // 头像
        Positioned(
          top: (MediaQuery.of(context).padding.top + 96) - 15,
          left: 18,
          child: Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: rgba(255, 255, 255, 1),
              borderRadius: BorderRadius.circular(72 / 2),
            ),
            child: Center(
              child: networkImage(
                "",
                Size(66, 66),
                BorderRadius.circular(66 / 2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
