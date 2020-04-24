import 'package:flutter/material.dart';
import 'package:ideaclass/public/public.dart';

class FunctionSection extends StatelessWidget {
  EdgeInsets padding;
  String title = "";

  FunctionSection({this.padding, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding == null ? EdgeInsets.fromLTRB(0, 9, 0, 6) : padding,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
            width: 3,
            height: 20,
            color: rgba(23, 159, 251, 1),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              color: rgba(23, 23, 23, 1),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
