import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

class StoreJoinComplete extends StatefulWidget {
  StoreJoinComplete({Key key}) : super(key: key);

  @override
  _StoreJoinCompleteState createState() => _StoreJoinCompleteState();
}

class _StoreJoinCompleteState extends State<StoreJoinComplete> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rgba(255, 255, 255, 1),
      appBar: customAppBar(
        title: "申请成功",
        defaultBack: true,
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
                "申请成功！等待审核通过",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: rgba(50, 50, 50, 1),
                ),
              ),
            ),
            SizedBox(
              height: 36,
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
