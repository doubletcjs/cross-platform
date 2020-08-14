import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tencent_im_plugin/entity/message_entity.dart';
import 'package:tencent_im_plugin/entity/session_entity.dart';
import 'package:tencent_im_plugin/enums/message_status_enum.dart';
import 'package:tencent_im_plugin/message_node/text_message_node.dart';
import 'package:tencent_im_plugin/tencent_im_plugin.dart';
import '../../public/public.dart';
import '../mine/mine_homepage.dart';
import 'views/chat_input.dart';
import 'views/chart_message_cell.dart';
import '../account/api/account_api.dart';

class ChatMainPage extends StatefulWidget {
  String sessionId = ""; //会话id，对方聊天（用户）id
  ChatMainPage({
    Key key,
    this.sessionId = "",
  }) : super(key: key);

  @override
  _ChatMainPageState createState() => _ChatMainPageState();
}

class _ChatMainPageState extends State<ChatMainPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  //列表滚动controller
  ScrollController _scrollController = ScrollController();
  //输入框
  ChatInput _chatInput;
  //会话
  SessionEntity _sessionEntity;
  Map _currentAccount; //用户信息 读取 /api/v1/user/other 他人主页？

  //获取用户信息
  void _refreshAccount() {
    AccountApi.otherProfile(this.widget.sessionId, (data, msg) {
      if (data != null) {
        setState(() {
          _currentAccount = Map.from(data);
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        });
      } else {
        showToast(msg, context);
        setState(() {
          _currentAccount = {};
        });
      }
    });
  }

  //在线状态，距离
  String _statusDistance() {
    String _status = "";
    if (ObjectUtil.isEmpty(_currentAccount['is_active']) == false &&
        _currentAccount['is_active'] == 1) {
      _status = "在线";
    } else {
      if (ObjectUtil.isEmpty(_currentAccount['human_active_at']) == false) {
        _status = "${_currentAccount['human_active_at']}";
      }
    }

    String _distance = "";
    if (ObjectUtil.isEmpty(_currentAccount['distance']) == false) {
      _distance =
          '${double.parse('${_currentAccount['distance']}').toStringAsFixed(2)}km';
    }

    return _status + (_status.length > 0 ? "    " : "") + "$_distance";
  }

  //获得单个会话
  void _getConversation() async {
    SessionEntity _entity = await TencentImPlugin.getConversation(
        sessionId: this.widget.sessionId, sessionType: SessionType.C2C);

    if (_entity != null) {
      setState(() {
        _sessionEntity = _entity;
        if (ObjectUtil.isEmpty(_entity.nickname) == false) {
          _chatInput = ChatInput();
          this._getMessages();

          Future.delayed(Duration(milliseconds: 100), () {
            //接受消息输入
            _chatInput.sendHandle((content) {
              this._sendMessage(content);
            });
            //输入框响应
            _chatInput.focusHandle(() {
              Future.delayed(Duration(milliseconds: 100), () {
                _scrollController
                    .jumpTo(_scrollController.position.maxScrollExtent);
              });
            });
          });
        } else {
          _chatInput = null;
        }
      });
    }
  }

  //消息列表
  List<MessageEntity> _messageList = [];
  int _pageSize = 30; //每页消息数
  //获取消息
  void _getMessages() {
    TencentImPlugin.getMessages(
      sessionId: this.widget.sessionId,
      sessionType: SessionType.C2C,
      number: _pageSize,
    ).then((value) {
      _messageList = List.from(value);
      this._sortMessage();

      Future.delayed(Duration(milliseconds: 100), () {
        this._refreshAccount();
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      });
    });
  }

  /// 获取消息列表事件
  void _onRefresh() {
    TencentImPlugin.getMessages(
      sessionId: _sessionEntity.id,
      sessionType: _sessionEntity.type,
      number: _messageList.length + _pageSize,
    ).then((value) {
      _messageList = List.from(value);
      this._sortMessage();
      // 设置已读
      TencentImPlugin.setRead(
          sessionId: _sessionEntity.id, sessionType: _sessionEntity.type);

      Future.delayed(Duration(milliseconds: 100), () {
        _scrollController.jumpTo(_scrollController.position.minScrollExtent);
      });
    });
  }

  //聊天会话排序
  void _sortMessage() {
    _messageList.sort(
      (i1, i2) => i1 == null
          ? 0
          : i2 == null ? -1 : i1.timestamp.compareTo(i2.timestamp),
    );

    setState(() {
      kLog("消息数:${_messageList.length}");
      _refreshController.refreshCompleted();
    });
  }

  //消息监听器
  void _messageListener(ListenerTypeEnum type, params) {
    print("type:" + "$type");
    print("params:" + "$params");
    // 新消息时更新会话列表最近的聊天记录
    if (type == ListenerTypeEnum.NewMessages) {
      // 设置已读
      TencentImPlugin.setRead(
          sessionId: _sessionEntity.id, sessionType: _sessionEntity.type);
      setState(() {
        // 更新消息列表
        for (MessageEntity item in params) {
          bool exist = false;
          for (var i = 0; i < _messageList.length; i++) {
            if (_messageList[i].id == item.id) {
              _messageList[i] = item;
              exist = true;
              break;
            }
          }
          if (!exist) {
            _messageList.add(item);
          }
        }

        Future.delayed(Duration(milliseconds: 100), () {
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        });
      });
    } else if (type == ListenerTypeEnum.RecvReceipt) {
      setState(() {
        for (String itemId in params) {
          if (itemId == _sessionEntity.id) {
            for (var i = 0; i < _messageList.length; i++) {
              MessageEntity _message = _messageList[i];
              _message.peerReaded = true;
              _messageList[i] = _message;
            }

            break;
          }
        }
      });
    }
  }

  ///发消息
  void _sendMessage(content) {
    double timestamp = DateUtil.getNowDateMs() / 1000;
    MessageEntity _sendingMessage = MessageEntity(
      timestamp: timestamp.toInt(),
      self: true,
      sessionId: this.widget.sessionId,
      sessionType: SessionType.C2C,
      elemList: [
        TextMessageNode(
          content: content,
        ),
      ],
    );

    _sendingMessage.status = MessageStatusEnum.Sending;
    setState(() {
      _messageList.add(_sendingMessage);
    });

    Future.delayed(Duration(milliseconds: 100), () {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });

    TencentImPlugin.sendMessage(
      sessionId: this.widget.sessionId,
      sessionType: SessionType.C2C,
      node: TextMessageNode(
        content: content,
      ),
    ).then((res) {
      if (res != null) {
        setState(() {
          int index = _messageList.indexOf(_sendingMessage);
          _messageList[index] = res;
        });
      }
    }).catchError((error) {
      showToast(error.toString(), context);
      setState(() {
        int index = _messageList.indexOf(_sendingMessage);
        _sendingMessage.status = MessageStatusEnum.SendFail;
        _messageList[index] = _sendingMessage;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      int maxScrollExtent = _scrollController.position.maxScrollExtent.toInt();
      int offset = _scrollController.position.pixels.toInt();
      if (offset != 0 && offset != maxScrollExtent) {
        _chatInput.closeChatInput();
      }
    });

    //信息监听
    TencentImPlugin.addListener(_messageListener);
    this._getConversation();
  }

  @override
  void dispose() {
    super.dispose();

    _scrollController.dispose();
    _refreshController.dispose();
    //移除信息监听
    TencentImPlugin.removeListener(_messageListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rgba(243, 243, 243, 1),
      body: Stack(
        children: <Widget>[
          transparentAppBar(
            brightness: Brightness.light,
          ),
          Column(
            children: <Widget>[
              //自定义导航栏
              Container(
                margin: EdgeInsets.fromLTRB(
                    0, MediaQuery.of(context).padding.top, 0, 0),
                color: rgba(243, 243, 243, 1),
                height: AppBar().preferredSize.height,
                child: Stack(
                  children: [
                    //返回、主页按钮
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        //返回、未读消息数
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Row(
                            children: <Widget>[
                              //返回按钮
                              SizedBox(
                                width: 15,
                              ),
                              Image.asset(
                                "images/Arrow right@3x.png",
                                width: 10,
                                height: 18,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              //未读消息数
                              (_sessionEntity != null &&
                                      _sessionEntity.unreadMessageNum != null &&
                                      _sessionEntity.unreadMessageNum > 0)
                                  ? Container(
                                      padding:
                                          EdgeInsets.fromLTRB(7, 2.5, 7, 2.5),
                                      child: Text(
                                        "${_sessionEntity.unreadMessageNum}"
                                        "",
                                        style: TextStyle(
                                          color: rgba(255, 255, 255, 1),
                                          fontSize: 11,
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        color: rgba(255, 73, 54, 1),
                                        borderRadius:
                                            BorderRadius.circular(20 / 2),
                                      ),
                                    )
                                  : Container(),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                        //主页按钮
                        (_sessionEntity != null &&
                                ObjectUtil.isEmpty(_sessionEntity.nickname) ==
                                    false)
                            ? Container(
                                width: AppBar().preferredSize.height,
                                height: AppBar().preferredSize.height,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      AppBar().preferredSize.height / 2),
                                ),
                                child: FlatButton(
                                  padding: EdgeInsets.zero,
                                  child: Image.asset(
                                    "images/gerenzhongxin@3x.png",
                                    width: 21,
                                    height: 21,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                        return MineHomePage(
                                          userId: this.widget.sessionId,
                                        );
                                      }),
                                    );
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        AppBar().preferredSize.height / 2),
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                    //标题
                    Positioned(
                      top: 0,
                      bottom: 0,
                      left: 88,
                      right: 88,
                      child: Center(
                        child: _sessionEntity == null
                            ? Container(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: ObjectUtil.isEmpty(
                                            _sessionEntity.nickname) ==
                                        true
                                    ? <Widget>[
                                        Text(
                                          "账号未注册",
                                          textAlign: TextAlign.center,
                                        ),
                                      ]
                                    : <Widget>[
                                        //用户名
                                        Text(
                                          _sessionEntity.nickname,
                                          style: TextStyle(
                                            color: rgba(0, 0, 0, 1),
                                            fontSize: 18,
                                          ),
                                        ),
                                        //在线状态，距离
                                        _currentAccount == null
                                            ? Container(
                                                height: 10,
                                                width: 10,
                                                child:
                                                    CircularProgressIndicator(
                                                  strokeWidth: 1,
                                                ),
                                              )
                                            : Text(
                                                this._statusDistance(),
                                                style: TextStyle(
                                                  color: rgba(204, 204, 204, 1),
                                                  fontSize: 11,
                                                ),
                                              ),
                                      ],
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              //聊天内容
              Expanded(
                child: functionRefresher(
                  _refreshController,
                  ListView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return ChartMessageCell(
                        message: _messageList[index],
                      );
                    },
                    itemCount: _messageList.length,
                  ),
                  enableRefresh: true,
                  enableLoadMore: false,
                  onRefresh: () {
                    this._onRefresh();
                  },
                ),
              ),
              //输入框
              _chatInput == null ? Container() : _chatInput,
              SizedBox(
                height: MediaQuery.of(context).padding.bottom,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
