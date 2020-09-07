import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StoreDynamicCell extends StatefulWidget {
  int row;
  StoreDynamicCell({
    Key key,
    this.row = 0,
  }) : super(key: key);

  @override
  _StoreDynamicCellState createState() => _StoreDynamicCellState();
}

class _StoreDynamicCellState extends State<StoreDynamicCell> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(16, 20, 16, 12),
      decoration: BoxDecoration(
        color: rgba(255, 255, 255, 1),
        border: Border(
          top: BorderSide(
            width: 8,
            color: rgba(247, 246, 245, 1),
          ),
        ),
      ),
      child: Text("${this.widget.row}"),
    );
  }
}
