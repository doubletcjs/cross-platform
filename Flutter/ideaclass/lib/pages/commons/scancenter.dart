import 'package:flutter/material.dart';
import 'package:ideaclass/public/public.dart';

class ScanCenterPage extends StatefulWidget {
  ScanCenterPage({Key key}) : super(key: key);

  @override
  _ScanCenterPageState createState() => _ScanCenterPageState();
}

class _ScanCenterPageState extends State<ScanCenterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "扫码", 
      ),
      body: Container(),
    );
  }
}
