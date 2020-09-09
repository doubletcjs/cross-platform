import 'package:corner_app/pages/store/detail/store_join_apply.dart';
import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StoreHeader extends StatefulWidget {
  GlobalKey globalKey;
  bool isTourist = false;
  StoreHeader({
    Key key,
    this.isTourist = false,
    @required this.globalKey,
  }) : super(key: key);

  @override
  _StoreHeaderState createState() => _StoreHeaderState();
}

class _StoreHeaderState extends State<StoreHeader> {
  bool _showSetting = false;

  // 加入角落
  void _joinCorner() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return StoreJoinApply();
      }),
    );
  }

  // 设置背景
  void _setBackgroud() {}

  @override
  Widget build(BuildContext context) {
    return Stack(
      key: this.widget.globalKey,
      children: [
        Image.asset(
          "images/homepages_default_bg.png",
          height: 217 + MediaQuery.of(context).padding.top,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        GestureDetector(
          onTap: () {
            if (this.widget.isTourist == false) {
              // 博主，可编辑编辑
              setState(() {
                _showSetting = false;
              });
            }
          },
          onLongPress: () {
            if (this.widget.isTourist == false) {
              // 博主，可编辑编辑
              setState(() {
                _showSetting = true;
              });
            }
          },
          child: Container(
            color: rgba(0, 0, 0, 0.4),
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 80,
                ),
                // 店铺信息
                Container(
                  padding: EdgeInsets.only(
                    left: 14.5,
                    right: 14.5,
                  ),
                  child: this.widget.isTourist == true
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  // 封面
                                  networkImage(
                                    "https://avatars1.githubusercontent.com/u/17046133?v=4",
                                    Size(50.5, 50.5),
                                    BorderRadius.circular(50.5 / 2),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "每日一食记",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: rgba(255, 255, 255, 1),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "ID:1234658",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: rgba(255, 255, 255, 0.5),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                left: 8,
                                                right: 8,
                                                bottom: 1,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20 / 2),
                                                border: Border.all(
                                                  width: 0.5,
                                                  color:
                                                      rgba(255, 255, 255, 0.5),
                                                ),
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                "生活",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color:
                                                      rgba(255, 255, 255, 0.5),
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
                            ),
                            SizedBox(
                              width: 8,
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
                                  this._joinCorner();
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  "加入角落",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: rgba(241, 241, 241, 1),
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    // 封面
                                    networkImage(
                                      "https://avatars1.githubusercontent.com/u/17046133?v=4",
                                      Size(50.5, 50.5),
                                      BorderRadius.circular(50.5 / 2),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    // 名称
                                    Expanded(
                                      child: Text(
                                        "每日一食记",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: rgba(255, 255, 255, 1),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 13.5,
                                ),
                                Text(
                                  "23361人已加入·138篇内容",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: rgba(255, 255, 255, 0.5),
                                  ),
                                ),
                              ],
                            ),
                            _showSetting == true
                                ? Positioned(
                                    right: 39.5,
                                    bottom: 13,
                                    child: Container(
                                      width: 109,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: rgba(255, 255, 255, 1),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: FlatButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          this._setBackgroud();
                                        },
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          "设置背景",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: rgba(50, 50, 50, 1),
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                ),
                SizedBox(
                  height: this.widget.isTourist == true ? 51.5 : 19.5,
                ),
                Image.asset(
                  "images/introduction_header@3x.png",
                  fit: BoxFit.fitWidth,
                  width: MediaQuery.of(context).size.width,
                  height: 48,
                ),
                // 简介
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: 28,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "简介",
                        style: TextStyle(
                          fontSize: 14,
                          color: rgba(50, 50, 50, 1),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Text(
                          "相濡以滋味，相忘于江湖，每一个制造和享用美食的人无不经历江湖夜雨，期待桃李春风。",
                          style: TextStyle(
                            fontSize: 14,
                            color: rgba(153, 153, 153, 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                this.widget.isTourist == true
                    ? Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: rgba(255, 255, 255, 1),
                              border: Border(
                                top: BorderSide(
                                  width: 12,
                                  color: rgba(247, 246, 245, 1),
                                ),
                                bottom: BorderSide(
                                  width: 12,
                                  color: rgba(247, 246, 245, 1),
                                ),
                              ),
                            ),
                            padding: EdgeInsets.only(
                              top: 16,
                              bottom: 12,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                "动态",
                                "成员",
                                "讨论",
                              ].map((tab) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "0",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: rgba(50, 50, 50, 1),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 7.5,
                                    ),
                                    Text(
                                      "$tab",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: rgba(153, 153, 153, 1),
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: rgba(255, 255, 255, 1),
                              border: Border(
                                bottom: BorderSide(
                                  width: 12,
                                  color: rgba(247, 246, 245, 1),
                                ),
                              ),
                            ),
                            padding: EdgeInsets.fromLTRB(16, 20, 16, 20),
                            child: Row(
                              children: [
                                networkImage(
                                  "",
                                  Size(40, 40),
                                  BorderRadius.circular(40 / 2),
                                ),
                                SizedBox(
                                  width: 18.5,
                                ),
                                Expanded(
                                  child: Text(
                                    "落主：红鱼",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: rgba(50, 50, 50, 1),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
