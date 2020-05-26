import 'package:flutter/material.dart';
import 'package:hksy_flutter/public/public.dart';

class OrderComplete extends StatelessWidget {
  const OrderComplete({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      appBar: customAppBar(
        title: "购买完成",
        brightness: Brightness.dark,
        backgroundColor: kMainBackgroundColor,
        color: Colors.white,
      ),
    );
  }
}
