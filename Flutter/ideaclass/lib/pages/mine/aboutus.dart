import 'package:flutter/material.dart';
import 'package:ideaclass/public/public.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "关于",
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(0, 0, 0, 38+MediaQuery.of(context).padding.bottom),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 135, 0, 0),
                    alignment: Alignment.center,
                    child: Image.asset(
                      "images/LOGO@3x.png",
                      width: 64,
                      height: 64,
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    "版本信息",
                    style: TextStyle(
                      fontSize: 14,
                      color: rgba(136, 136, 136, 1),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container( 
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "© 纵想课堂 inc,All Rights Reserved",
                      style: TextStyle(
                        fontSize: 14,
                        color: rgba(136, 136, 136, 1),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "纵想课堂提供技术支持",
                      style: TextStyle(
                        fontSize: 14,
                        color: rgba(136, 136, 136, 1),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "客服电话：0755-28217526",
                      style: TextStyle(
                        fontSize: 14,
                        color: rgba(136, 136, 136, 1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
