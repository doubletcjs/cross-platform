import 'package:flutter/material.dart';
import 'package:hksy_flutter/pages/home/views/homeassets.dart';
import 'package:hksy_flutter/pages/home/views/homeheader.dart';
import 'package:hksy_flutter/pages/home/views/homeintroduce.dart';
import 'package:hksy_flutter/pages/home/views/homenotice.dart';
import 'package:hksy_flutter/pages/home/views/homerecommend.dart';
import 'package:hksy_flutter/public/public.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      body: Stack(
        children: <Widget>[
          transparentAppBar(
            brightness: Brightness.dark,
          ),
          ListView.builder(
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              return index == 0
                  ? HomeHeader()
                  : index == 1
                      ? HomeNotice()
                      : index == 2
                          ? HomeAssets()
                          : index == 3
                              ? HomeRecommend()
                              : index == 4 ? HomeIntroduce() : Container();
            },
            itemCount: 5,
          ),
        ],
      ),
    );
  }
}
