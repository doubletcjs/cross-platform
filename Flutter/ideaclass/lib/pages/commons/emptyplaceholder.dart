import 'package:flutter/material.dart';
import 'package:ideaclass/public/public.dart';

class EmptyPlaceholder extends StatelessWidget {
  String placeholderName;
  String tipContent;
  double topOffset;
  bool loading;

  EmptyPlaceholder({
    this.placeholderName = "images/bg_no_data@3x.png",
    this.tipContent = "暂无数据",
    this.topOffset = 130.0,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return loading == true
        ? Container()
        : Container(
            padding: EdgeInsets.fromLTRB(50, topOffset, 50, 0),
            child: Center(
              child: Column(
                children: <Widget>[
                  Image.asset(
                    placeholderName,
                    width: 209,
                    height: 136,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    tipContent,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: rgba(0, 0, 0, 0.4),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
