import 'package:cached_network_image/cached_network_image.dart';
import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/material.dart';
import '../../public/public.dart';
import '../function/spread_animation_widget.dart';
import '../function/heart_beat_widget.dart';

class NearMatchingPage extends StatefulWidget {
  NearMatchingPage({Key key}) : super(key: key);

  @override
  _NearMatchingPageState createState() => _NearMatchingPageState();
}

class _NearMatchingPageState extends State<NearMatchingPage> {
  Map _account = {};
  //获取用户信息
  void _refreshAccount() {
    setState(() {
      _account = currentAccount;
    });
  }

  @override
  void initState() {
    super.initState();

    DartNotificationCenter.subscribe(
      channel: kAccountHandleNotification,
      observer: this,
      onNotification: (option) {
        //type 0 登录 1 请求账号信息刷新 2 登出 3 请求账号信息结束，刷新本地记录用户信息
        if (option["type"] == 3) {
          this._refreshAccount();
        }
      },
    );

    setState(() {
      _account = currentAccount;
    });
  }

  @override
  void dispose() {
    super.dispose();

    DartNotificationCenter.unsubscribe(observer: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              rgba(59, 48, 220, 1),
              rgba(193, 50, 148, 1),
              rgba(255, 132, 96, 1),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Stack(
          children: [
            transparentAppBar(),
            Center(
              child: SpreadAnimationWidget(
                radius: 112,
                maxRadius: 375,
                duration: Duration(milliseconds: 3600),
                spreadColor: rgba(255, 255, 255, 0.3),
              ),
            ),
            Center(
              child: Container(
                width: 112,
                height: 112,
                decoration: BoxDecoration(
                  color: rgba(255, 255, 255, 1),
                  borderRadius: BorderRadius.circular(112 / 2),
                  border: Border.all(
                    color: rgba(255, 255, 255, 1),
                    width: 2,
                  ),
                ),
                //头像
                child: ClipRRect(
                  child: CachedNetworkImage(
                    placeholder: (context, url) {
                      return Image.asset(
                        "images/placeholder_mini@3x.png",
                        width: 102,
                        height: 102,
                        fit: BoxFit.cover,
                      );
                    },
                    imageUrl:
                        _account["avatar"] != null ? _account["avatar"] : "",
                    width: 112,
                    height: 112,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(112 / 2),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 2 + 112 / 2 + 92,
              left: 44,
              right: 44,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "匹配中",
                    style: TextStyle(
                      color: rgba(255, 255, 255, 1),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "12人在等待，预计等待1分钟",
                    style: TextStyle(
                      color: rgba(255, 255, 255, 1),
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 75,
              top: MediaQuery.of(context).size.height / 2 + 9,
              child: HeartBeatWidget(
                radius: 25.0,
                minRadius: 25.0 - 4.5,
              ),
            ),
            Positioned(
              right: 83,
              top: MediaQuery.of(context).size.height / 2 - 58.5 - 112 / 2,
              child: HeartBeatWidget(
                radius: 17.0,
                minRadius: 17.0 - 4.5,
              ),
            ),
            Positioned(
              right: 50.5,
              top: MediaQuery.of(context).size.height / 2 + 112 / 2 + 52.5,
              child: HeartBeatWidget(
                radius: 13.5,
                minRadius: 13.5 - 4.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
