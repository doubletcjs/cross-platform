import 'package:flutter/material.dart';
import 'package:ideaclass/public/public.dart';

class MineCell extends StatelessWidget {
  String icon;
  String text;
  String subText;

  MineCell({this.icon = "", this.text = "", this.subText = ""});

  @override
  Widget build(BuildContext context) {
    return buttonWidget(
      Container(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        height: 55,
        child: Row(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  width: 19,
                  height: 23,
                  child: Image.asset("images/$icon"),
                ),
                Text(text),
              ],
            ),
            Expanded(child: Container()),
            Row(
              children: <Widget>[
                (subText.length > 0) ? Text(subText) : Container(),
                Container(
                  width: 7,
                  margin: EdgeInsets.fromLTRB(16, 0, 0, 0),
                  child: Image.asset("images/jiantou@3x.png",
                      fit: BoxFit.fitWidth),
                ),
              ],
            ),
          ],
        ),
      ),
      context,
      onTap: () {},
      color: Colors.white,
    );
  }
}
