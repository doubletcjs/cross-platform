import 'package:flutter/material.dart';

class HomeDynamicCell extends StatefulWidget {
  HomeDynamicCell({Key key}) : super(key: key);

  @override
  _HomeDynamicCellState createState() => _HomeDynamicCellState();
}

class _HomeDynamicCellState extends State<HomeDynamicCell> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width * 9 / 16,
    );
  }
}
