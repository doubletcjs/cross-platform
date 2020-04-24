import 'package:flutter/material.dart';

class BillSummaryCell extends StatelessWidget {
  const BillSummaryCell({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  "images/icon_loan_customise.png",
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
                    "招商银行",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    "04月21日 第4/6期",
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
                "本期已还",
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                "532.22",
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
