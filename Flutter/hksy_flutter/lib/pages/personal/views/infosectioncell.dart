import 'package:flutter/material.dart';
import 'package:hksy_flutter/public/public.dart';

class InfoCell extends StatelessWidget {
  String name = "";
  String value = "";
  bool showArrow = true;
  bool isPortrait = false;
  bool showLine = true;
  kVoidFunctionBlock tapHandle;

  InfoCell({
    Key key,
    this.name = "",
    this.value = "",
    this.showArrow = true,
    this.isPortrait = false,
    this.showLine = true,
    this.tapHandle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: isPortrait == true
            ? EdgeInsets.fromLTRB(0, 6, 0, 6)
            : EdgeInsets.fromLTRB(0, 20, 0, 20),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: rgba(21, 25, 54, 1),
              width: showLine == true ? 1 : 0,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              name,
              style: TextStyle(
                fontSize: 15,
                color: rgba(255, 255, 255, 1),
              ),
            ),
            Row(
              children: <Widget>[
                isPortrait == true
                    ? value.length > 0
                        ? Image.network(
                            value,
                            width: 59,
                            height: 59,
                          )
                        : Image.asset(
                            "images/default_avatar@3x.png",
                            width: 59,
                            height: 59,
                          )
                    : value.length > 0
                        ? Text(
                            value,
                            style: TextStyle(
                              color: rgba(145, 152, 173, 1),
                              fontSize: 15,
                            ),
                          )
                        : Container(),
                SizedBox(
                  width: ((value.length > 0 || isPortrait == true) &&
                          showArrow == true)
                      ? 12
                      : 0,
                ),
                showArrow == true
                    ? Image.asset(
                        "images/right_arrow@3x.png",
                        width: 16,
                        height: 25,
                      )
                    : Container(),
              ],
            ),
          ],
        ),
      ),
      onTap: () {
        if (tapHandle != null) {
          tapHandle();
        }
      },
    );
  }
}

class InfoSection extends StatelessWidget {
  List<Widget> cells = [];
  double topSpace = 0.0;
  InfoSection({Key key, this.cells, this.topSpace = 0.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: topSpace,
        ),
        Container(
          padding: EdgeInsets.fromLTRB(24.5, 0, 24.5, 0),
          decoration: BoxDecoration(
            color: rgba(28, 35, 63, 1),
            borderRadius: BorderRadius.circular(7.5),
          ),
          child: Column(
            children: cells,
          ),
        ),
      ],
    );
  }
}
