import 'package:flutter/material.dart';
import 'package:hksy_flutter/public/public.dart';

class CalculateCycle extends StatefulWidget {
  CalculateCycle({Key key}) : super(key: key);

  @override
  _CalculateCycleState createState() => _CalculateCycleState();
}

class _CalculateCycleState extends State<CalculateCycle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 19.5, 20, 30.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "释放周期",
            style: TextStyle(
              color: rgba(255, 255, 255, 1),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 21.5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "已释放",
                style: TextStyle(
                  color: rgba(145, 152, 173, 1),
                  fontSize: 15,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "63%",
                style: TextStyle(
                  color: rgba(23, 96, 255, 1),
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: rgba(28, 35, 63, 1),
        borderRadius: BorderRadius.circular(7.5),
      ),
    );
  }
}
