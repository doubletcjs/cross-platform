import 'package:flutter/material.dart';
import 'package:repayment_flutter/pages/bill/views/billchartheader.dart';
import 'package:repayment_flutter/pages/bill/views/billsummarycell.dart';
import 'package:repayment_flutter/public/public.dart';

class BillSummaryPage extends StatefulWidget {
  BillSummaryPage({Key key}) : super(key: key);

  @override
  _BillSummaryPageState createState() => _BillSummaryPageState();
}

class _BillSummaryPageState extends State<BillSummaryPage> {
  bool _unfold = true;
  void _unfoldStatus() {
    setState(() {
      _unfold = !_unfold;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "帐单汇总",
        backgroundColor: kMainColor,
        color: Colors.white,
        brightness: Brightness.dark,
      ),
      body: Column(
        children: <Widget>[
          BillChartHeader(),
          Container(
            padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  "账 单",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "共有4个账单",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      buttonWidget(
                        Row(
                          children: <Widget>[
                            Text(
                              "1874.94",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Image.asset(
                              _unfold == true
                                  ? "images/icon_list_up.png"
                                  : "images/icon_list_down.png",
                              width: 13,
                              height: 11,
                            ),
                          ],
                        ),
                        context,
                        onTap: () {
                          this._unfoldStatus();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _unfold == true
              ? Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return BillSummaryCell();
                    },
                    separatorBuilder: (context, index) {
                      return Container(
                        height: 10,
                      );
                    },
                    itemCount: 10,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
