import 'package:flutter/material.dart';
import 'package:hksy_flutter/public/public.dart';

class CoinHeader extends StatelessWidget {
  const CoinHeader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> _functions = [
      "提现",
      "充值",
      "互转",
    ];
    List<String> _images = [
      "images/ico_mygold_list_cashout@3x.png",
      "images/ico_mygold_recharge_white@3x.png",
      "images/ico_mygold_transfer_white@3x.png",
    ];

    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 113.5,
              child: Image.asset(
                "images/gold_background@3x.png",
                fit: BoxFit.fill,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(24.5, 19, 24.5, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "金币资产（个）",
                    style: TextStyle(
                      fontSize: 15,
                      color: rgba(255, 255, 255, 1),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "13420",
                    style: TextStyle(
                      fontSize: 30,
                      color: rgba(255, 255, 255, 1),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 26,
        ),
        Container(
          padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _functions.map(
              (function) {
                var index = _functions.indexOf(function);
                return InkWell(
                  highlightColor: rgba(0, 0, 0, 0),
                  splashColor: rgba(0, 0, 0, 0),
                  onTap: () {
                    kLog(index);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        _images[index],
                        width: 23,
                        fit: BoxFit.fitWidth,
                      ),
                      SizedBox(
                        width: 11,
                      ),
                      Text(
                        function,
                        style: TextStyle(
                          fontSize: 15,
                          color: rgba(255, 255, 255, 1),
                        ),
                      ),
                      SizedBox(
                        width: 27.5,
                      ),
                      index < _functions.length - 1
                          ? Container(
                              height: 23,
                              width: 1,
                              color: rgba(255, 255, 255, 0.2),
                            )
                          : Container(),
                    ],
                  ),
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }
}
