import 'package:diary_mood/public/public.dart';
import 'package:flutter/material.dart';

class DiaryTabPage extends StatefulWidget {
  DiaryTabPage({Key key}) : super(key: key);

  @override
  _DiaryTabPageState createState() => _DiaryTabPageState();
}

class _DiaryTabPageState extends State<DiaryTabPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppBar(
        brightness: Brightness.light,
      ),
    );
  }
}
