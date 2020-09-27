import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

class DiscoverTabPage extends StatefulWidget {
  DiscoverTabPage({Key key}) : super(key: key);

  @override
  _DiscoverTabPageState createState() => _DiscoverTabPageState();
}

class _DiscoverTabPageState extends State<DiscoverTabPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "发现",
        defaultBack: true,
      ),
    );
  }
}
