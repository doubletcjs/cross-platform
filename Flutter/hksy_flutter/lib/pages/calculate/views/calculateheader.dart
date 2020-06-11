import 'package:flutter/material.dart';
import 'package:hksy_flutter/pages/calculate/calculateconfirm.dart';
import 'package:hksy_flutter/pages/coin/cointransfer.dart';
import 'package:hksy_flutter/pages/coin/transfercomplete.dart';
import 'package:hksy_flutter/public/public.dart';

class CalculateHeader extends StatefulWidget {
  CalculateHeader({Key key}) : super(key: key);

  @override
  _CalculateHeaderState createState() => _CalculateHeaderState();
}

class _CalculateHeaderState extends State<CalculateHeader> {
  List<String> _list = [
    "HKC互转",
    "HKC兑换",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 27, 0, 35),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Center(
                child: Container(
                  width: 137,
                  height: 137,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(137 / 2),
                    border: Border.all(
                      width: 6.5,
                      color: rgba(23, 96, 255, 1),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 27,
                right: 0,
                bottom: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "342580.48",
                      style: TextStyle(
                        color: rgba(255, 255, 255, 1),
                        fontSize: 23,
                      ),
                    ),
                    SizedBox(
                      height: 9.5,
                    ),
                    Text(
                      "HKC",
                      style: TextStyle(
                        color: rgba(255, 255, 255, 1),
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 19.5,
          ),
          Text(
            "当前算力不足10T，无法享受HKC收益",
            style: TextStyle(
              color: rgba(145, 152, 173, 1),
              fontSize: 11,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: _list.map((item) {
              int index = _list.indexOf(item);
              return Expanded(
                child: Container(
                  height: 44,
                  decoration: BoxDecoration(
                    color: index == 0
                        ? rgba(140, 97, 255, 1)
                        : rgba(23, 96, 255, 1),
                    borderRadius: index == 0
                        ? BorderRadius.only(
                            topLeft: Radius.circular(7.5),
                            bottomLeft: Radius.circular(7.5),
                          )
                        : BorderRadius.only(
                            topRight: Radius.circular(7.5),
                            bottomRight: Radius.circular(7.5),
                          ),
                  ),
                  child: FlatButton(
                    onPressed: () {
                      if (index == 0) {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) {
                            return CoinTransfer(
                              isHKC: true,
                            );
                          }),
                        );
                      } else {
                        CalculateConfirm(
                          confirmHandle: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return TransferComplete(
                                    completeType: 6,
                                  );
                                },
                              ),
                            );
                          },
                        ).show(context);
                      }
                    },
                    child: Text(
                      item,
                      style: TextStyle(
                        color: rgba(255, 255, 255, 1),
                        fontSize: 15,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: index == 0
                          ? BorderRadius.only(
                              topLeft: Radius.circular(7.5),
                              bottomLeft: Radius.circular(7.5),
                            )
                          : BorderRadius.only(
                              topRight: Radius.circular(7.5),
                              bottomRight: Radius.circular(7.5),
                            ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "累计已送：0HKC",
                style: TextStyle(
                  color: rgba(255, 255, 255, 1),
                  fontSize: 13,
                ),
              ),
              Text(
                "已兑换：0T",
                style: TextStyle(
                  color: rgba(255, 255, 255, 1),
                  fontSize: 13,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
