import 'package:flutter/material.dart';
import 'package:repayment_flutter/pages/bill/billeditorial.dart';
import 'package:repayment_flutter/pages/bill/billsummary.dart';
import 'package:repayment_flutter/public/public.dart';

class HomeBillHeader extends StatelessWidget {
  const HomeBillHeader({Key key}) : super(key: key);

  void _billSummary(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return BillSummaryPage();
        },
      ),
    );
  }

  void _createBill(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return BillEditorialPage();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.fromLTRB(12, MediaQuery.of(context).padding.top, 12, 0),
      padding: EdgeInsets.fromLTRB(20, 14, 20, 16),
      decoration: BoxDecoration(
        color: kMainColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "总待还金额",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "124.12",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Oswald",
              fontSize: 15,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "最后还款日期",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "2022-04-23",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              buttonWidget(
                Row(
                  children: <Widget>[
                    Text(
                      "添加账单",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Image.asset(
                      "images/icon_tab_add.png",
                      width: 13,
                      fit: BoxFit.fitWidth,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Container(
                      width: 1,
                      height: 15,
                      color: Colors.grey,
                    ),
                  ],
                ),
                context,
                onTap: () {
                  this._createBill(context);
                },
              ),
              SizedBox(
                width: 10,
              ),
              buttonWidget(
                Row(
                  children: <Widget>[
                    Text(
                      "账单汇总",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Image.asset(
                      "images/icon_arrow_right.png",
                      width: 8,
                      fit: BoxFit.fitWidth,
                      color: Colors.white,
                    ),
                  ],
                ),
                context,
                onTap: () {
                  this._billSummary(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
