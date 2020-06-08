import 'package:flutter/material.dart';
import 'package:hksy_flutter/pages/coin/coinrollout.dart';
import 'package:hksy_flutter/public/public.dart';

class EarningHeader extends StatefulWidget {
  EarningHeader({Key key}) : super(key: key);

  @override
  _EarningHeaderState createState() => _EarningHeaderState();
}

class _EarningHeaderState extends State<EarningHeader> {
  List<String> _performances = [
    "剩余转出额度",
    "今日收益",
    "昨日收益",
  ];

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
                      "2420",
                      style: TextStyle(
                        fontSize: 30,
                        color: rgba(255, 255, 255, 1),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) {
                          return CoinRollout();
                        }),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(19.5, 5.5, 13.5, 5.5),
                      decoration: BoxDecoration(
                        color: rgba(59, 121, 255, 1),
                        borderRadius: BorderRadius.circular(16),
                      ),
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
