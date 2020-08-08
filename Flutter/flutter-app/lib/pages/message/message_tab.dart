import 'package:common_utils/common_utils.dart';
import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tencent_im_plugin/entity/session_entity.dart';
import 'package:tencent_im_plugin/tencent_im_plugin.dart';
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
  Map _account = {};
  //获取用户信息
  void _refreshAccount() {
    setState(() {
      _account = currentAccount;
    });
  }

  List<SessionEntity> _conversationList = []; //会话列表
  int _imLoggingStatus = 0; //im登录状态 0 登录中 1 成功 2 失败
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
    if (type == ListenerTypeEnum.RefreshConversation) {
      this.setState(() {
        for (var item in params) {
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

          TencentImPlugin.login(identifier: userId, userSig: userSig).then((_) {
            if (ObjectUtil.isEmptyString(userId) == false) {
              kLog("登录成功");
              //登录成功
              TencentImPlugin.initStorage(identifier: userId);
              //信息监听
              TencentImPlugin.addListener(_messageListener);
              setState(() {
                _imLoggingStatus = 1;
                this._getConversationList();
              });
            } else {
              //登录失败
              kLog("登录失败");
              setState(() {
                _imLoggingStatus = 2;
              });
            }
          }).catchError((error) {
            kLog("error:$error");
            //登录失败
            setState(() {
              _imLoggingStatus = 2;
            });
          });
        }

        String imUserId = await TencentImPlugin.getLoginUser();
        if (ObjectUtil.isEmptyString(imUserId) == false) {
          if (imUserId != userId) {
            await TencentImPlugin.logout();
            //非当前用户，注销重新登录
            _imLogin();
          } else {
            //已登录
            kLog("已登录");
            setState(() {
              _imLoggingStatus = 1;
              this._getConversationList();
            });
            await TencentImPlugin.initStorage(identifier: imUserId);
          }
        } else {
          //未登录
          _imLogin();
        }
      }
    });
  }

  //获取聊天会话
  void _getConversationList() {
    TencentImPlugin.getConversationList().then(
      (value) {
        this.setState(
          () {
            _conversationList = List.from(value);
            this._sortConversation();
            kLog("会话数:${_conversationList.length}");
          },
        );
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

    setState(() {});
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

    this._checkImStatus();
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
                  child: ListView.builder(
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
                                (_imLoggingStatus == 0 || _imLoggingStatus == 2)
                                    ? FlatButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: _imLoggingStatus == 0
                                            ? null
                                            : () {
                                                setState(() {
                                                  _imLoggingStatus = 0;
                                                });
                                                this._checkImStatus();
                                              },
                                        child: Text(_imLoggingStatus == 0
                                            ? "聊天系统登录中..."
                                            : "再次登录聊天系统"),
                                      )
                                    : Container(),
                          );
                        } else {
                          int idx = index - 3;
                          SessionEntity element = _conversationList[idx];
                          return MessageCell(
                            padding: EdgeInsets.fromLTRB(13.5, 10, 14.5, 10),
                            redCount: element.unreadMessageNum,
                            title: element.type == SessionType.System
                                ? "系统账号"
                                : (ObjectUtil.isEmpty(
                                        element.userProfile.nickName)
                                    ? "未注册用户"
                                    : element.userProfile.nickName),
                            content: element.message.note,
                            subContent: TimelineUtil.format(
                                element.message.timestamp * 1000,
                                locale: "zh"),
                            icon: element.faceUrl,
                            tapHandle: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) {
                                  return ChatMainPage(
                                    sessionId: element.id,
                                  );
                                }),
                              );
                            },
                          );
                        }
                      }
                    },
                    itemCount: 3 +
                        (_conversationList.length == 0
                            ? 1
                            : _conversationList.length),
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
