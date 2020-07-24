import 'package:flutter/material.dart';
import '../../public/public.dart';

class RechargeRecord extends StatefulWidget {
  RechargeRecord({Key key}) : super(key: key);

  @override
  _RechargeRecordState createState() => _RechargeRecordState();
}

class _RechargeRecordState extends State<RechargeRecord> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rgba(248, 248, 248, 1),
      appBar: customAppBar(
        title: "充值记录",
        elevation: 0.5,
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(15, 16, 15, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //金币图标
                      Image.asset(
                        "images/wallet_jinbi@3x.png",
                        width: 29,
                        height: 29,
                      ),
                      SizedBox(
                        width: 11,
                      ),
                      //充值日期
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          //金币充值
                          Text(
                            "金币充值",
                            style: TextStyle(
                              color: rgba(51, 51, 51, 1),
                              fontSize: 13,
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          //充值日期
                          Text(
                            "07-30 13:02",
                            style: TextStyle(
                              color: rgba(153, 153, 153, 1),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                //充值金额
                Text(
                  "500.00",
                  style: TextStyle(
                    color: rgba(255, 45, 85, 1),
                    fontSize: 19.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          //分割线
          return Container(
            height: 0.5,
            padding: EdgeInsets.fromLTRB(55.5, 0, 0, 0),
            color: Colors.white,
            child: Container(
              color: rgba(240, 240, 240, 1),
            ),
          );
        },
        itemCount: 4,
      ),
    );
  }
}
