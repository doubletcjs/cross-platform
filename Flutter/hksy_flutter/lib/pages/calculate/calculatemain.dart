import 'package:flutter/material.dart';
import 'package:hksy_flutter/public/public.dart';

class CalculateMain extends StatefulWidget {
  CalculateMain({Key key}) : super(key: key);

  @override
  _CalculateMainState createState() => _CalculateMainState();
}

class _CalculateMainState extends State<CalculateMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      appBar: customAppBar(
        title: "我的算力",
        brightness: Brightness.dark,
        backgroundColor: kMainBackgroundColor,
        color: Colors.white,
      ),
    );
  }
}
