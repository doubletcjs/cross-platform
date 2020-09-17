import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

class CreateComplete extends StatelessWidget {
  const CreateComplete({Key key}) : super(key: key);

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
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 30.5,
            ),
            Container(
              width: 127,
              height: 127,
              decoration: BoxDecoration(
                color: rgba(247, 246, 245, 1),
                borderRadius: BorderRadius.circular(127 / 2),
              ),
            ),
            SizedBox(
              height: 28,
            ),
            Container(
              constraints: BoxConstraints(
                maxWidth: 226,
              ),
              child: Text(
                "创建成功！等待审核，届时会有专人联系，请留意接听电话!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: rgba(50, 50, 50, 1),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              decoration: BoxDecoration(
                color: rgba(235, 102, 91, 1),
                borderRadius: BorderRadius.circular(4),
              ),
              width: 109,
              height: 35,
              child: FlatButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  Navigator.of(context).popUntil(
                    ModalRoute.withName("/"),
                  );
                },
                child: Text(
                  "返回首页",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: rgba(255, 255, 255, 1),
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
