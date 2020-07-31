import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../public/public.dart';
import '../../mine/minehomepage.dart';

class ChartMessageCell extends StatelessWidget {
  int type = 0; // 0 系统消息 1 基本消息 2 本人消息
  ChartMessageCell({
    Key key,
    this.type = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 12.5, 15, 12.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //时间
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 16.5),
            alignment: Alignment.center,
            child: Text(
              "2019-06-24 18:30",
              style: TextStyle(
                fontSize: 11,
                color: rgba(172, 172, 172, 1),
              ),
            ),
          ),
          //内容
          type == 0
              ? Container(
                  alignment: Alignment.center,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10.5, 3.5, 10.5, 3.5),
                    decoration: BoxDecoration(
                      color: rgba(0, 0, 0, 0.2),
                      borderRadius: BorderRadius.circular(22 / 2),
                    ),
                    child: Text(
                      "通过附近的人向你打招呼",
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11,
                        color: rgba(255, 255, 255, 0.9),
                      ),
                    ),
                  ),
                )
              : Container(
                  child: type == 2
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            //消息内容
                            Container(
                              constraints: BoxConstraints(
                                maxWidth: 200,
                                minHeight: 46,
                              ),
                              padding: EdgeInsets.fromLTRB(12, 10, 12, 10),
                              decoration: BoxDecoration(
                                color: rgba(255, 233, 146, 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      "所有的元素都是相同的fill值。",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: rgba(0, 0, 0, 1),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            //消息读取状态
                            Image.asset(
                              "images/chat_message_unread@3x.png",
                              width: 15,
                              height: 15,
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            //非本人头像
                            InkWell(
                              child: ClipRRect(
                                child: CachedNetworkImage(
                                  imageUrl:
                                      "https://upload.jianshu.io/users/upload_avatars/14072228/980d845b-ffda-4a82-8d4e-67ffe82ad13b?imageMogr2/auto-orient/strip|imageView2/1/w/96/h/96",
                                  width: 46,
                                  height: 46,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(46 / 2),
                              ),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) {
                                    return MineHomePage();
                                  }),
                                );
                              },
                              borderRadius: BorderRadius.circular(67 / 2),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            //消息内容
                            Container(
                              constraints: BoxConstraints(
                                maxWidth: 200,
                                minHeight: 46,
                              ),
                              padding: EdgeInsets.fromLTRB(12, 10, 12, 10),
                              decoration: BoxDecoration(
                                color: rgba(255, 255, 255, 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      "所有的元素都是相同的fill值。 如果指定的值是一个可变对象，那么List中所有的元素都是相同的对象，并且是可修改的",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: rgba(51, 51, 51, 1),
                                      ),
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
    );
  }
}
