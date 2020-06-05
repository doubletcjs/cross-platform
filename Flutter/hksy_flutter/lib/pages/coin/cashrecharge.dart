import 'package:flutter/material.dart';
import 'package:hksy_flutter/public/public.dart';

class CashRecharge extends StatefulWidget {
  CashRecharge({Key key}) : super(key: key);

  @override
  _CashRechargeState createState() => _CashRechargeState();
}

class _CashRechargeState extends State<CashRecharge> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      appBar: customAppBar(
        title: "现金充值",
        brightness: Brightness.dark,
        backgroundColor: kMainBackgroundColor,
        color: Colors.white,
      ),
    );
  }
}
