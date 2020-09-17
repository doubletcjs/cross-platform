import 'package:corner_app/pages/module/space/module/detail/space_join_complete.dart';
import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

class SpaceJoinApply extends StatefulWidget {
  SpaceJoinApply({Key key}) : super(key: key);

  @override
  _SpaceJoinApplyState createState() => _SpaceJoinApplyState();
}

class _SpaceJoinApplyState extends State<SpaceJoinApply> {
  // 申请成功
  void _applyComplete() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return SpaceJoinComplete();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rgba(255, 255, 255, 1),
      appBar: customAppBar(
        title: "申请加入",
        defaultBack: true,
        rightItems: [
          Center(
            child: Container(
              width: 68,
              height: 28,
              decoration: BoxDecoration(
                color: rgba(235, 102, 91, 1),
                borderRadius: BorderRadius.circular(4),
              ),
              margin: EdgeInsets.only(
                right: 16,
              ),
              child: FlatButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  this._applyComplete();
                },
                child: Text(
                  "发送",
                  style: TextStyle(
                    fontSize: 14,
                    color: rgba(241, 241, 241, 1),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: ListView(
          padding: EdgeInsets.only(left: 14.5, right: 14.5, top: 28),
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "每日一食记",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 20,
                          color: rgba(50, 50, 50, 1),
                          fontWeight: FontWeight.bold,
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
                              color: rgba(153, 153, 153, 1),
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
                              borderRadius: BorderRadius.circular(20 / 2),
                              border: Border.all(
                                width: 0.5,
                                color: rgba(235, 102, 91, 1),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "生活",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                color: rgba(235, 102, 91, 1),
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
            SizedBox(
              height: 28,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              decoration: BoxDecoration(
                color: rgba(247, 246, 245, 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                maxLines: 5,
                style: TextStyle(
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: "请输入验证消息···",
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: rgba(153, 153, 153, 1),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
