import 'package:flutter/material.dart';

class BillNoRecordPage extends StatelessWidget {
  String image = "images/icon_no_record.png";
  String title = "没有记录";

  BillNoRecordPage(
      {Key key, this.image = "images/icon_no_record.png", this.title = "没有记录"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 66,
          ),
          Image.asset(
            image,
            fit: BoxFit.fitWidth,
            width: 98,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "没有记录",
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
