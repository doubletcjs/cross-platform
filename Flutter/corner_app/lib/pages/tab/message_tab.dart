import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

class MessageTabPage extends StatefulWidget {
  MessageTabPage({Key key}) : super(key: key);

  @override
  _MessageTabPageState createState() => _MessageTabPageState();
}

class _MessageTabPageState extends State<MessageTabPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "消息",
        defaultBack: true,
      ),
    );
  }
}
