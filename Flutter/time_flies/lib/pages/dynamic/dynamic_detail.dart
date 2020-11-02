import 'package:flutter/material.dart';
import 'package:time_flies/public/public.dart';

// ignore: must_be_immutable
class DynamicDetailPage extends StatefulWidget {
  Map dynamic;
  DynamicDetailPage({
    Key key,
    @required this.dynamic,
  }) : super(key: key);

  @override
  _DynamicDetailPageState createState() => _DynamicDetailPageState();
}

class _DynamicDetailPageState extends State<DynamicDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        defaultBack: true,
        title: "正文",
      ),
    );
  }
}
