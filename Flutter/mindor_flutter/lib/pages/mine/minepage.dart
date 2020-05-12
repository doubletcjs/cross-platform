import 'package:flutter/material.dart';
import 'package:mindor_flutter/public/public.dart';

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
          brightness: Brightness.light,
        ),
        Center(
          child: Text(
            "我",
          ),
        ),
      ],
    );
  }
}
