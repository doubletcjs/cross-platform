import 'package:flutter/material.dart';
import 'package:hksy_flutter/pages/calculate/hkcrule.dart';
import 'package:hksy_flutter/public/public.dart';

class CalculateHistory extends StatefulWidget {
  CalculateHistory({Key key}) : super(key: key);

  @override
  _CalculateHistoryState createState() => _CalculateHistoryState();
}

class _CalculateHistoryState extends State<CalculateHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      appBar: customAppBar(
        title: "历史记录",
        brightness: Brightness.dark,
        backgroundColor: kMainBackgroundColor,
        color: Colors.white,
        rightItems: [
          FlatButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return HkcRulePage();
                }),
              );
            },
            child: Text(
              "HKC规则",
              style: TextStyle(
                fontSize: 15,
                color: rgba(255, 255, 255, 1),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: rgba(28, 35, 63, 1),
            height: 57,
            padding: EdgeInsets.fromLTRB(34.5, 0, 34.5, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: ["日期", "数量", "状态"].map((e) {
                return Text(
                  e,
                  style: TextStyle(
                    fontSize: 15,
                    color: rgba(255, 255, 255, 1),
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.fromLTRB(
                  32.5, 0, 32.5, MediaQuery.of(context).padding.bottom),
              itemBuilder: (context, index) {
                return Container(
                  height: 78,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: ["2020-03-18", "4.88", "已收取"].map((e) {
                      int tempIndex = ["2020-03-18", "4.88", "已收取"].indexOf(e);
                      return Container(
                        width: (MediaQuery.of(context).size.width - 32.5 * 2) /
                            3.0,
                        child: Text(
                          e,
                          textAlign: tempIndex == 0
                              ? TextAlign.left
                              : tempIndex == 1
                                  ? TextAlign.center
                                  : TextAlign.right,
                          style: TextStyle(
                            fontSize: 15,
                            color: rgba(255, 255, 255, 1),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 0.5,
                        color: rgba(145, 152, 173, 0.2),
                      ),
                    ),
                  ),
                );
              },
              itemCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}
