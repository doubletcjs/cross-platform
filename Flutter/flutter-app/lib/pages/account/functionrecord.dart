import 'package:flutter/material.dart';
import '../../public/public.dart';
import '../account/views/accountfunctioncell.dart';
import '../message/views/messagecell.dart';
import '../function/generalalert.dart';

class FunctionRecord extends StatefulWidget {
  int recordType = 0; //记录类型 0 喜欢我 1 看过我
  FunctionRecord({Key key, this.recordType = 0}) : super(key: key);

  @override
  _FunctionRecordState createState() => _FunctionRecordState();
}

class _FunctionRecordState extends State<FunctionRecord> {
  //类型数目组件
  Widget _typeWidget() {
    if (this.widget.recordType == 0) {
      //谁看过我
      return MessageCell(
        padding: EdgeInsets.fromLTRB(13.5, 12.5, 14.5, 12.5),
        redCount: 8,
        title: "谁看过我",
        content: "看看有多少人想看你哟~",
        subContent: "07:00",
        icon: "images/kan@3x.png",
      );
    } else {
      //谁喜欢我
      return MessageCell(
        padding: EdgeInsets.fromLTRB(13.5, 12.5, 14.5, 12.5),
        redCount: 4,
        title: "谁喜欢我",
        content: "喜欢你的人有谁呢？",
        subContent: "07:00",
        icon: "images/like@3x.png",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rgba(248, 248, 248, 1),
      appBar: customAppBar(
        titleView: Container(
          height: AppBar().preferredSize.height,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "谁" +
                    (this.widget.recordType == 0 ? "喜欢我" : "看过我") +
                    " " +
                    "999",
                style: TextStyle(
                  fontSize: 18,
                  color: rgba(0, 0, 0, 1),
                  fontWeight: FontWeight.bold,
                ),
              ),
              //未读数目
              Container(
                padding: EdgeInsets.fromLTRB(4, 1, 4, 0),
                height: 15,
                child: Text(
                  "8",
                  style: TextStyle(
                    fontSize: 10,
                    color: rgba(255, 255, 255, 1),
                  ),
                ),
                decoration: BoxDecoration(
                  color: rgba(255, 73, 54, 1),
                  borderRadius: BorderRadius.circular(15 / 2),
                ),
              ),
            ],
          ),
        ),
        rightItems: [
          IconButton(
            icon: Image.asset(
              "images/record_clean@3x.png",
              width: 21,
              height: 21,
            ),
            onPressed: () {
              GeneralAlert(
                title: "清除记录",
                content: "列表中访问记录将被清除，确定么？",
                confirm: "清楚",
                confirmHandle: () {},
              ).show(context);
            },
          ),
        ],
        elevation: 0.5,
      ),
      body: Column(
        children: <Widget>[
          //类型数目
          _typeWidget(),
          //分割线
          Container(
            height: 1,
            padding: EdgeInsets.fromLTRB(13.5, 0, 0, 0),
            color: Colors.white,
            child: Divider(
              height: 1,
              color: rgba(231, 231, 231, 1),
            ),
          ),
          //列表内容
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return AccountFunctionCell(
                  custom: "多久前" +
                      (this.widget.recordType == 0 ? "点中喜欢了我" : "看过我的资料"),
                );
              },
              itemCount: 10,
            ),
          ),
        ],
      ),
    );
  }
}
