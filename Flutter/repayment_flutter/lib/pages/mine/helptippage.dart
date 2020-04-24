import 'package:flutter/material.dart';
import 'package:repayment_flutter/public/public.dart';

class HelptipPage extends StatelessWidget {
  const HelptipPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "使用帮助",
      ),
    );
  }
}
