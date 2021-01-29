import 'package:diary_mood/public/public.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CommentCard extends StatelessWidget {
  kVoidFunctionBlock replyHandle;
  kVoidFunctionBlock deleteHandle;
  kObjectFunctionBlock accountHandle;
  CommentCard({
    Key key,
    this.replyHandle,
    this.deleteHandle,
    this.accountHandle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: rgba(255, 255, 255, 1),
      padding: EdgeInsets.fromLTRB(20, 14, 20, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 头像
                Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: InkWell(
                    onTap: () {
                      if (accountHandle != null) {
                        accountHandle("用户id");
                      }
                    },
                    child: extendedNetworkImage(
                      "",
                      Size(28, 28),
                      BorderRadius.circular(28 / 2),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 用户名
                      InkWell(
                        onTap: () {
                          if (accountHandle != null) {
                            accountHandle("用户id");
                          }
                        },
                        child: Text(
                          "用户名",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: rgba(18, 18, 18, 1),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      // 评论内容
                      Text(
                        "评论内容",
                        style: TextStyle(
                          fontSize: 13,
                          color: rgba(34, 34, 34, 1),
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      // 时间、删除
                      Row(
                        children: [
                          Text(
                            "1小时前",
                            style: TextStyle(
                              fontSize: 11,
                              color: rgba(170, 170, 170, 1),
                            ),
                          ),
                          // 作者
                          Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Row(
                              children: [
                                Container(
                                  width: 2,
                                  height: 2,
                                  decoration: BoxDecoration(
                                    color: rgba(170, 170, 170, 1),
                                    borderRadius: BorderRadius.circular(2 / 2),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                FlatButton(
                                  padding: EdgeInsets.zero,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  minWidth: 0,
                                  height: 15,
                                  onPressed: () {
                                    if (deleteHandle != null) {
                                      deleteHandle();
                                    }
                                  },
                                  child: Text(
                                    "删除",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: rgba(99, 99, 99, 1),
                                    ),
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
              ],
            ),
          ),
          // 评论 作者不显示
          Padding(
            padding: EdgeInsets.only(left: 8, bottom: 22),
            child: FlatButton(
              padding: EdgeInsets.zero,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              minWidth: 0,
              height: 14,
              onPressed: () {
                if (replyHandle != null) {
                  replyHandle();
                }
              },
              child: Image.asset(
                "images/detail_comment@3x.png",
                width: 16,
                height: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
