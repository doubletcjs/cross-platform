import 'package:flutter/material.dart';
import 'package:hksy_flutter/public/public.dart';

class HomeIntroduce extends StatefulWidget {
  HomeIntroduce({Key key}) : super(key: key);

  @override
  _HomeIntroduceState createState() => _HomeIntroduceState();
}

class _HomeIntroduceState extends State<HomeIntroduce> {
  List _dataList = [
    "收益透明",
    "一键存储",
    "优质云存储",
    "大带宽共享",
    "自主研发",
    "技术支持",
    "高性价比",
    "专业维护",
  ];

  List _dataImagesList = [
    "images/ico_home_advantage_profit@3x.png",
    "images/ico_home_advantage_storage@3x.png",
    "images/ico_home_advantage_icloud@3x.png",
    "images/ico_home_advantage_broadband@3x.png",
    "images/ico_home_advantage_research@3x.png",
    "images/ico_home_advantage_technology@3x.png",
    "images/ico_home_advantage_cost@3x.png",
    "images/ico_home_advantage_maintain@3x.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          "为存储而生",
          style: TextStyle(
            fontSize: 23,
            color: rgba(255, 255, 255, 1),
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          "做IPFS生态的引领者",
          style: TextStyle(
            fontSize: 13,
            color: rgba(145, 152, 173, 1),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(16.5, 25.5, 16.5, 46.5),
          child: Wrap(
            spacing:
                (MediaQuery.of(context).size.width - 16.5 * 2 - 65 * 4) / 3,
            runSpacing: 36,
            children: _dataList.map(
              (introduce) {
                int index = _dataList.indexOf(introduce);
                return Container(
                  width: 65,
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        _dataImagesList[index],
                        width: 34,
                        height: 34,
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      Text(
                        introduce,
                        style: TextStyle(
                          fontSize: 13,
                          color: rgba(145, 152, 173, 1),
                        ),
                      )
                    ],
                  ),
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }
}
