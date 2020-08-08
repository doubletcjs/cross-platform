import 'package:flutter/material.dart';
import '../../../public/public.dart';

class MineCell extends StatelessWidget {
  String icon = "";
  String text = "";
  bool showLine = true;
  kVoidFunctionBlock tapHandle;

  MineCell({
    Key key,
    this.showLine = true,
    this.icon = "",
    this.text = "",
    this.tapHandle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          if (tapHandle != null) {
            tapHandle();
          }
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(14, 0, 18.5, 0),
          height: 49,
          decoration: BoxDecoration(
            border: Border(
              bottom: showLine
                  ? BorderSide(
                      width: 1,
                      color: rgba(245, 245, 245, 1),
                    )
                  : BorderSide.none,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Image.asset(
                    icon,
                    width: 22,
                    height: 22,
                  ),
                  SizedBox(
                    width: 11.5,
                  ),
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 15,
                      color: rgba(38, 38, 38, 1),
                    ),
                  ),
                ],
              ),
              Image.asset(
                "images/Shape@3x.png",
                width: 8,
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
