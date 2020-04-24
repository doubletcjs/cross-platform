import 'package:flutter/material.dart';
import 'package:ideaclass/public/public.dart';

class PersonPortraitCell extends StatelessWidget {
  String avatar;
  String text;
  kVoidFunctionBlock onTap;

  PersonPortraitCell({this.onTap, this.text = "", this.avatar});

  @override
  Widget build(BuildContext context) {
    return buttonWidget(
        Container(
          height: 64,
          padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                text,
                style: TextStyle(
                  fontSize: 14,
                  color: rgba(23, 23, 23, 1),
                ),
              ),
              Row(
                children: <Widget>[
                  avatar == null
                      ? Image.asset(
                          "images/user_head_default@3x.png",
                          width: 37,
                          height: 37,
                        )
                      : radiusNetworkImage(
                          avatar,
                          37,
                          37,
                          placeholder: "images/user_head_default@3x.png",
                          radius: BorderRadius.circular(37 / 2),
                        ),
                  SizedBox(
                    width: 12,
                  ),
                  Image.asset(
                    "images/jiantou@3x.png",
                    fit: BoxFit.fitWidth,
                    width: 6,
                  ),
                ],
              ),
            ],
          ),
        ),
        context,
        color: Colors.white, onTap: () {
      if (onTap != null) {
        onTap();
      }
    });
  }
}

class PersonBindingCell extends StatelessWidget {
  String iconPath;
  String text;
  bool binded;
  kObjectFunctionBlock onTap;
  PersonBindingCell(
      {this.onTap, this.iconPath, this.text = "", this.binded = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              isStringEmpty(iconPath) == false
                  ? Image.asset(
                      iconPath,
                      width: 40,
                      height: 40,
                    )
                  : Container(),
              SizedBox(
                width: 12,
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: 14,
                  color: rgba(23, 23, 23, 1),
                ),
              )
            ],
          ),
          Container(
            height: 20,
            width: 64,
            child: FlatButton(
              padding: EdgeInsets.zero,
              color: binded == true ? rgba(181, 181, 181, 1) : kMainColor,
              onPressed: () {
                if (onTap != null) {
                  onTap(binded == true ? "解除绑定" : "立即绑定");
                }
              },
              child: Text(
                binded == true ? "解除绑定" : "立即绑定",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20 / 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PersonInfoCell extends StatelessWidget {
  String text;
  String content;
  kVoidFunctionBlock onTap;

  PersonInfoCell({this.text = "", this.content = "未设置", this.onTap});

  @override
  Widget build(BuildContext context) {
    return buttonWidget(
      Container(
        height: 54,
        padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: rgba(23, 23, 23, 1),
              ),
            ),
            Row(
              children: <Widget>[
                Text(
                  isStringEmpty(content) == true ? "未设置" : content,
                  style: TextStyle(
                    fontSize: 12,
                    color: rgba(136, 136, 136, 1),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Image.asset(
                  "images/jiantou@3x.png",
                  fit: BoxFit.fitWidth,
                  width: 6,
                ),
              ],
            ),
          ],
        ),
      ),
      context,
      color: Colors.white,
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
    );
  }
}
