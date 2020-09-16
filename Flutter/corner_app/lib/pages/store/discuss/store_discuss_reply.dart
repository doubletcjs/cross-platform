import 'package:corner_app/pages/function/general_dialog.dart';
import 'package:corner_app/pages/store/discuss/store_discuss_input.dart';
import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

class StoreDiscussReply extends StatefulWidget {
  StoreDiscussReply({Key key}) : super(key: key);

  @override
  _StoreDiscussReplyState createState() => _StoreDiscussReplyState();

  show(BuildContext context) {
    GeneralDialog().show(
      context,
      backgroundPadding: EdgeInsets.zero,
      backgroundAlignment: Alignment.bottomCenter,
      containerContent: this,
      barrierDismissible: true,
      backgroundColor: Color.fromRGBO(0, 0, 0, 0.4),
    );
  }
}

class _StoreDiscussReplyState extends State<StoreDiscussReply> {
  // 评论
  void _discussPost() {
    StoreDiscussInput()
        .show(context, backgroundColor: Color.fromRGBO(0, 0, 0, 0.1));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height -
          ((MediaQuery.of(context).size.height * 157.5) /
              667), // 157.5 / 667 = x / MediaQuery.of(context).size.height
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 头
          Container(
            height: 44,
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
            ),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
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
                    "回复",
                    style: TextStyle(
                      fontSize: 16,
                      color: rgba(50, 50, 50, 1),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "(88)",
                    style: TextStyle(
                      fontSize: 16,
                      color: rgba(50, 50, 50, 1),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 评论内容
          Container(
            padding: EdgeInsets.fromLTRB(16, 28, 31, 12),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 0.5,
                  color: rgba(0, 0, 0, 0.1),
                ),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          // 头像
                          networkImage(
                            "",
                            Size(40, 40),
                            BorderRadius.circular(40 / 2),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    // 用户名
                                    Container(
                                      constraints: BoxConstraints(
                                        maxWidth: 200,
                                      ),
                                      child: Text(
                                        "红鱼",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: rgba(50, 50, 50, 1),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 6,
                                    ),
                                    // 博主
                                    Container(
                                      width: 39.5,
                                      height: 16,
                                      decoration: BoxDecoration(
                                        color: rgba(235, 102, 91, 1),
                                        borderRadius:
                                            BorderRadius.circular(16 / 2),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "落主",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: rgba(255, 255, 255, 1),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                // 发布时间
                                Text(
                                  "30分钟前",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: rgba(153, 153, 153, 1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    // 点赞
                    InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Image.asset(
                            "images/discuss_like@3x.png",
                            width: 20,
                            height: 20,
                          ),
                          SizedBox(
                            height: 3.5,
                          ),
                          Text(
                            "赞",
                            style: TextStyle(
                              fontSize: 13,
                              color: rgba(50, 50, 50, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                // 评论
                Container(
                  padding: EdgeInsets.only(
                    left: 48,
                    right: 43.5,
                  ),
                  child: Text(
                    "小时候爱吃饺子，纯粹是爱它的美味，现我们吃的，更多是饺子里的家乡味",
                    style: TextStyle(
                      fontSize: 16,
                      color: rgba(50, 50, 50, 1),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(16, 12, 31, 28),
            child: Text(
              "全部回复",
              style: TextStyle(
                fontSize: 16,
                color: rgba(50, 50, 50, 1),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          // 回复列表
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.fromLTRB(16, 0, 31, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // 头像
                                networkImage(
                                  "",
                                  Size(40, 40),
                                  BorderRadius.circular(40 / 2),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                // 用户名
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "红鱼",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: rgba(153, 153, 153, 1),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      // 评论内容
                                      RichText(
                                        text: TextSpan(
                                          text: "回复@布丁：",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: rgba(153, 153, 153, 1),
                                          ),
                                          children: [
                                            TextSpan(
                                              text: "季鹰归未、东坡夜饮、笠翁醉蟹、雪芹茄鲞",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: rgba(50, 50, 50, 1),
                                              ),
                                            ),
                                            TextSpan(
                                              text: " ",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: rgba(50, 50, 50, 1),
                                              ),
                                            ),
                                            TextSpan(
                                              text: "10分钟前",
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: rgba(153, 153, 153, 1),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      // 点赞
                      Material(
                        color: rgba(255, 255, 255, 1),
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Image.asset(
                                "images/discuss_like@3x.png",
                                width: 20,
                                height: 20,
                              ),
                              SizedBox(
                                height: 3.5,
                              ),
                              Text(
                                "赞",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: rgba(50, 50, 50, 1),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 28,
                );
              },
              itemCount: 30,
            ),
          ),
          Container(
            height: 48 + MediaQuery.of(context).padding.bottom,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 48,
                  width: MediaQuery.of(context).size.width,
                  child: FlatButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      this._discussPost();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Text(
                            "留下你的精彩讨论吧",
                            style: TextStyle(
                              fontSize: 16,
                              color: rgba(153, 153, 153, 1),
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Image.asset(
                          "images/input_bar_icon@3x.png",
                          width: 28,
                          height: 28,
                        ),
                        SizedBox(
                          width: 27.5,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
