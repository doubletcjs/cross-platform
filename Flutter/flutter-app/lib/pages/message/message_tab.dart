import 'dart:io';

import 'package:common_utils/common_utils.dart';
import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tencent_im_plugin/entity/session_entity.dart';
import 'package:tencent_im_plugin/tencent_im_plugin.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';
import '../function/general_alert.dart';
import 'views/message_cell.dart';
import '../../public/public.dart';
import '../mine/views/homepage/upgrade_alert.dart';
import '../account/function_record.dart';
import '../chat/chat_main_page.dart';

class MessagePage extends StatefulWidget {
  MessagePage({Key key}) : super(key: key);

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  Map _account = {};
  //获取用户信息
  void _refreshAccount() {
    setState(() {
      _account = currentAccount;
      this._fetchUnreadCount();
    });
  }

  List<SessionEntity> _conversationList = []; //会话列表
  int _imLoginStatus = 0; //im登录状态 0 登录中 1 成功 2 失败
  //腾讯聊天生成userSig。调用原生
  /*
     通道名称： samples.flutter.dev/generate_userSig
          方法名： getUserSig
          参数名：
                  userId 腾讯im，用户id
                  appId 腾讯im，sdk appId
                  secretKey 腾讯im，密钥

   iOS Runner/GenerateUserSig 文件夹
  */
  // static const _platform = const MethodChannel("samples.flutter.dev/generate_userSig");

  //消息监听器
  void _messageListener(ListenerTypeEnum type, params) {
    print("type:" + "$type");
    print("params:" + "$params");
    // 新消息时更新会话列表最近的聊天记录
    if (type == ListenerTypeEnum.RefreshConversation ||
        type == ListenerTypeEnum.Refresh) {
      setState(() {
        for (SessionEntity item in params) {
          bool exist = false;
          for (var i = 0; i < _conversationList.length; i++) {
            if (_conversationList[i].id == item.id) {
              _conversationList[i] = item;
              exist = true;
              break;
            }
          }
          if (!exist) {
            _conversationList.add(item);
          }
        }

        this._sortConversation();
      });
    }
  }

  //检测im是否登录
  void _checkImStatus() {
    userID((userId) async {
      if (ObjectUtil.isEmptyString(userId) == false) {
        void _imLogin() async {
          //获取userSig
          String userSig = await readUserSig();
          kLog("userId:$userId");
          kLog("userSig:$userSig");
          // String userSig = await _platform.invokeMethod(
          //   "getUserSig",
          //   {
          //     "userId": userId,
          //     "appId": TENCENTIM_APPID,
          //     "secretKey": TENCENTIM_SECRETKEY,
          //   },
          // );
          kLog("登录IM");
          TencentImPlugin.login(identifier: userId, userSig: userSig)
              .then((_) async {
            if (ObjectUtil.isEmptyString(userId) == false) {
              kLog("登录成功");
              //登录成功

              setState(() {
                _imLoginStatus = 1;
                this._getConversationList();
                _refreshController.refreshCompleted();
              });
              kLog("开始上传token");
              //上传deviceToken
              if (Platform.isIOS) {
                readDeviceToken().then((value) {
                  kLog("获取token上传");
                  if (ObjectUtil.isEmpty(value) == false) {
                    kLog("上传token");
                    TencentImPlugin.setOfflinePushToken(
                      bussid: TENCENTIM_BUSSID,
                      token: value,
                    );
                  }
                });
              }

              await TencentImPlugin.initStorage(identifier: userId);
            } else {
              //登录失败
              kLog("登录失败");
              setState(() {
                _imLoginStatus = 2;
                _refreshController.refreshCompleted();
              });
            }
          }).catchError((error) {
            kLog("error:$error");
            //登录失败
            setState(() {
              _imLoginStatus = 2;
              _refreshController.refreshCompleted();
            });
          });
        }

        String imUserId = await TencentImPlugin.getLoginUser();
        if (ObjectUtil.isEmptyString(imUserId) == false) {
          // if (imUserId != userId) {
          //   await TencentImPlugin.logout();
          //   //非当前用户，注销重新登录
          //   _imLogin();
          // } else {
          //   //已登录
          //   kLog("已登录");
          //   setState(() {
          //     _imLoginStatus = 1;
          //     this._getConversationList();
          //     _refreshController.refreshCompleted();
          //   });
          //   await TencentImPlugin.initStorage(identifier: imUserId);
          // }
          await TencentImPlugin.logout();
          //非当前用户，注销重新登录
          _imLogin();
        } else {
          //未登录
          _imLogin();
        }
      } else {
        setState(() {
          _imLoginStatus = 2;
          _refreshController.refreshCompleted();
        });
      }
    });
  }

  //获取聊天会话
  void _getConversationList() {
    kLog("获取聊天会话");
    TencentImPlugin.getConversationList().then(
      (value) {
        _conversationList = List.from(value);
        this._sortConversation();
      },
    );
  }

  //聊天会话排序
  void _sortConversation() {
    _conversationList.sort(
      (i1, i2) => i1.message == null
          ? 0
          : i2.message == null
              ? -1
              : i2.message.timestamp.compareTo(i1.message.timestamp),
    );

    //不显示空昵称、空消息会话
    List<SessionEntity> _list = [];
    _conversationList.forEach((element) {
      if (ObjectUtil.isEmpty(element.userProfile) == false &&
          ObjectUtil.isEmpty(element.userProfile.nickName) == false &&
          ObjectUtil.isEmpty(element.message) == false) {
        if (_list.indexOf(element) < 0) {
          _list.add(element);
        }
      }
    });

    setState(() {
      _conversationList = _list;
      _refreshController.refreshCompleted();
      this._fetchUnreadCount();
      kLog("会话数:${_conversationList.length}");
    });
  }

  //刷新聊天会话
  void _refreshImAction() {
    if (_imLoginStatus == 1) {
      this._getConversationList();
    } else {
      setState(() {
        _imLoginStatus = 0;
        this._checkImStatus();
      });
    }
  }

  //看过我widget
  Widget _visitorWidget() {
    return MessageCell(
      padding: EdgeInsets.fromLTRB(13.5, 12.5, 14.5, 12.5),
      redCount: _account != null && _account["visitor_count"] != null
          ? _account["visitor_count"]
          : 0,
      title: "谁看过我",
      content: "看看有多少人想看你哟~",
      subContent: "",
      icon: "images/kan@3x.png",
      tapHandle: () {
        Future.delayed(Duration(milliseconds: 200), () {
          if (_account["vip_type"] == 0) {
            GeneralAlert(
              title: "解锁",
              content: "升级会员可查看【谁看过我】\n不要错过缘分哦。",
              confirm: "升级会员",
              confirmHandle: () {
                Future.delayed(Duration(milliseconds: 200), () {
                  UpgradeAlert().show(context);
                });
              },
            ).show(context);
          } else {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return FunctionRecord(
                  recordType: 1,
                );
              }),
            );
          }
        });
      },
    );
  }

  //喜欢我widget
  Widget _loveMeWidget() {
    return MessageCell(
      padding: EdgeInsets.fromLTRB(13.5, 12.5, 14.5, 12.5),
      redCount: _account != null && _account["love_count"] != null
          ? _account["love_count"]
          : 0,
      title: "谁喜欢我",
      content: "喜欢你的人有谁呢？",
      subContent: "",
      icon: "images/like@3x.png",
      tapHandle: () {
        Future.delayed(Duration(milliseconds: 200), () {
          if (_account["vip_type"] == 0) {
            GeneralAlert(
              title: "解锁",
              content: "升级会员可查看【谁喜欢我】\n不要错过缘分哦。",
              confirm: "升级会员",
              confirmHandle: () {
                Future.delayed(Duration(milliseconds: 200), () {
                  UpgradeAlert().show(context);
                });
              },
            ).show(context);
          } else {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return FunctionRecord(
                  recordType: 0,
                );
              }),
            );
          }
        });
      },
    );
  }

  //未读消息数
  void _fetchUnreadCount() {
    int _unReadCount = 0;
    _conversationList.forEach((element) {
      _unReadCount += element.unreadMessageNum;
    });

    _unReadCount += (_account != null && _account["visitor_count"] != null
        ? _account["visitor_count"]
        : 0);

    _unReadCount += (_account != null && _account["love_count"] != null
        ? _account["love_count"]
        : 0);

    DartNotificationCenter.post(channel: "kTabUnreadCount", options: {
      "count": _unReadCount,
    });
  }

  // 删除会话
  void _deleteConversation(index) {
    var session = _conversationList[index];
    XsProgressHud.show(context);
    TencentImPlugin.deleteConversation(
      sessionId: session.id,
      sessionType: session.type,
      removeCache: true,
    ).then((value) {
      XsProgressHud.hide();
      if (value == true) {
        setState(() {
          _conversationList.removeAt(index);
          this._fetchUnreadCount();
        });
      } else {
        showToast("删除失败！", context);
      }
    }).catchError((error) {
      XsProgressHud.hide();
      showToast("$error", context);
    });
  }

  //删除提示
  Future<bool> _deleteAlert(index) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Text("是否删除该会话？"),
          actions: <Widget>[
            FlatButton(
              child: Text("取消"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("确定"),
              onPressed: () {
                Navigator.of(context).pop();

                Future.delayed(Duration(milliseconds: 400), () {
                  this._deleteConversation(index);
                });
              },
            ),
          ],
        );
      },
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

    //信息监听
    TencentImPlugin.addListener(_messageListener);
  }

  @override
  void dispose() {
    super.dispose();

    DartNotificationCenter.unsubscribe(observer: this);
    //移除信息监听
    TencentImPlugin.removeListener(_messageListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rgba(248, 248, 248, 1),
      body: Stack(
        children: <Widget>[
          transparentAppBar(
            brightness: Brightness.light,
          ),
          Positioned(
            left: 0,
            bottom: 0,
            top: 0,
            right: 0,
            child: Column(
              children: <Widget>[
                MessageTitleView(
                  title: "消息",
                ),
                Expanded(
                  child: functionRefresher(
                    _refreshController,
                    ListView.builder(
                      padding: EdgeInsets.only(
                        top: 0,
                      ),
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          //访客
                          return _visitorWidget();
                        } else if (index == 1) {
                          //喜欢我的
                          return _loveMeWidget();
                        } else if (index == 2) {
                          //分割线
                          return Container(
                            height: 1,
                            padding: EdgeInsets.fromLTRB(13.5, 0, 0, 0),
                            color: Colors.white,
                            child: Divider(
                              height: 1,
                              color: rgba(231, 231, 231, 1),
                            ),
                          );
                        } else {
                          if (_conversationList.length == 0) {
                            //聊天登录中
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              height: 44,
                              child:
                                  (_imLoginStatus == 0 || _imLoginStatus == 2)
                                      ? FlatButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: _imLoginStatus == 0
                                              ? null
                                              : () {
                                                  _refreshController
                                                      .requestRefresh();
                                                },
                                          child: Text(_imLoginStatus == 0
                                              ? "聊天系统登录中..."
                                              : "再次登录聊天系统"),
                                        )
                                      : Container(),
                            );
                          } else {
                            int idx = index - 3;
                            SessionEntity element = _conversationList[idx];
                            return Slidable(
                              key: Key("message_$idx"),
                              child: MessageCell(
                                padding:
                                    EdgeInsets.fromLTRB(13.5, 10, 14.5, 10),
                                redCount: element.unreadMessageNum,
                                title: element.type == SessionType.System
                                    ? "系统账号"
                                    : element.userProfile.nickName,
                                content:
                                    ObjectUtil.isEmpty(element.message) == true
                                        ? ""
                                        : element.message.note,
                                subContent:
                                    ObjectUtil.isEmpty(element.message) == false
                                        ? TimelineUtil.format(
                                            element.message.timestamp * 1000,
                                            locale: "zh",
                                            dayFormat: DayFormat.Full,
                                          )
                                        : "",
                                icon: element.faceUrl,
                                tapHandle: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) {
                                      return ChatMainPage(
                                        sessionId: element.id,
                                      );
                                    }),
                                  );

                                  TencentImPlugin.setRead(
                                      sessionId: element.id,
                                      sessionType: element.type);
                                },
                              ),
                              actionPane: SlidableBehindActionPane(),
                              secondaryActions: [
                                SlideAction(
                                  child: Text(
                                    "删除",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: rgba(255, 255, 255, 1),
                                    ),
                                  ),
                                  color: Colors.red,
                                  onTap: () {
                                    this._deleteAlert(idx);
                                  },
                                ),
                              ],
                              dismissal: SlidableDismissal(
                                child: SlidableDrawerDismissal(),
                                onWillDismiss: (actionType) {
                                  return this._deleteAlert(idx);
                                },
                              ),
                            );
                          }
                        }
                      },
                      itemCount: 3 +
                          (_conversationList.length == 0
                              ? 1
                              : _conversationList.length),
                    ),
                    onRefresh: () {
                      this._refreshImAction();
                    },
                    enableLoadMore: false,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageTitleView extends StatelessWidget {
  String title = "";
  MessageTitleView({Key key, this.title = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          16.5, MediaQuery.of(context).padding.top + 8, 16.5, 0),
      width: MediaQuery.of(context).size.width,
      color: rgba(255, 255, 255, 1),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 23,
          fontWeight: FontWeight.bold,
          color: rgba(18, 18, 18, 1),
        ),
      ),
    );
  }
}
