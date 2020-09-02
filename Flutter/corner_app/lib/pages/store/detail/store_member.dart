import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

class StoreDetailMember extends StatefulWidget {
  StoreDetailMember({Key key}) : super(key: key);

  @override
  _StoreDetailMemberState createState() => _StoreDetailMemberState();
}

class _StoreDetailMemberState extends State<StoreDetailMember> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rgba(255, 255, 255, 1),
      appBar: customAppBar(
        title: "角落成员",
        defaultBack: true,
      ),
    );
  }
}
