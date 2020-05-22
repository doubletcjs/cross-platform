import 'package:flutter/material.dart';
import 'package:hksy_flutter/public/public.dart';

class VipStoragePage extends StatefulWidget {
  VipStoragePage({Key key}) : super(key: key);

  @override
  _VipStoragePageState createState() => _VipStoragePageState();
}

class _VipStoragePageState extends State<VipStoragePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      appBar: customAppBar(
        title: "超级存储",
        brightness: Brightness.dark,
        backgroundColor: kMainBackgroundColor,
        color: Colors.white,
      ),
    );
  }
}
