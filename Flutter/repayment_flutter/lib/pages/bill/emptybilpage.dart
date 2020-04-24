import 'package:flutter/material.dart';

class EmptyBillPage extends StatelessWidget {
  const EmptyBillPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 180,
          ),
          Text(
            "您还没待还账单哦",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Image.asset(
            "images/icon_no_bill.png",
            width: 120,
            fit: BoxFit.fitWidth,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "不逾期，快来记一笔吧",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
