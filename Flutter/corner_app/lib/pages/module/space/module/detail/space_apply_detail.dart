import 'package:corner_app/pages/function/general_alert.dart';
import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SpaceApplyDetail extends StatefulWidget {
  Map account;
  SpaceApplyDetail({Key key, this.account}) : super(key: key);

  @override
  _SpaceApplyDetailState createState() => _SpaceApplyDetailState();
}

class _SpaceApplyDetailState extends State<SpaceApplyDetail> {
  // 黑名单
  void _blockListHandle() {
    if (this.widget.account["block"] == false) {
      GeneralAlert(
        content: "加入黑名单，将不再收到对方的申请信息",
        confirm: "取消",
        cancel: "确认",
        confirmColor: rgba(50, 50, 50, 1),
        cancelColor: rgba(235, 102, 91, 1),
        onCancel: () {
          setState(() {
            this.widget.account["block"] = true;
          });
        },
      ).show(context);
    } else {
      setState(() {
        this.widget.account["block"] = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rgba(255, 255, 255, 1),
      appBar: customAppBar(
        defaultBack: true,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(
            16, 28, 16, 28 + MediaQuery.of(context).padding.bottom),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            this.widget.account != null
                ? Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    this.widget.account["name"],
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
                                    "地区：" + this.widget.account["area"],
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
                        SizedBox(
                          height: 18.5,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.fromLTRB(8, 12, 8, 45.5),
                          decoration: BoxDecoration(
                            color: rgba(247, 246, 245, 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            this.widget.account["content"],
                            style: TextStyle(
                              fontSize: 16,
                              color: rgba(153, 153, 153, 1),
                            ),
                          ),
                        ),
                        this.widget.account["block"] == true
                            ? Container(
                                margin: EdgeInsets.only(
                                  top: 28,
                                ),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "images/block_list_alert@3x.png",
                                      width: 16,
                                      height: 16,
                                    ),
                                    SizedBox(
                                      width: 13,
                                    ),
                                    Text(
                                      "已添加至黑名单，你将不再收到对方的申请消息",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: rgba(50, 50, 50, 1),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : this.widget.account["status"] == 0
                                ? Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                          top: 61.5,
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 48,
                                        decoration: BoxDecoration(
                                          color: rgba(235, 102, 91, 1),
                                          borderRadius:
                                              BorderRadius.circular(3.5),
                                        ),
                                        child: FlatButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: () {},
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(3.5),
                                          ),
                                          child: Text(
                                            "同意",
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: rgba(255, 255, 255, 1),
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 32,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        child: InkWell(
                                          onTap: () {},
                                          child: Text(
                                            "忽略",
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: rgba(153, 153, 153, 1),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : this.widget.account["status"] == 2
                                    ? Container(
                                        margin: EdgeInsets.only(
                                          top: 61.5,
                                        ),
                                        alignment: Alignment.center,
                                        height: 48,
                                        decoration: BoxDecoration(
                                          color: rgba(235, 102, 91, 0.61),
                                          borderRadius:
                                              BorderRadius.circular(3.5),
                                        ),
                                        child: Text(
                                          "已同意",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: rgba(255, 255, 255, 1),
                                          ),
                                        ),
                                      )
                                    : this.widget.account["status"] == 1
                                        ? Container(
                                            margin: EdgeInsets.only(
                                              top: 61.5,
                                            ),
                                            alignment: Alignment.center,
                                            height: 48,
                                            child: Text(
                                              "已忽略",
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: rgba(50, 50, 50, 1),
                                              ),
                                            ),
                                          )
                                        : Container(),
                      ],
                    ),
                  )
                : Container(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    this._blockListHandle();
                  },
                  child: Text(
                    this.widget.account["block"] == true ? "移出黑名单" : "加入黑名单",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: rgba(80, 111, 176, 1),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
