import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hksy_flutter/function/account/loginregister.dart';
import 'package:hksy_flutter/public/public.dart';

class AppGuidePage extends StatefulWidget {
  AppGuidePage({Key key}) : super(key: key);

  @override
  _AppGuidePageState createState() => _AppGuidePageState();
}

class _AppGuidePageState extends State<AppGuidePage> {
  List<String> _list = [
    "images/appguide_0@3x.png",
    "images/appguide_1@3x.png",
    "images/appguide_2@3x.png",
  ];

  void _goLoginRegister() {
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
      builder: (context) {
        return LoginRegisterPage();
      },
    ), (route) => route == null);
  }

  void _goMainPage() {
    DartNotificationCenter.post(channel: kRefreshAccountNotification);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      body: Stack(
        children: <Widget>[
          transparentAppBar(),
          Swiper.children(
            children: _list.map(
              (guide) {
                int index = _list.indexOf(guide);
                return Center(
                  child: Container(
                    color: Colors.green,
                    child: Stack(
                      children: <Widget>[
                        Image.asset(
                          guide,
                          fit: BoxFit.fitWidth,
                        ),
                        Positioned(
                          right: 0,
                          bottom: 20,
                          child: index == 2
                              ? FlatButton(
                                  onPressed: () {
                                    if (isStringEmpty(userID())) {
                                      this._goLoginRegister();
                                    } else {
                                      this._goMainPage();
                                    }
                                  },
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    height: 90,
                                  ),
                                )
                              : Container(),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ).toList(),
          )
          // BannerView(
          //   _list.map(
          //     (guide) {
          //       int index = _list.indexOf(guide);
          //       return Center(
          //         child: Container(
          //           color: Colors.green,
          //           child: Stack(
          //             children: <Widget>[
          //               Image.asset(
          //                 guide,
          //                 fit: BoxFit.fitWidth,
          //               ),
          //               Positioned(
          //                 right: 0,
          //                 bottom: 20,
          //                 child: index == 2
          //                     ? FlatButton(
          //                         onPressed: () {
          //                           if (isStringEmpty(userID())) {
          //                             this._goLoginRegister();
          //                           } else {
          //                             this._goMainPage();
          //                           }
          //                         },
          //                         child: Container(
          //                           width:
          //                               MediaQuery.of(context).size.width / 3,
          //                           height: 90,
          //                         ),
          //                       )
          //                     : Container(),
          //               ),
          //             ],
          //           ),
          //         ),
          //       );
          //     },
          //   ).toList(),
          //   autoRolling: false,
          //   cycleRolling: false,
          //   log: false,
          //   indicatorBuilder: (context, _) {
          //     return Container();
          //   },
          // ),
        ],
      ),
    );
  }
}
