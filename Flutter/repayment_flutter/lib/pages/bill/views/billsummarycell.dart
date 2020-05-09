import 'package:flutter/material.dart';
import 'package:repayment_flutter/public/public.dart';

class BillSummaryCell extends StatelessWidget {
  Map<String, dynamic> bill;
  BillSummaryCell({Key key, this.bill}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 1~500期
    var _limit = int.parse("${bill["repaymentterms"]}") + 1;
    var _term = int.parse("${bill["currentterm"]}") + 1;
    var _date = DateTime.parse("${bill["unfolddate"]}");
    var _amount = double.parse("${bill["eachamount"]}").toStringAsFixed(2);
    var _residueday = "${bill["residueday"]}";

    return Container(
      padding: EdgeInsets.fromLTRB(17, 12, 17, 12),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                child: Image.asset(
                  bill["icon"],
                  width: 22,
                  height: 22,
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(22 / 2),
              ),
              SizedBox(
                width: 6,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    bill["name"],
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    "${_date.month.toString().padLeft(2, '0')}月${_date.day.toString().padLeft(2, '0')}日 第$_term/$_limit" +
                        "期",
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                _residueday.contains("-")
                    ? "逾期${-int.parse(_residueday)}天"
                    : "还剩$_residueday天",
                style: TextStyle(
                  fontSize: 10,
                  color: _residueday.contains("-") ? Colors.red : kMainColor,
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                "$_amount",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontFamily: "Oswald",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
