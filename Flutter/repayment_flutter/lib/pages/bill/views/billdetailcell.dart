import 'package:flutter/material.dart';

class BillDetailCell extends StatelessWidget {
  Map bill;
  BillDetailCell({Key key, this.bill}) : super(key: key);

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
                "${int.parse('${bill['currentterm']}') + 1}/${int.parse('${bill['repaymentterms']}') + 1}期",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                "还款日：${bill['unfolddate']}",
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
                "${double.parse('${bill["eachamount"]}').toStringAsFixed(2)}",
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
