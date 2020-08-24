import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

class CreateDetail extends StatefulWidget {
  CreateDetail({Key key}) : super(key: key);

  @override
  _CreateDetailState createState() => _CreateDetailState();
}

class _CreateDetailState extends State<CreateDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rgba(255, 255, 255, 1),
      appBar: customAppBar(
        leftItems: [
          Container(
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Row(
                children: [
                  Image.asset(
                    "images/base_back@3x.png",
                    width: 11,
                    height: 20,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "返回",
                    style: TextStyle(
                      fontSize: 18,
                      color: rgba(51, 51, 51, 1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        rightItems: [
          Container(
            width: 72,
            height: 28,
            decoration: BoxDecoration(
              color: rgba(235, 102, 91, 1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: FlatButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
              child: Text(
                "完成",
                style: TextStyle(
                  fontSize: 14,
                  color: rgba(241, 241, 241, 1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
