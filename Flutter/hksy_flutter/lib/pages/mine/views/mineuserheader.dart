import 'package:flutter/material.dart';
import 'package:hksy_flutter/public/public.dart';

class MineUserHeaeder extends StatefulWidget {
  MineUserHeaeder({Key key}) : super(key: key);

  @override
  _MineUserHeaederState createState() => _MineUserHeaederState();
}

class _MineUserHeaederState extends State<MineUserHeaeder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(12, 0, 10, 0),
      padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
      decoration: BoxDecoration(
        color: rgba(28, 35, 63, 1),
        borderRadius: BorderRadius.circular(7.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image.asset(
            "images/default_avatar@3x.png",
            width: 80,
            height: 80,
          ),
          SizedBox(
            width: 14,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "ID12347865",
                  style: TextStyle(
                    color: rgba(255, 255, 255, 1),
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: <Widget>[
                    Image.asset(
                      "images/renzheng@3x.png",
                      width: 12,
                      height: 14,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Expanded(
                      child: Text(
                        "151*****3552",
                        style: TextStyle(
                          color: rgba(145, 152, 173, 1),
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Image.asset(
            "images/right_arrow@3x.png",
            width: 20,
            fit: BoxFit.fitWidth,
          ),
        ],
      ),
    );
  }
}
