import 'package:flutter/material.dart';
import 'package:hksy_flutter/public/public.dart';

class BaseEmptyPage extends StatelessWidget {
  String title = "";
  String content = "";
  double topSpace = 140.5;
  BaseEmptyPage({
    Key key,
    this.title = "",
    this.content = "",
    this.topSpace = 140.5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(30, topSpace, 30, 0),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "images/nodata@3x.png",
            width: 119,
            height: 119,
            fit: BoxFit.fitWidth,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: TextStyle(
              color: rgba(145, 152, 173, 1),
              fontSize: 13,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            content,
            style: TextStyle(
              color: rgba(145, 152, 173, 1),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
