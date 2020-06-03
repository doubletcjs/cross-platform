import 'package:flutter/material.dart';
import 'package:hksy_flutter/public/public.dart';

class CoinTransfer extends StatefulWidget {
  CoinTransfer({Key key}) : super(key: key);

  @override
  _CoinTransferState createState() => _CoinTransferState();
}

class _CoinTransferState extends State<CoinTransfer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      appBar: customAppBar(
        title: "金币互转",
        brightness: Brightness.dark,
        backgroundColor: kMainBackgroundColor,
        color: Colors.white,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 24.5,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "金币资产",
                    style: TextStyle(
                      fontSize: 15,
                      color: rgba(145, 152, 173, 1),
                    ),
                  ),
                  Text(
                    "13420个",
                    style: TextStyle(
                      fontSize: 15,
                      color: rgba(145, 152, 173, 1),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 37,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
              padding: EdgeInsets.fromLTRB(20, 20.5, 20, 0),
              decoration: BoxDecoration(
                color: rgba(28, 35, 63, 1),
                borderRadius: BorderRadius.circular(7.5),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "转出数量",
                      style: TextStyle(
                        fontSize: 18,
                        color: rgba(255, 255, 255, 1),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.5,
                  ),
                  Container(
                    height: 60.5,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: rgba(145, 152, 173, 0.2),
                          width: 0.5,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            style: TextStyle(
                              fontSize: 13,
                              color: rgba(255, 255, 255, 1),
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              labelText: "可转出13420个",
                              labelStyle: TextStyle(
                                fontSize: 13,
                                color: rgba(145, 152, 173, 1),
                              ),
                              contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 13),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          "全部转出",
                          style: TextStyle(
                            fontSize: 13,
                            color: rgba(23, 96, 255, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 60.5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "对方账户",
                          style: TextStyle(
                            fontSize: 15,
                            color: rgba(255, 255, 255, 1),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: TextField(
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 13,
                              color: rgba(255, 255, 255, 1),
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              labelText: "请输入对方账户手机号码",
                              labelStyle: TextStyle(
                                fontSize: 13,
                                color: rgba(145, 152, 173, 1),
                              ),
                              contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 13),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
