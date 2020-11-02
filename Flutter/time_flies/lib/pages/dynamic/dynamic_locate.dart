import 'package:flutter/material.dart';
import 'package:time_flies/public/public.dart';

class DynamicLocatePage extends StatefulWidget {
  DynamicLocatePage({Key key}) : super(key: key);

  @override
  _DynamicLocatePageState createState() => _DynamicLocatePageState();
}

class _DynamicLocatePageState extends State<DynamicLocatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        defaultBack: true,
      ),
    );
  }
}
