import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/material.dart';
import 'package:ideaclass/pages/account/api/accountapi.dart';
import 'package:ideaclass/pages/mine/settingpage.dart';
import 'package:ideaclass/public/public.dart';

class MineHeader extends StatefulWidget {
  MineHeader({Key key}) : super(key: key);

  @override
  _MineHeaderState createState() => _MineHeaderState();
}

class _MineHeaderState extends State<MineHeader> {
  List<Widget> _itemList() {
    return ["积分", "等级", "足迹"].map((value) {
      String _fetchValue() {
        String itemValue = "0";
        if (value == "积分" && _account["integral"] != null) {
          itemValue = "${_account["integral"]}";
        } else if (value == "等级" && _account["userLevel"] != null) {
          itemValue = "${_account["userLevel"]}";
        }

        return itemValue;
      }

      return buttonWidget(
        Container(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                _fetchValue(),
                style: TextStyle(fontSize: 21, color: rgba(24, 159, 251, 1)),
              ),
              Text(
                value,
                style: TextStyle(fontSize: 13, color: rgba(23, 23, 23, 1)),
              )
            ],
          ),
        ),
        context,
        onTap: () {
          kLog("$value");
        },
      );
    }).toList();
  }

  void _portraitTap() {
    kLog("portraitTap");
  }

  void _messageTap() {
    kLog("messageTap");
  }

  void _settingTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return SettingPage();
        },
      ),
    );
  }

  Map _account = {};
  void _refreshAccount() {
    AccountApi().loadLocalAccount(
      (user) {
        setState(
          () {
            _account = user;
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    this._refreshAccount();
    DartNotificationCenter.subscribe(
      channel: kRefreshAccountNotification,
      observer: this,
      onNotification: (options) {
        this._refreshAccount();
      },
    );
  }

  @override
  void dispose() {
    DartNotificationCenter.unsubscribe(
        observer: this, channel: kRefreshAccountNotification);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: rgba(42, 143, 246, 1),
      child: Column(
        children: <Widget>[
          Container(
            height: 137 + MediaQuery.of(context).padding.top,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  top: MediaQuery.of(context).padding.top + 6,
                  child: Column(
                    children: <Widget>[
                      buttonWidget(
                        _account["avatar"] == null
                            ? Image.asset(
                                "images/user_head_default@3x.png",
                                width: 64,
                                height: 64,
                              )
                            : radiusNetworkImage(
                                _account["avatar"],
                                64,
                                64,
                                placeholder: "images/user_head_default@3x.png",
                                radius: BorderRadius.circular(32),
                              ),
                        context,
                        onTap: () {
                          this._portraitTap();
                        },
                        radius: BorderRadius.circular(32),
                      ),
                      SizedBox(height: 14),
                      buttonWidget(
                        Text(
                          _account.length > 0
                              ? (isStringEmpty("${_account["nickname"]}") ==
                                      false)
                                  ? _account["nickname"]
                                  : "登录/注册"
                              : "登录/注册",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        context,
                        onTap: () {
                          this._portraitTap();
                        },
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).padding.top + 10,
                  right: 21,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 18, 0),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              width: 35,
                              alignment: Alignment.centerLeft,
                              child: buttonWidget(
                                Image.asset(
                                  "images/wode-xiaoxi@3x.png",
                                  width: 30,
                                  height: 28,
                                ),
                                context,
                                onTap: () {
                                  this._messageTap();
                                },
                              ),
                            ),
                            (_account["unread"] != null &&
                                    int.parse("${_account["unread"]}") > 0)
                                ? Positioned(
                                    top: 0,
                                    right: 0,
                                    child: Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                      buttonWidget(
                        Image.asset(
                          "images/wode-shezhi@3x.png",
                          width: 30,
                          height: 28,
                        ),
                        context,
                        onTap: () {
                          this._settingTap();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Stack(
            children: <Widget>[
              Image.asset(
                "images/MyPageWare@3x.png",
              ),
              Positioned(
                left: 0,
                bottom: 0,
                right: 0,
                height: 62,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: _itemList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
