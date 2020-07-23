import 'package:flutter/material.dart';
import '../near/views/nearcell.dart';

class NearList extends StatefulWidget {
  int listType = 0; //0 "附近" 1 "在线" 2 "新人" 3 "认证" 4 "推荐"

  NearList({
    Key key,
    this.listType = 0,
  }) : super(key: key);

  @override
  _NearListState createState() => _NearListState();
}

class _NearListState extends State<NearList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
      itemBuilder: (context, index) {
        return NearCell();
      },
      itemCount: 10,
    );
  }
}
