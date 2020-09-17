import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SpaceDetailCell extends StatelessWidget {
  String text = "";
  Widget child;
  kVoidFunctionBlock onTap;
  SpaceDetailCell({
    Key key,
    this.text = "",
    this.child,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: rgba(255, 255, 255, 1),
      child: InkWell(
        onTap: onTap == null
            ? null
            : () {
                onTap();
              },
        child: Container(
          padding: EdgeInsets.fromLTRB(16, 20, 16, 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "$text",
                style: TextStyle(
                  fontSize: 16,
                  color: rgba(50, 50, 50, 1),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    child != null ? child : Container(),
                    SizedBox(
                      width: child != null ? 20 : 0,
                    ),
                    Image.asset(
                      "images/detail_arrow@3x.png",
                      width: 5.5,
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
