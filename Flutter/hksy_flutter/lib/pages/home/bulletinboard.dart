import 'package:flutter/material.dart';
import 'package:hksy_flutter/public/public.dart';

class BulletinBoard extends StatefulWidget {
  BulletinBoard({Key key}) : super(key: key);

  @override
  _BulletinBoardState createState() => _BulletinBoardState();
}

class _BulletinBoardState extends State<BulletinBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      appBar: customAppBar(
        title: "公告栏",
        brightness: Brightness.dark,
        backgroundColor: kMainBackgroundColor,
        color: Colors.white,
      ),
      body: ListView.separated(
        padding: EdgeInsets.fromLTRB(
            12, 20, 12, MediaQuery.of(context).padding.bottom),
        itemBuilder: (context, index) {
          return BulletinCell(
            expansion: index % 2 == 0 ? true : false,
          );
        },
        separatorBuilder: (context, index) {
          return Container(
            height: 10,
          );
        },
        itemCount: 20,
      ),
    );
  }
}

class BulletinCell extends StatefulWidget {
  bool expansion = false;
  BulletinCell({Key key, this.expansion = false}) : super(key: key);

  @override
  _BulletinCellState createState() => _BulletinCellState();
}

class _BulletinCellState extends State<BulletinCell> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      decoration: BoxDecoration(
        color: rgba(28, 35, 63, 1),
        borderRadius: BorderRadius.circular(7.5),
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(0, 16.5, 0, 16.5),
            child: Row(
              children: <Widget>[
                Image.asset(
                  "images/hotsale@3x.png",
                  width: 22,
                  height: 22,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    "【华科闪云APP系统升级通知】",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                      color: rgba(255, 255, 255, 1),
                    ),
                  ),
                ),
              ],
            ),
          ),
          this.widget.expansion == true
              ? Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "       华科闪云3.0版本正式上线了！,为了更好的提升用户体验，华科闪云app将于2020年3月15日  20:00进行本次升级，",
                        style: TextStyle(
                          fontSize: 13,
                          color: rgba(255, 255, 255, 1),
                          height: 1.8,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "10-11",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 11,
                              color: rgba(145, 152, 173, 1),
                            ),
                          ),
                          SizedBox(
                            width: 3.5,
                          ),
                          Text(
                            "17:48",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 11,
                              color: rgba(145, 152, 173, 1),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        width: 1,
                        color: rgba(255, 255, 255, 0.2),
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
