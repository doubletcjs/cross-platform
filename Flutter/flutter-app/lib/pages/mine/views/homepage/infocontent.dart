import 'package:flutter/material.dart';
import '../../../../public/public.dart';

class InfoContent extends StatefulWidget {
  InfoContent({Key key}) : super(key: key);

  @override
  _InfoContentState createState() => _InfoContentState();
}

class _InfoContentState extends State<InfoContent> {
  List _infoIcons = [
    "images/dadanshen@3x.png",
    "images/sehngao@3x.png",
    "images/geren@3x.png",
  ];

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
            "往后余生想与你携手终身",
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
                        "使用我们自定义的字体图标使用我们自定义的字体图标",
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
