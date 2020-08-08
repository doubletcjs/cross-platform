import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import '../../../../public/public.dart';

class InfoBaseCell extends StatelessWidget {
  bool hideLine = false;
  bool hideArrow = false;
  String name = "";
  String value = "";
  Widget valueWidget;
  kVoidFunctionBlock tapHandle;

  InfoBaseCell({
    Key key,
    this.hideLine = false,
    this.hideArrow = false,
    this.name = "",
    this.value = "",
    this.tapHandle,
    this.valueWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: rgba(255, 255, 255, 1),
      child: InkWell(
        onTap: tapHandle == null
            ? null
            : () {
                if (tapHandle != null) {
                  tapHandle();
                }
              },
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(13.5, 0, 13.5, 0),
              height: 59,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  //名称
                  ObjectUtil.isEmptyString(name) == true
                      ? Container()
                      : Text(
                          name,
                          style: TextStyle(
                            fontSize: 15,
                            color: rgba(51, 51, 51, 1),
                          ),
                        ),
                  Row(
                    children: <Widget>[
                      //内容
                      valueWidget != null
                          ? valueWidget
                          : ObjectUtil.isEmptyString(value) == true
                              ? Container()
                              : Text(
                                  value,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: rgba(166, 166, 166, 1),
                                  ),
                                ),
                      SizedBox(
                        width: valueWidget != null ? 0 : 8.5,
                      ),
                      //箭头
                      hideArrow == true
                          ? Container()
                          : Image.asset(
                              "images/Arrow@3x.png",
                              width: 6,
                              height: 10.5,
                            ),
                      SizedBox(
                        width: 8,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            hideLine
                ? Container()
                : Container(
                    margin: EdgeInsets.fromLTRB(13.5, 0, 13.5, 0),
                    height: 0.5,
                    color: rgba(85, 85, 85, 0.1),
                  ),
          ],
        ),
      ),
    );
  }
}

class InfoBaseSection extends StatelessWidget {
  String title = "";
  InfoBaseSection({
    Key key,
    this.title = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 41,
      color: rgba(243, 243, 243, 1),
      padding: EdgeInsets.fromLTRB(12.5, 0, 12.5, 0),
      alignment: Alignment.centerLeft,
      child: ObjectUtil.isEmptyString(title)
          ? Container()
          : Text(
              title,
              style: TextStyle(
                fontSize: 13,
                color: rgba(51, 51, 51, 1),
                fontWeight: FontWeight.w500,
              ),
            ),
    );
  }
}
