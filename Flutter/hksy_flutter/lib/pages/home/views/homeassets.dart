import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/material.dart';
import 'package:hksy_flutter/pages/home/api/homeapi.dart';
import 'package:hksy_flutter/public/public.dart';

class HomeAssets extends StatefulWidget {
  HomeAssets({Key key}) : super(key: key);

  @override
  _HomeAssetsState createState() => _HomeAssetsState();
}

class _HomeAssetsState extends State<HomeAssets> {
  Map _performance = {
    "expericence": 0.0,
    "yesterday_performance": 0.0,
    "storage": 0.0,
    "hkcstorage": 0.0,
  };

  @override
  void initState() {
    super.initState();

    userID((id) {
      HomeApi.getMyAssetsDetail(id, (data, msg) {
        if (data != null) {
          setState(() {
            _performance = data["performancedata"];
          });

          DartNotificationCenter.post(channel: "kGetMyAssetsCommend", options: {
            "pList": data["pList"],
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(12, 0, 12, 35),
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
          SizedBox(
            height: 19,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(24.5, 18.5, 24.5, 12.5),
            decoration: BoxDecoration(
              color: rgba(23, 96, 255, 1),
              borderRadius: BorderRadius.circular(7.5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "总业绩",
                  style: TextStyle(
                    color: rgba(255, 255, 255, 1),
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "${_performance["expericence"]}",
                      style: TextStyle(
                        color: rgba(255, 255, 255, 1),
                        fontSize: 30,
                      ),
                    ),
                    SizedBox(
                      width: 9,
                    ),
                    Text(
                      "T",
                      style: TextStyle(
                        color: rgba(255, 255, 255, 1),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          "昨日业绩",
                          style: TextStyle(
                            color: rgba(255, 255, 255, 1),
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${_performance["yesterday_performance"]}T",
                          style: TextStyle(
                            color: rgba(255, 255, 255, 1),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "个人存储",
                          style: TextStyle(
                            color: rgba(255, 255, 255, 1),
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${_performance["storage"]}T + ${_performance["hkcstorage"]}T",
                          style: TextStyle(
                            color: rgba(255, 255, 255, 1),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
