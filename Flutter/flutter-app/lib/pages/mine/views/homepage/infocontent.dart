import 'package:flutter/material.dart';
import '../../../../public/public.dart';

class InfoContent extends StatefulWidget {
  Map account;
  InfoContent({Key key, this.account}) : super(key: key);

  @override
  _InfoContentState createState() => _InfoContentState();
}

class _InfoContentState extends State<InfoContent> {
  List _infoIcons = [
    "images/dadanshen@3x.png",
    "images/sehngao@3x.png",
    "images/geren@3x.png",
  ];

  List _livingstatus = [
    "保密",
    "一个人",
    "和家人",
    "和某人",
    "和朋友",
  ]; //居住状态 0：保密 1：一个人 2：和家人 3：和某人 4：和朋友
  List _smokinghabit = [
    "保密",
    "从不",
    "偶尔",
    "经常",
  ]; //抽烟习惯 0：保密 1：从不 2：偶尔 3：经常

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
      padding: EdgeInsets.fromLTRB(0, 30.5, 0, 13.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "关于我",
            style: TextStyle(
              color: rgba(51, 51, 51, 1),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 9.5,
          ),
          //个性签名
          Text(
            "${this.widget.account["signature"]}",
            style: TextStyle(
              color: rgba(51, 51, 51, 1),
              fontSize: 16,
            ),
          ),
          SizedBox(
            height: 36.5,
          ),
          Text(
            "个人信息",
            style: TextStyle(
              color: rgba(51, 51, 51, 1),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 23.5,
          ),
          Column(
            children: _infoIcons.map((icon) {
              int index = _infoIcons.indexOf(icon);
              return Container(
                padding: EdgeInsets.fromLTRB(2, 0, 2, 24),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                      child: Image.asset(
                        icon,
                        width: 15,
                        height: 15,
                      ),
                    ),
                    SizedBox(
                      width: 13.5,
                    ),
                    Expanded(
                      child: Text(
                        index == 0
                            ? "单身"
                            : index == 1
                                ? "${this.widget.account["height"]}" + "cm"
                                : index == 2
                                    ? "${_livingstatus[this.widget.account["living_status"]]}，${this.widget.account["child_nums"]}个小孩，${_smokinghabit[this.widget.account["smoking_habit"]]}"
                                    : "",
                        style: TextStyle(
                          color: rgba(51, 51, 51, 1),
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
