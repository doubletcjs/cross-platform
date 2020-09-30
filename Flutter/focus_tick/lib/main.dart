import 'package:flutter/material.dart';
import 'package:focus_tick/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Focus Tick',
      home: HomePage(),
    );
  }
}
