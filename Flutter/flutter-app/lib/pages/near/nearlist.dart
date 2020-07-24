import 'package:flutter/material.dart';
import '../account/views/accountfunctioncell.dart';
import '../../public/public.dart';

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
    return Scaffold(
      backgroundColor: rgba(248, 248, 248, 1),
      body: Stack(
        children: <Widget>[
          transparentAppBar(
            brightness: Brightness.light,
          ),
          ListView.builder(
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              return AccountFunctionCell();
            },
            itemCount: 10,
          ),
        ],
      ),
    );
  }
}
