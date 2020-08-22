import 'dart:convert';

import 'package:common_utils/common_utils.dart';
import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/material.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';
import 'package:yue_mei/pages/mine/views/homepage/gifts_dialog.dart';
import '../chat/chat_main_page.dart';
import '../../public/public.dart';
import 'views/homepage/cover_header.dart';
import 'views/homepage/info_content.dart';
import 'views/homepage/info_header.dart';
import 'views/homepage/member_alert.dart';
import 'views/homepage/report_alert.dart';
import 'mine_info_page.dart';
import '../account/api/account_api.dart';
import 'mine_contact.dart';
import 'api/member_api.dart';
import '../account/report_account.dart';
import '../function/general_alert.dart';
import '../function/base_video_player.dart';
import 'views/homepage/gifts_dialog.dart' show GiftsDialog;

class MineHomePage extends StatefulWidget {
  String userId = ""; //是否查看本人主页
  MineHomePage({
    Key key,
    this.userId = "",
  }) : super(key: key);

  @override
  _MineHomePageState createState() => _MineHomePageState();
}

class _MineHomePageState extends State<MineHomePage> {
  //点赞
  void _likeAction() {
    if (_account != null) {
      if (_account["is_love"] != 1) {
        //喜欢
        XsProgressHud.show(context);
        MemberApi.addLove(_account["id"], (data, msg) {
          if (data != null) {
            setState(() {
              _account["is_love"] = 1;
            });

            Future.delayed(Duration(milliseconds: 300), () {
              XsProgressHud.hide();
            });
          } else {
            XsProgressHud.hide();
            showToast(msg, context);
          }
        });
      } else {
        XsProgressHud.show(context);
        MemberApi.deleteLove(
            JsonDecoder().convert(JsonEncoder().convert([_account["id"]])),
            (data, msg) {
          if (data != null) {
            setState(() {
              _account["is_love"] = 2;
            });

            Future.delayed(Duration(milliseconds: 300), () {
              XsProgressHud.hide();
            });
          } else {
            XsProgressHud.hide();
            showToast(msg, context);
          }
        });
      }
    }
  }

  //聊天
  void _goChart() {
    //男会员只提示开通会员
    if (_loginAccount["sex"] == 1) {
      if (_loginAccount["vip_type"] == 1) {
        //聊天
        if (ObjectUtil.isEmpty(_account["id"]) == false) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return ChatMainPage(
                sessionId: "${_account["id"]}",
              );
            }),
          );
        } else {
          showToast("用户id不能为空！", context);
        }
      } else {
        MemberAlert(
          manCustom: true,
        ).show(context);
      }
    } else {
      //是否开通会员或已认证
      if (_loginAccount["vip_type"] == 1 ||
          _loginAccount["audit_status"] == 3) {
        //聊天
        if (ObjectUtil.isEmpty(_account["id"]) == false) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return ChatMainPage(
                sessionId: "${_account["id"]}",
              );
            }),
          );
        } else {
          showToast("用户id不能为空！", context);
        }
      } else {
        MemberAlert().show(context);
      }
    }
  }

  //编辑用户信息
  void _editInfo() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return MineInfoPage();
      }),
    );
  }

  //拉黑
  void _shieldSaveAction() {
    if (_account != null) {
      if (_account["is_shield"] != 1) {
        //拉黑
        XsProgressHud.show(context);
        MemberApi.shieldSave(_account["id"], (data, msg) {
          if (data != null) {
            setState(() {
              _account["is_shield"] = 1;
            });

            Future.delayed(Duration(milliseconds: 300), () {
              XsProgressHud.hide();
            });
          } else {
            XsProgressHud.hide();
            showToast(msg, context);
          }
        });
      } else {
        XsProgressHud.show(context);
        MemberApi.shieldDelete(_account["id"], (data, msg) {
          if (data != null) {
            setState(() {
              _account["is_shield"] = 2;
            });

            Future.delayed(Duration(milliseconds: 300), () {
              XsProgressHud.hide();
            });
          } else {
            XsProgressHud.hide();
            showToast(msg, context);
          }
        });
      }
    }
  }

  //举报
  void _reportAction() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return ReportAccount(
          account: _account,
          reportHandle: () {
            setState(() {
              _account["is_report"] = 1;
            });
          },
        );
      }),
    );
  }

  //更多
  void _moreAction() {
    ReportAlert(
      itemHandle: (item) {
        Future.delayed(Duration(milliseconds: 300), () {
          if (item == "拉黑" || item == "移出黑名单") {
            this._shieldSaveAction();
          } else if (item == "举报") {
            this._reportAction();
          }
        });
      },
      reportItems: [
        (_account != null && _account["is_report"] == 1) ? "已举报" : "举报",
        (_account != null && _account["is_shield"] == 1) ? "移出黑名单" : "拉黑",
        "取消",
      ],
    ).show(context);
  }

  //查看联系方式
  void _showContact() {
    GeneralAlert(
      title: "提示",
      content: "查看联系方式要7金币",
      cancel: "不看了",
      confirm: "联系方式",
      confirmHandle: () {
        Future.delayed(Duration(milliseconds: 400), () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return MineContact(
                account: _account,
              );
            }),
          );
        });
      },
    ).show(context);
  }

  //查看视频
  void _showCertificationVideo() {
    GeneralAlert(
      title: "提示",
      content: "查看视频需要花费5金币",
      cancel: "不看了",
      confirm: "查看视频",
      confirmHandle: () {
        Future.delayed(Duration(milliseconds: 400), () {
          BaseVideoPlayer(
            account: _account,
          ).animatedPush(context);
        });
      },
    ).show(context);
  }

  //获取用户信息
  Map _account; //用户信息
  Map _loginAccount; //当前登录用户信息
  void _refreshOtherAccount() {
    XsProgressHud.show(context);
    AccountApi.otherProfile(this.widget.userId, (data, msg) {
      XsProgressHud.hide();
      if (data != null) {
        setState(() {
          _account = Map.from(data);
        });
      } else {
        showToast(msg, context);
      }
    });
  }

  void _refreshAccount() {
    setState(() {
      if (ObjectUtil.isEmptyString(this.widget.userId) == true) {
        _account = null;
        Future.delayed(Duration(milliseconds: 300), () {
          setState(() {
            _account = currentAccount;
          });
        });
      } else {
        _loginAccount = currentAccount;
      }
    });
  }

  @override
  void initState() {
    super.initState();

    if (ObjectUtil.isEmptyString(this.widget.userId) == true) {
      setState(() {
        _account = currentAccount;
      });
      kLog("当前登录用户信息");
    } else {
      setState(() {
        _loginAccount = currentAccount;
      });

      Future.delayed(Duration(milliseconds: 300), () {
        this._refreshOtherAccount();
      });
    }

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
      body: Stack(
        children: <Widget>[
          transparentAppBar(),
          ListView(
            padding: EdgeInsets.fromLTRB(
                0,
                0,
                0,
                ObjectUtil.isEmptyString(this.widget.userId) == true
                    ? 0
                    : (94 + MediaQuery.of(context).padding.bottom)),
            children: <Widget>[
              //封面
              _account == null
                  ? Container()
                  : CoverHeader(
                      isSelf: ObjectUtil.isEmptyString(this.widget.userId),
                      account: _account,
                      certificationHandle: () {
                        this._showCertificationVideo();
                      },
                    ),
              //账户信息
              _account == null
                  ? Container()
                  : InfoHeader(
                      isSelf: ObjectUtil.isEmptyString(this.widget.userId),
                      account: _account,
                      contactHandle: () {
                        this._showContact();
                      },
                    ),
              //用户信息
              _account == null
                  ? Container()
                  : InfoContent(
                      account: _account,
                    ),
              // 收到的礼物
//              _account == null
//                  ? Container()
//                  : ReceivedGifts(
//                    account: _account,
//                  ),
            ],
          ),
          //返回按钮
          Positioned(
            top: MediaQuery.of(context).padding.top,
            child: Container(
              width: AppBar().preferredSize.height,
              height: AppBar().preferredSize.height,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(AppBar().preferredSize.height / 2),
              ),
              child: FlatButton(
                padding: EdgeInsets.zero,
                child: Image.asset(
                  "images/home_page_back@3x.png",
                  width: 29,
                  height: 29,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(AppBar().preferredSize.height / 2),
                ),
              ),
            ),
          ),
          //更多按钮（本人编辑按钮）
          ObjectUtil.isEmptyString(this.widget.userId)
              ? Positioned(
                  top: MediaQuery.of(context).padding.top,
                  right: 15,
                  child: Container(
                    width: AppBar().preferredSize.height,
                    height: AppBar().preferredSize.height,
                    child: Center(
                      child: Container(
                        width: 54,
                        height: 27,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              rgba(255, 44, 96, 1),
                              rgba(255, 114, 81, 1)
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerLeft,
                          ),
                          borderRadius: BorderRadius.circular(27 / 2),
                        ),
                        child: FlatButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            this._editInfo();
                          },
                          child: Text(
                            "编辑",
                            style: TextStyle(
                              color: rgba(255, 255, 255, 1),
                              fontSize: 13,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(27 / 2),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : Positioned(
                  top: MediaQuery.of(context).padding.top,
                  right: 0,
                  child: Container(
                    width: AppBar().preferredSize.height,
                    height: AppBar().preferredSize.height,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          AppBar().preferredSize.height / 2),
                    ),
                    child: FlatButton(
                      padding: EdgeInsets.zero,
                      child: Image.asset(
                        "images/home_page_more@3x.png",
                        width: 29,
                        height: 29,
                      ),
                      onPressed: () {
                        this._moreAction();
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            AppBar().preferredSize.height / 2),
                      ),
                    ),
                  ),
                ),
          ObjectUtil.isEmptyString(this.widget.userId)
              ? Container()
              : Positioned(
                  left: 0,
                  right: 0,
                  bottom: MediaQuery.of(context).padding.bottom,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //喜欢 已喜欢 dianzan_sel@3x.png
                      FlatButton(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(94 / 2),
                        ),
                        child: Image.asset(
                          (_account != null && _account["is_love"] == 1)
                              ? "images/dianzan_sel@3x.png"
                              : "images/dianzan@3x.png",
                          width: 94,
                          height: 94,
                        ),
                        onPressed: () {
                          this._likeAction();
                        },
                      ),
                      //聊天
                      SizedBox(
                        width: 16,
                      ),
                      FlatButton(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(94 / 2),
                        ),
                        child: Image.asset(
                          "images/liaotian@3x.png",
                          width: 94,
                          height: 94,
                        ),
                        onPressed: () {
                          this._goChart();
                        },
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      // 送礼
                      FlatButton(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(94 / 2),
                        ),
                        child: Image.asset(
                          "images/Follow Button@3x.png",
                          width: 94,
                          height: 94,
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              child: GiftsDialog(
                                receiveUserId: _account["id"],
                                onNavigationClickEvent: () {
                                  Navigator.of(context).pop();
                                },
                              ));
                        },
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
