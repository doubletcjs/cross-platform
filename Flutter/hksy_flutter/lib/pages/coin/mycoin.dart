import 'package:flutter/material.dart';
import 'package:hksy_flutter/public/public.dart';

class MyCoinPage extends StatefulWidget {
  MyCoinPage({Key key}) : super(key: key);

  @override
  _MyCoinPageState createState() => _MyCoinPageState();
}

class _MyCoinPageState extends State<MyCoinPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      appBar: customAppBar(
        title: "我的金币",
        brightness: Brightness.dark,
        backgroundColor: kMainBackgroundColor,
        color: Colors.white,
      ),
    );
  }
}
