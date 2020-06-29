import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/material.dart';
import 'package:hksy_flutter/pages/calculate/calculatemain.dart';
import 'package:hksy_flutter/pages/coin/mycoin.dart';
import 'package:hksy_flutter/pages/invitation/invitationmain.dart';
import 'package:hksy_flutter/pages/mine/servicepage.dart';
import 'package:hksy_flutter/pages/mine/settingpage.dart';
import 'package:hksy_flutter/function/infosectioncell.dart';
import 'package:hksy_flutter/pages/personal/personinfo.dart';
import 'package:hksy_flutter/pages/storage/mystorage.dart';
import 'package:hksy_flutter/pages/storage/vipstorage.dart';
import 'package:hksy_flutter/public/public.dart';

class MinePage extends StatefulWidget {
  MinePage({Key key}) : super(key: key);

  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  var _coinString;
  var _inviteCode;
  var _phone;
  String _nickname = "";
  String _avater = "";

  Widget _cellIcon(String imageName) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 13.5, 0),
      child: Image.asset(
        imageName,
        width: 23,
        fit: BoxFit.fitWidth,
      ),
    );
  }

  Widget _accountInfo() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                ClipRRect(
                  child: CachedNetworkImage(
                    imageUrl: "$_avater",
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    placeholder: (context, url) {
                      return Image.asset(
                        "images/default_avatar@3x.png",
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                  borderRadius: BorderRadius.circular(80 / 2),
                ),
                SizedBox(
                  width: 14,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        _nickname != null ? _nickname : "",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          color: rgba(255, 255, 255, 1),
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: <Widget>[
                          Image.asset(
                            "images/renzheng@3x.png",
                            width: 12,
                            height: 14,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                            _phone != null ? TextUtil.hideNumber(_phone) : "",
                            style: TextStyle(
                              color: rgba(145, 152, 173, 1),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Image.asset(
            "images/right_arrow@3x.png",
            width: 18,
            fit: BoxFit.fitWidth,
          ),
        ],
      ),
    );
  }

  void _refreshAccount() {
    setState(() {
      _coinString = currentAcctount["coin"];
      _inviteCode = currentAcctount["invitationCode"];
      _phone = currentAcctount["phone"];
      _nickname = currentAcctount["nickname"];
      _avater = currentAcctount["avater"];
    });
  }

  @override
  void initState() {
    super.initState();

    DartNotificationCenter.subscribe(
      channel: kUpdateAccountNotification,
      observer: this,
      onNotification: (options) {
        this._refreshAccount();
      },
    );

    this._refreshAccount();
  }

  @override
  void dispose() {
    super.dispose();

    DartNotificationCenter.unsubscribe(observer: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      appBar: customAppBar(
        title: "我的",
        brightness: Brightness.dark,
        backgroundColor: kMainBackgroundColor,
        color: Colors.white,
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(12, 8, 12, 0),
        children: <Widget>[
          InfoSection(
            padding: EdgeInsets.zero,
            cells: <Widget>[
              InfoCell(
                padding: EdgeInsets.fromLTRB(20, 30, 24.5, 30),
                showLine: false,
                leftChild: _accountInfo(),
                rightChild: Container(),
                tapHandle: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return PersonInfo();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          InfoSection(
            padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
            cells: <Widget>[
              InfoCell(
                name: "我的钱包",
                icon: _cellIcon("images/ico_my_wallet@3x.png"),
                tapHandle: () {
                  if (currentAcctount["personalStatus"] == 1) {
                    walletAlert(context);
                  } else {
                    certificationAlert(context);
                  }
                },
              ),
              InfoCell(
                name: "我的存储",
                icon: _cellIcon(
                  "images/ico_my_storage@3x.png",
                ),
                tapHandle: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return MyStoragePage();
                      },
                    ),
                  );
                },
              ),
              InfoCell(
                name: "我的算力",
                icon: _cellIcon(
                  "images/ico_my_calculation@3x.png",
                ),
                tapHandle: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return CalculateMain();
                      },
                    ),
                  );
                },
              ),
              InfoCell(
                name: "我的金币",
                value: _coinString != null ? "$_coinString" + "个" : "",
                icon: _cellIcon(
                  "images/ico_my_gold@3x.png",
                ),
                tapHandle: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return MyCoinPage();
                      },
                    ),
                  );
                },
              ),
              InfoCell(
                name: "超级存储",
                icon: _cellIcon(
                  "images/ico_my_super@3x.png",
                ),
                tapHandle: () {
                  if (currentAcctount["vipminerStatus"] == 1) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return VipStoragePage();
                        },
                      ),
                    );
                  } else {
                    functionAlertView(
                      context,
                      title: "超级存储",
                      content:
                          "      你目前还不是超级存储，想成为超级存储请联系业务人员线下办理，成为我们的超级矿工则显示每日获得更多分红收益。",
                      confirm: "确认",
                    );
                  }
                },
              ),
              InfoCell(
                name: "邀请收益",
                value: _inviteCode != null ? "我的邀请码：$_inviteCode" : "",
                showLine: false,
                icon: _cellIcon(
                  "images/ico_my_gold@3x.png",
                ),
                tapHandle: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return InvitationMain();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          InfoSection(
            padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
            cells: <Widget>[
              InfoCell(
                name: "联系客服",
                icon: Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 13.5, 0),
                  child: Image.asset(
                    "images/ico_my_service@3x.png",
                    width: 23,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                tapHandle: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return ServicePage();
                      },
                    ),
                  );
                },
              ),
              InfoCell(
                name: "设置中心",
                showLine: false,
                icon: Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 13.5, 0),
                  child: Image.asset(
                    "images/ico_my_setup@3x.png",
                    width: 23,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                tapHandle: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return SettingPage();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
