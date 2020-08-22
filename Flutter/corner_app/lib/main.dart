import 'package:flutter/material.dart';

void main() {
  runApp(CornerApp());
}

class CornerApp extends StatefulWidget {
  CornerApp({Key key}) : super(key: key);

  @override
  _CornerAppState createState() => _CornerAppState();
}

class _CornerAppState extends State<CornerApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "角落",
      home: Scaffold(),
    );
  }
}
