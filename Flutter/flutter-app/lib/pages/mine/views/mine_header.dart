import 'package:cached_network_image/cached_network_image.dart';
import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/material.dart';
import '../mine_homepage.dart';
import '../../../public/public.dart';
import '../../setting/setting_page.dart';
import '../../wallet/wallet_page.dart';
import '../views/homepage/upgrade_alert.dart';
import '../mine_info_page.dart';
import '../contact_list.dart';
import '../certification.dart';
import '../../gift/gift_page.dart';

class MineHeader extends StatefulWidget {
  MineHeader({Key key}) : super(key: key);

  @override
  _MineHeaderState createState() => _MineHeaderState();
}

class _MineHeaderState extends State<MineHeader> {
  // 列表 个人资料、联系方式、视频认证、礼物
  List<String> _itemList = [
    "个人资料",
    "联系方式",
    "视频认证",
    "礼物",
  ];
  List<String> _itemIconList = [
    "images/personal_info@3x.png",
    "images/contact_list@3x.png",
    "images/renzheng@3x.png",
    "images/setting_gift.png",
  ];

  //列表点击
  void _itemTap(index) {
    if (index == 0) {
      this._personalInfo();
    } else if (index == 1) {
      this._contactList();
    } else if (index == 2) {
      this._certification();
    } else if (index == 3) {
      this._goGiftPage();
    }
  }

  Map _account = {};
  //获取用户信息
  void _refreshAccount() {
    setState(() {
      _account = currentAccount;
    });
  }

  //设置
  void _goSetting() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return SettingPage();
      }),
    );
  }

  //会员中心
  void _showMemberCenter() {
    UpgradeAlert().show(context);
  }

  //钱包
  void _goWallet() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return WalletPage();
      }),
    );
  }

  //个人资料
  void _personalInfo() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return MineInfoPage();
      }),
    );
  }

  //联系方式
  void _contactList() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return ContactListPage(
          account: _account,
        );
      }),
    );
  }

  //视频认证
  void _certification() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return CertificationPage();
      }),
    );
  }

  //礼物
  void _goGiftPage() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return GiftPage();
      }),
    );
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
    return Column(
      children: [
        Stack(
          children: <Widget>[
            Image.asset(
              "images/Oval 7@3x.png",
              width: MediaQuery.of(context).size.width,
              height: (MediaQuery.of(context).size.width * 329.5 / 375) +
                  MediaQuery.of(context).padding.top, //375/285
              fit: BoxFit.fitHeight,
            ),
            Center(
              child: Container(
                width: 250,
                height: (MediaQuery.of(context).size.width * 329.5 / 375) +
                    MediaQuery.of(context).padding.top, //375/285
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 85 + MediaQuery.of(context).padding.top,
                    ),
                    Stack(
                      children: <Widget>[
                        //头像
                        ClipRRect(
                          child: CachedNetworkImage(
                            placeholder: (context, url) {
                              return Image.asset(
                                "images/placeholder_mini@3x.png",
                                width: 102,
                                height: 102,
                                fit: BoxFit.cover,
                              );
                            },
                            imageUrl: _account["avatar"] != null
                                ? _account["avatar"]
                                : "",
                            width: 102,
                            height: 102,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(102 / 2),
                        ),
                        //认证
                        Positioned(
                          bottom: 0,
                          right: 10,
                          child: (_account != null &&
                                  _account["audit_status"] == 3)
                              ? Image.asset(
                                  "images/renzheng_icon@3x.png",
                                  width: 16,
                                  height: 16,
                                )
                              : Container(),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 18.5,
                    ),
                    //昵称
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: 200,
                          ),
                          child: Text(
                            _account["nickname"] != null
                                ? _account["nickname"]
                                : "用户名",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 19,
                              color: rgba(51, 51, 51, 1),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: (_account != null && _account["vip_type"] == 1)
                              ? 5
                              : 0,
                        ),
                        //是否会员
                        (_account != null && _account["vip_type"] == 1)
                            ? Image.asset(
                                "images/member@3x.png",
                                width: 16,
                                height: 16,
                              )
                            : Container()
                      ],
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    //个人资料
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) {
                            return MineHomePage();
                          }),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "查看个人主页",
                            style: TextStyle(
                              fontSize: 14,
                              color: rgba(144, 144, 144, 1),
                            ),
                          ),
                          SizedBox(
                            width: 5.5,
                          ),
                          Image.asset(
                            "images/Shape@3x.png",
                            width: 8,
                            height: 12,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 57.5,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 16,
              top: 51,
              width: 44,
              height: 44,
              child: FlatButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  this._goSetting();
                },
                child: Image.asset(
                  "images/icon_mine_setup@3x.png",
                  width: 19,
                  height: 18,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(44 / 2),
                ),
              ),
            ),
          ],
        ),
        // 会员中心、钱包
        Container(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
            bottom: 13,
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        rgba(61, 228, 200, 1),
                        rgba(0, 158, 221, 1),
                      ],
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: FlatButton(
                    padding: EdgeInsets.only(
                      left: 14.5,
                      right: 12.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    onPressed: () {
                      this._showMemberCenter();
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "会员中心",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: rgba(255, 255, 255, 1),
                                ),
                              ),
                              Text(
                                "VIP享受超值权限",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: rgba(255, 255, 255, 1),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Image.asset(
                          "images/icon_mine_member@3x.png",
                          width: 36,
                          height: 28.5,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        rgba(255, 170, 0, 1),
                        rgba(255, 170, 0, 1),
                        rgba(255, 216, 0, 1)
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: FlatButton(
                    padding: EdgeInsets.only(
                      left: 14.5,
                      right: 12.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    onPressed: () {
                      this._goWallet();
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "钱包",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: rgba(255, 255, 255, 1),
                                ),
                              ),
                              Text(
                                "余额：${_account['number_of_balance']} 币",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: rgba(255, 255, 255, 1),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Image.asset(
                          "images/icon_mine_wallet@3x.png",
                          width: 36,
                          height: 28.5,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // 个人资料、联系方式、视频认证、礼物
        Container(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
            bottom: 10,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: rgba(255, 255, 255, 1),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: rgba(0, 0, 0, 0.06),
                  offset: Offset(0, 2),
                  blurRadius: 8,
                ),
              ],
            ),
            padding: EdgeInsets.only(
              top: 16,
              bottom: 12,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _itemList.map(
                (item) {
                  var index = _itemList.indexOf(item);
                  return InkWell(
                    onTap: () {
                      this._itemTap(index);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          _itemIconList[index],
                          width: 32.5,
                          height: 32,
                        ),
                        SizedBox(
                          height: 6.5,
                        ),
                        Text(
                          item,
                          style: TextStyle(
                            color: rgba(102, 102, 102, 1),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
