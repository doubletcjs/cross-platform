import 'package:flutter/material.dart';
import 'package:hksy_flutter/public/public.dart';

class StorePage extends StatefulWidget {
  StorePage({Key key}) : super(key: key);

  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "商城",
        brightness: Brightness.dark,
        backgroundColor: kMainBackgroundColor,
        color: Colors.white,
      ),
      body: Container(
        color: kMainBackgroundColor,
        child: Center(
          child: Text("商城"),
        ),
      ),
    );
  }
}
