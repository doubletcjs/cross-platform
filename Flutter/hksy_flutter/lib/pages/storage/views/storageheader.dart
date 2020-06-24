import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/material.dart';
import 'package:hksy_flutter/pages/coin/coinrollout.dart';
import 'package:hksy_flutter/pages/storage/api/storageapi.dart';
import 'package:hksy_flutter/public/public.dart';

class StorageHeader extends StatefulWidget {
  bool isViper = false;
  StorageHeader({
    Key key,
    this.isViper = false,
  }) : super(key: key);

  @override
  _StorageHeaderState createState() => _StorageHeaderState();
}

class _StorageHeaderState extends State<StorageHeader> {
  List<String> _performanceItems = [
    "前日业绩",
    "昨日业绩",
    "累计业绩",
  ];

  List<String> _performanceValues = [
    "0",
    "0",
    "0",
  ];

  String _storage = "0";
  String _hkcstorage = "0";

  @override
  void initState() {
    super.initState();

    if (this.widget.isViper) {
      _performanceItems = ["剩余转出额度", "昨日分红", ""];
    }

    if (this.widget.isViper == false) {
      userID((id) {
        if (isStringEmpty(id) == false) {
          StorageApi.getPerformanceDatas(id, (data, msg) {
            if (data != null) {
              var _performance = Map.from(data);
              setState(() {
                _performanceValues[0] =
                    "${_performance["before_yesterday_performance"]}";
                _performanceValues[0] = isStringEmpty(_performanceValues[0])
                    ? "0"
                    : _performanceValues[0];

                _performanceValues[1] =
                    "${_performance["yesterday_performance"]}";
                _performanceValues[1] = isStringEmpty(_performanceValues[1])
                    ? "0"
                    : _performanceValues[1];

                _performanceValues[2] = "${_performance["expericence"]}";
                _performanceValues[2] = isStringEmpty(_performanceValues[2])
                    ? "0"
                    : _performanceValues[2];

                _storage = "${_performance["storage"]}";
                _storage = isStringEmpty(_storage) ? "0" : _storage;

                _hkcstorage = "${_performance["hkcstorage"]}";
                _hkcstorage = isStringEmpty(_hkcstorage) ? "0" : _hkcstorage;
              });
            } else {
              showToast(msg, context);
            }
          });
        }
      });
    } else {
      DartNotificationCenter.subscribe(
          channel: "getPerformanceDatas",
          observer: this,
          onNotification: (options) {
            var _performance = Map.from(options);
            setState(() {
              _storage = "${_performance["totalCoin"]}";
              _storage = isStringEmpty(_storage) ? "0" : _storage;

              _performanceValues[0] = "${_performance["limitCoin"]}";
              _performanceValues[0] = isStringEmpty(_performanceValues[0])
                  ? "0"
                  : _performanceValues[0];

              _performanceValues[1] = "${_performance["yesterdayEarnings"]}";
              _performanceValues[1] = isStringEmpty(_performanceValues[1])
                  ? "0"
                  : _performanceValues[1];
            });
          });
    }
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
                          _storage,
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
                                  "T+$_hkcstorage(积分)",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: rgba(255, 255, 255, 1),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 32,
                    decoration: BoxDecoration(
                      color: this.widget.isViper
                          ? rgba(21, 25, 54, 1)
                          : rgba(59, 121, 255, 1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: FlatButton(
                      padding: EdgeInsets.fromLTRB(19.5, 0, 13.5, 0),
                      onPressed: () {
                        if (this.widget.isViper == true) {
                          var totalCoin =
                              double.parse(_storage).toStringAsFixed(2); // 总资产
                          var limitCoin = double.parse(_performanceValues[0])
                              .toStringAsFixed(2); // 剩余转出额度
                          // 那一个值小，就传那一个值过去

                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) {
                              return CoinRollout(
                                isViper: this.widget.isViper,
                                rolloutValue: double.parse(totalCoin) >
                                        double.parse(limitCoin)
                                    ? double.parse(limitCoin)
                                    : double.parse(totalCoin),
                              );
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
                  children: _performanceItems.map(
                    (performance) {
                      var index = _performanceItems.indexOf(performance);
                      return Column(
                        children: <Widget>[
                          performance.length > 0
                              ? Text(
                                  _performanceValues[index],
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
