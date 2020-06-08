import 'package:flutter/material.dart';
import 'package:hksy_flutter/public/public.dart';

class OrderComplete extends StatelessWidget {
  const OrderComplete({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      appBar: customAppBar(
        title: "购买完成",
        brightness: Brightness.dark,
        backgroundColor: kMainBackgroundColor,
        color: Colors.white,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 43,
            ),
            Image.asset(
              "images/complete@3x.png",
              width: 119,
              fit: BoxFit.fitWidth,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "购买成功",
              style: TextStyle(
                fontSize: 15,
                color: rgba(255, 255, 255, 1),
              ),
            ),
            SizedBox(
              height: 51.5,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(23, 0, 23, 0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 49,
                      decoration: BoxDecoration(
                        color: rgba(235, 237, 240, 1),
                        borderRadius: BorderRadius.circular(7.5),
                      ),
                      child: FlatButton(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.5),
                        ),
                        onPressed: () {
                          Navigator.of(context).popUntil(
                            ModalRoute.withName("/"),
                          );
                        },
                        child: Text(
                          "首页",
                          style: TextStyle(
                            fontSize: 15,
                            color: rgba(145, 152, 173, 1),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12.5,
                  ),
                  Expanded(
                    child: Container(
                      height: 49,
                      decoration: BoxDecoration(
                        color: rgba(23, 96, 255, 1),
                        borderRadius: BorderRadius.circular(7.5),
                      ),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.5),
                        ),
                        child: Text(
                          "继续购买",
                          style: TextStyle(
                            fontSize: 15,
                            color: rgba(255, 255, 255, 1),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
