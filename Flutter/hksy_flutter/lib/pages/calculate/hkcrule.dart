import 'package:flutter/material.dart';
import 'package:hksy_flutter/public/public.dart';

class HkcRulePage extends StatelessWidget {
  const HkcRulePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      appBar: customAppBar(
        title: "HKC规则",
        brightness: Brightness.dark,
        backgroundColor: kMainBackgroundColor,
        color: Colors.white,
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(
            12, 26, 12, MediaQuery.of(context).padding.bottom),
        children: <Widget>[
          Text(
            "HKC按照存储器算力进行配比",
            style: TextStyle(
              fontSize: 15,
              color: rgba(255, 255, 255, 1),
            ),
          ),
        ],
      ),
    );
  }
}
