import 'package:flutter/material.dart';

class BillDetailCell extends StatelessWidget {
  const BillDetailCell({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      height: 65,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "5/6期",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                "还款日：2020-06-28",
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                "本期未还",
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.black,
                ),
              ),
              Text(
                "553.12",
                style: TextStyle(
                  fontSize: 14,
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
