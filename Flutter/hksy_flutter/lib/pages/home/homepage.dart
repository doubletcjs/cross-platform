import 'package:flutter/material.dart';
import 'package:hksy_flutter/public/public.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      body: Stack(
        children: <Widget>[
          transparentAppBar(
            brightness: Brightness.dark,
          ),
          Center(
            child: Text("首页"),
          ),
        ],
      ),
    );
  }
}
