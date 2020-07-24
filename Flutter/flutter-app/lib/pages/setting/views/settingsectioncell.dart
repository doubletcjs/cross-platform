import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import '../../../public/public.dart';

class SettingBaseCell extends StatelessWidget {
  bool hideLine = false;
  String name = "";
  String value = "";
  Widget valueWidget;
  kVoidFunctionBlock tapHandle;

  SettingBaseCell({
    Key key,
    this.hideLine = false,
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
                tapHandle();
              },
        child: Column(
          children: <Widget>[
            Container(
              height: 44,
              child: Container(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
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
                    valueWidget != null
                        ? valueWidget
                        : Row(
                            children: <Widget>[
                              //内容
                              ObjectUtil.isEmptyString(value) == true
                                  ? Container()
                                  : Text(
                                      value,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: rgba(166, 166, 166, 1),
                                      ),
                                    ),
                              SizedBox(
                                width: 8.5,
                              ),
                              //箭头
                              Image.asset(
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
            ),
            hideLine
                ? Container()
                : Container(
                    margin: EdgeInsets.fromLTRB(16, 0, 0, 0),
                    height: 0.5,
                    color: rgba(233, 233, 233, 1),
                  ),
          ],
        ),
      ),
    );
  }
}

class SettingBaseSection extends StatelessWidget {
  String title = "";
  SettingBaseSection({
    Key key,
    this.title = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: rgba(248, 248, 248, 1),
      padding: EdgeInsets.fromLTRB(13.5, 12.5, 13.5, 12.5),
      alignment: Alignment.centerLeft,
      child: ObjectUtil.isEmptyString(title)
          ? Container()
          : Text(
              title,
              style: TextStyle(
                fontSize: 13,
                color: rgba(153, 153, 153, 1),
              ),
            ),
    );
  }
}
