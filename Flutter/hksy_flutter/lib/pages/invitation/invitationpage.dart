import 'package:flutter/material.dart';
import 'package:hksy_flutter/public/public.dart';

class InvitationPage extends StatefulWidget {
  bool isHome = false;
  InvitationPage({Key key, this.isHome = false}) : super(key: key);

  @override
  _InvitationPageState createState() => _InvitationPageState();
}

class _InvitationPageState extends State<InvitationPage> {
  Widget _baseWidget() {
    return Stack(
      children: <Widget>[
        Positioned(
          left: 0,
          bottom: 0,
          right: 0,
          child: Container(
            color: Colors.white,
            child: Stack(
              children: <Widget>[
                Image.asset(
                  "images/invite_illustrations@3x.png",
                  fit: BoxFit.cover,
                ),
                Positioned(
                  left: 0,
                  bottom: 0,
                  right: 0,
                  child: Container(
                    color: rgba(28, 35, 63, 1),
                    padding: EdgeInsets.fromLTRB(
                        12, 26, 12, 26 + MediaQuery.of(context).padding.bottom),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "邀请链接：",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: rgba(255, 255, 255, 1),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "http://www.beefil.com:808",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: rgba(145, 152, 173, 1),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 5.5, 10, 5.5),
                          child: Text(
                            "复制链接",
                            style: TextStyle(
                              fontSize: 15,
                              color: rgba(255, 255, 255, 1),
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: rgba(23, 96, 255, 1),
                            borderRadius: BorderRadius.circular(7.5),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 0,
          top: 0,
          right: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              this.widget.isHome
                  ? SizedBox(
                      height: 87.5,
                    )
                  : SizedBox(
                      height: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? 42
                          : 0,
                    ),
              Container(
                padding: EdgeInsets.fromLTRB(40, 50, 40, 15),
                decoration: BoxDecoration(
                  color: rgba(23, 96, 255, 1),
                  borderRadius: BorderRadius.circular(7.5),
                ),
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      "images/d338faf30fad24a78319ccfcf3c4238.png",
                      width: 180,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        "保存二维码",
                        style: TextStyle(
                          fontSize: 15,
                          color: rgba(255, 255, 255, 1),
                          decorationColor: rgba(255, 255, 255, 1),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 26.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "您的专属邀请码:",
                    style: TextStyle(
                      fontSize: 15,
                      color: rgba(255, 255, 255, 1),
                    ),
                  ),
                  SizedBox(
                    width: 43.5,
                  ),
                  Text(
                    "ct8g",
                    style: TextStyle(
                      fontSize: 23,
                      color: rgba(23, 96, 255, 1),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return this.widget.isHome
        ? Scaffold(
            backgroundColor: kMainBackgroundColor,
            appBar: customAppBar(
              title: "邀请好友",
              brightness: Brightness.dark,
              backgroundColor: kMainBackgroundColor,
              color: Colors.white,
            ),
            body: _baseWidget(),
          )
        : _baseWidget();
  }
}
