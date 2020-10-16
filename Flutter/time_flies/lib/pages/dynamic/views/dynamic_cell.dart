import 'package:flutter/material.dart';
import 'package:time_flies/pages/dynamic/dynamic_detail.dart';

// ignore: must_be_immutable
class DynamicCell extends StatefulWidget {
  Map dynamic;
  DynamicCell({
    Key key,
    @required this.dynamic,
  }) : super(key: key);

  @override
  _DynamicCellState createState() => _DynamicCellState();
}

class _DynamicCellState extends State<DynamicCell> {
  // 动态详情
  void _dynamicDetail() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return DynamicDetailPage();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
