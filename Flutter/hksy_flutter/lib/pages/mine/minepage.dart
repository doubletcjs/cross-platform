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
    return Stack(
      children: <Widget>[
        transparentAppBar(
          brightness: Brightness.dark,
        ),
        Container(
          color: kMainBackgroundColor,
          child: Container(
            color: kMainBackgroundColor,
            child: Center(
              child: Text("我的"),
            ),
          ),
        ),
      ],
    );
  }
}
