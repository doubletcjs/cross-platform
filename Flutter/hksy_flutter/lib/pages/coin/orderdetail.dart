import 'package:flutter/material.dart';
import 'package:hksy_flutter/public/public.dart';

class OrderDetail extends StatefulWidget {
  OrderDetail({Key key}) : super(key: key);

  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      appBar: customAppBar(
        title: "订单明细",
        brightness: Brightness.dark,
        backgroundColor: kMainBackgroundColor,
        color: Colors.white,
        rightItems: [
          FlatButton(
            padding: EdgeInsets.zero,
            onPressed: () {},
            child: Text(
              "客服",
              style: TextStyle(
                fontSize: 15,
                color: rgba(255, 255, 255, 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
