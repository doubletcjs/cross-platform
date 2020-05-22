import 'package:flutter/material.dart';
import 'package:hksy_flutter/public/public.dart';

class InvitationMain extends StatefulWidget {
  InvitationMain({Key key}) : super(key: key);

  @override
  _InvitationMainState createState() => _InvitationMainState();
}

class _InvitationMainState extends State<InvitationMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      appBar: customAppBar(
        title: "邀请收益",
        brightness: Brightness.dark,
        backgroundColor: kMainBackgroundColor,
        color: Colors.white,
      ),
    );
  }
}
