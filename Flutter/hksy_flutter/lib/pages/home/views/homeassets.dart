import 'package:flutter/material.dart';
import 'package:hksy_flutter/public/public.dart';

class HomeAssets extends StatefulWidget {
  HomeAssets({Key key}) : super(key: key);

  @override
  _HomeAssetsState createState() => _HomeAssetsState();
}

class _HomeAssetsState extends State<HomeAssets> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "我的资产",
            style: TextStyle(
              fontSize: 23,
              color: rgba(255, 255, 255, 1),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
