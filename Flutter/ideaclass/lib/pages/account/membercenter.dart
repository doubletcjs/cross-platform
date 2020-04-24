import 'package:flutter/material.dart';
import 'package:ideaclass/public/public.dart';

class MemberCenterPage extends StatefulWidget {
  MemberCenterPage({Key key}) : super(key: key);

  @override
  _MemberCenterPageState createState() => _MemberCenterPageState();
}

class _MemberCenterPageState extends State<MemberCenterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "会员中心", 
      ),
      body: Container(),
    );
  }
}
