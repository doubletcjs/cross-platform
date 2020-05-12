import 'package:flutter/material.dart';
import 'package:mindor_flutter/public/public.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        transparentAppBar(
          brightness: Brightness.light,
        ),
        Center(
          child: Text(
            "首页",
          ),
        ),
      ],
    );
  }
}
