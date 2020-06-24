import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/material.dart';
import 'package:hksy_flutter/pages/coin/coinrollout.dart';
import 'package:hksy_flutter/pages/invitation/api/invitationapi.dart';
import 'package:hksy_flutter/public/public.dart';

class EarningHeader extends StatefulWidget {
  EarningHeader({Key key}) : super(key: key);

  @override
  _EarningHeaderState createState() => _EarningHeaderState();
}

class _EarningHeaderState extends State<EarningHeader> {
  Map _earnings;
  List<String> _performances = [
    "剩余转出额度",
    "今日收益",
    "昨日收益",
  ];

  List<String> _performanceValues = [
    "0",
    "0",
    "0",
  ];

  String _coin = "0";

  void _refreshData() {
    userID((id) {
      if (isStringEmpty(id) == false) {
        InvitationApi.getEarningsForUser(id, (data, msg) {
          if (data != null) {
            _earnings = Map.from(data);
            setState(() {
              _coin = "${_earnings["giftcoin"]}";
              _performanceValues[0] = "${_earnings["limitcoin"]}";
              _performanceValues[1] = "${_earnings["todayEarnings"]}";
              _performanceValues[2] = "${_earnings["yesterdayEarnings"]}";
            });
          } else {
            showToast(msg, context);
          }
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();

    DartNotificationCenter.subscribe(
        channel: kUpdateAccountNotification,
        observer: this,
        onNotification: (options) {
          this._refreshData();
        });

    this._refreshData();
  }

  @override
  void dispose() {
    super.dispose();

    DartNotificationCenter.unsubscribe(observer: this);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: 185,
          child: Image.asset(
            "images/my_storage_background@3x.png",
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
                    "总资产（个）",
                    style: TextStyle(
                      fontSize: 15,
                      color: rgba(255, 255, 255, 1),
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
                    child: Text(
                      _coin,
                      style: TextStyle(
                        fontSize: 30,
                        color: rgba(255, 255, 255, 1),
                      ),
                    ),
                  ),
                  Container(
                    height: 32,
                    decoration: BoxDecoration(
                      color: rgba(59, 121, 255, 1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: FlatButton(
                      padding: EdgeInsets.fromLTRB(19.5, 0, 13.5, 0),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) {
                            return CoinRollout(
                              rolloutValue: double.parse(_coin),
                            );
                          }),
                        );
                      },
                      child: Row(
                        children: <Widget>[
                          Text(
                            "转出",
                            style: TextStyle(
                              fontSize: 15,
                              color: rgba(255, 255, 255, 1),
                            ),
                          ),
                          SizedBox(
                            width: 2.5,
                          ),
                          Image.asset(
                            "images/right_arrow@3x.png",
                            width: 18,
                            fit: BoxFit.fitWidth,
                            color: rgba(255, 255, 255, 1),
                          ),
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
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
                      var index = _performances.indexOf(performance);
                      return Column(
                        children: <Widget>[
                          performance.length > 0
                              ? Text(
                                  _performanceValues[index],
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: rgba(255, 255, 255, 1),
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
                              color: rgba(255, 255, 255, 1),
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
