import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/material.dart';
import 'package:hksy_flutter/pages/coin/coinrollout.dart';
import 'package:hksy_flutter/public/public.dart';

class StorageHeader extends StatefulWidget {
  bool isViper = false;
  StorageHeader({Key key, this.isViper = false}) : super(key: key);

  @override
  _StorageHeaderState createState() => _StorageHeaderState();
}

class _StorageHeaderState extends State<StorageHeader> {
  List<String> _performances = [
    "前日业绩",
    "昨日业绩",
    "累计业绩",
  ];

  @override
  void initState() {
    super.initState();

    if (this.widget.isViper) {
      _performances = ["剩余转出额度", "昨日分红", ""];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: this.widget.isViper == true ? 200 : 185,
          child: Image.asset(
            this.widget.isViper == true
                ? "images/vip_storage_background@3x.png"
                : "images/my_storage_background@3x.png",
            fit: BoxFit.fill,
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 24, 17.5, 14),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    "个人存储（T）",
                    style: TextStyle(
                      fontSize: 15,
                      color: this.widget.isViper == true
                          ? rgba(21, 25, 54, 1)
                          : rgba(255, 255, 255, 1),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Text(
                          "2420",
                          style: TextStyle(
                            fontSize: 30,
                            color: this.widget.isViper == true
                                ? rgba(21, 25, 54, 1)
                                : rgba(255, 255, 255, 1),
                          ),
                        ),
                        SizedBox(
                          width: this.widget.isViper == true ? 0 : 14.5,
                        ),
                        Expanded(
                          child: this.widget.isViper == true
                              ? Container()
                              : Text(
                                  "T+1340(积分)",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: rgba(255, 255, 255, 1),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (this.widget.isViper == true) {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) {
                            return CoinRollout();
                          }),
                        );
                      } else {
                        Navigator.of(context).popUntil(
                          ModalRoute.withName("/"),
                        );
                        DartNotificationCenter.post(
                            channel: kSwitchTabNotification,
                            options: {"index": 1});
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(19.5, 5.5, 13.5, 5.5),
                      decoration: BoxDecoration(
                        color: this.widget.isViper
                            ? rgba(21, 25, 54, 1)
                            : rgba(59, 121, 255, 1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: <Widget>[
                          Text(
                            this.widget.isViper == true ? "转出" : "继续购买",
                            style: TextStyle(
                              fontSize: 15,
                              color: this.widget.isViper
                                  ? rgba(243, 205, 116, 1)
                                  : rgba(255, 255, 255, 1),
                            ),
                          ),
                          SizedBox(
                            width: 2.5,
                          ),
                          Image.asset(
                            "images/right_arrow@3x.png",
                            width: 18,
                            fit: BoxFit.fitWidth,
                            color: this.widget.isViper
                                ? rgba(243, 205, 116, 1)
                                : rgba(255, 255, 255, 1),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 33.5,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(19, 0, 19, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _performances.map(
                    (performance) {
                      return Column(
                        children: <Widget>[
                          performance.length > 0
                              ? Text(
                                  "0",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: this.widget.isViper == true
                                        ? rgba(21, 25, 54, 1)
                                        : rgba(255, 255, 255, 1),
                                  ),
                                )
                              : Container(),
                          SizedBox(
                            height: 7.5,
                          ),
                          Text(
                            performance,
                            style: TextStyle(
                              fontSize: 13,
                              color: this.widget.isViper == true
                                  ? rgba(21, 25, 54, 1)
                                  : rgba(255, 255, 255, 1),
                            ),
                          ),
                        ],
                      );
                    },
                  ).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
