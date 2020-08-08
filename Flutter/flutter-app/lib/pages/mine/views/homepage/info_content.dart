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

  List _livingStatus = [
    "保密",
    "一个人",
    "和家人",
    "和某人",
    "和朋友",
  ]; //居住状态 0：保密 1：一个人 2：和家人 3：和某人 4：和朋友
  List _smokingHabit = [
    "保密",
    "从不",
    "偶尔",
    "经常",
  ]; //抽烟习惯 0：保密 1：从不 2：偶尔 3：经常
  List _emotions = [
    "保密",
    "单身",
    "恋爱中",
    "已婚",
    "丧偶",
    "离婚",
  ]; //情感状态 0：保密 1：单身 2：恋爱中 3：已婚 4：丧偶 5：离婚

  //居住状态、小孩数、吸烟
  String _combination() {
    List _list = [];
    if (this.widget.account['living_status'] != null) {
      _list.add(_livingStatus[this.widget.account['living_status']]);
    }

    if (this.widget.account['child_nums'] != null) {
      _list.add(this.widget.account['child_nums'] +
                  this.widget.account['child_nums'] ==
              0
          ? "无小孩"
          : "${this.widget.account['child_nums']}" + "个小孩");
    }

    if (this.widget.account['smoking_habit'] != null) {
      _list.add(_smokingHabit[this.widget.account['smoking_habit']]);
    }

    return _list.join("，");
  }

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
            this.widget.account["signature"] == null
                ? ""
                : "${this.widget.account['signature']}",
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
                            ? this.widget.account["emotion"] == null
                                ? ""
                                : "${_emotions[this.widget.account['emotion']]}"
                            : index == 1
                                ? this.widget.account["height"] == null
                                    ? ""
                                    : "${this.widget.account['height']}" + "cm"
                                : index == 2 ? _combination() : "",
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
