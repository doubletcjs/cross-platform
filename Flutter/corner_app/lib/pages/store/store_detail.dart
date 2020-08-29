import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

class StoreDetailPage extends StatefulWidget {
  StoreDetailPage({Key key}) : super(key: key);

  @override
  _StoreDetailPageState createState() => _StoreDetailPageState();
}

class _StoreDetailPageState extends State<StoreDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rgba(247, 246, 245, 1),
      appBar: customAppBar(
        title: "角落详情",
        defaultBack: true,
        rightItems: [
          Center(
            child: Container(
              margin: EdgeInsets.only(right: 4),
              child: IconButton(
                icon: Image.asset(
                  "images/detail_share@3x.png",
                  width: 20,
                  height: 20,
                ),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          // 头
          Container(
            color: rgba(255, 255, 255, 1),
            padding: EdgeInsets.fromLTRB(16, 30, 16, 20),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: rgba(255, 255, 255, 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 4),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: networkImage(
                    "",
                    Size(50.5, 50.5),
                    BorderRadius.circular(4),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  "每日一食记",
                  style: TextStyle(
                    fontSize: 20,
                    color: rgba(50, 50, 50, 1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
