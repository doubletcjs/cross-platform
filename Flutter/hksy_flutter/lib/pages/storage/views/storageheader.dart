import 'package:flutter/material.dart';
import 'package:hksy_flutter/public/public.dart';

class StorageHeader extends StatefulWidget {
  bool isViper = false;
  StorageHeader({Key key, this.isViper = false}) : super(key: key);

  @override
  _StorageHeaderState createState() => _StorageHeaderState();
}

class _StorageHeaderState extends State<StorageHeader> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // Image.asset(
        //   "images/my_storage_background@3x.png",
        //   fit: BoxFit.cover,
        // ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 24, 17.5, 14),
          color: rgba(255, 255, 255, 0.2),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    "个人存储（T）",
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
                  Row(
                    children: <Widget>[
                      Text(
                        "31232420",
                        style: TextStyle(
                          fontSize: 30,
                          color: rgba(255, 255, 255, 1),
                        ),
                      ),
                      SizedBox(
                        width: 14.5,
                      ),
                      Text(
                        "T+12340(积分)",
                        style: TextStyle(
                          fontSize: 13,
                          color: rgba(255, 255, 255, 1),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(19.5, 5.5, 13.5, 5.5),
                    decoration: BoxDecoration(
                      color: rgba(59, 121, 255, 1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "继续购买",
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
                          color: Colors.white,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
