import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

class DiscussReplyCell extends StatefulWidget {
  DiscussReplyCell({Key key}) : super(key: key);

  @override
  _DiscussReplyCellState createState() => _DiscussReplyCellState();
}

class _DiscussReplyCellState extends State<DiscussReplyCell> {
  @override
  Widget build(BuildContext context) {
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
                        crossAxisAlignment: CrossAxisAlignment.start,
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
  }
}
