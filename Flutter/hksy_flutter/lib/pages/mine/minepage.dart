import 'package:flutter/material.dart';
import 'package:hksy_flutter/pages/mine/views/minesectionview.dart';
import 'package:hksy_flutter/pages/mine/views/mineuserheader.dart';
import 'package:hksy_flutter/public/public.dart';

class MinePage extends StatefulWidget {
  MinePage({Key key}) : super(key: key);

  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      appBar: customAppBar(
        title: "我的",
        brightness: Brightness.dark,
        backgroundColor: kMainBackgroundColor,
        color: Colors.white,
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          MineUserHeaeder(),
          MineSectionView(
            dataSources: [
              {
                "name": "我的钱包",
                "icon": "images/ico_my_wallet@3x.png",
              },
              {
                "name": "我的存储",
                "icon": "images/ico_my_storage@3x.png",
              },
              {
                "name": "我的算力",
                "icon": "images/ico_my_calculation@3x.png",
              },
              {
                "name": "我的金币",
                "icon": "images/ico_my_gold@3x.png",
                "additional": "12353个",
              },
              {
                "name": "超级存储",
                "icon": "images/ico_my_super@3x.png",
              },
              {
                "name": "邀请收益",
                "icon": "images/ico_my_invitation@3x.png",
                "additional": "我的邀请码：ct12f",
              },
            ],
          ),
          MineSectionView(
            dataSources: [
              {
                "name": "联系客服",
                "icon": "images/ico_my_service@3x.png",
              },
              {
                "name": "设置中心",
                "icon": "images/ico_my_setup@3x.png",
              },
            ],
          ),
        ],
      ),
    );
  }
}
