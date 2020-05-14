import 'package:flutter/material.dart';
import 'package:hksy_flutter/public/public.dart';

class MinePage extends StatefulWidget {
  MinePage({Key key}) : super(key: key);

  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      body: Stack(
        children: <Widget>[
          transparentAppBar(
            brightness: Brightness.dark,
          ),
          Container(
            child: Center(
              child: Text("我的"),
            ),
          ),
        ],
      ),
    );
  }
}
