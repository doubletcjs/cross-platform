import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:tencent_im_plugin/entity/message_entity.dart';
import 'package:tencent_im_plugin/entity/session_entity.dart';
import 'package:tencent_im_plugin/enums/message_node_type.dart';
import 'package:tencent_im_plugin/message_node/message_node.dart';
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
  //列表滚动controller
  ScrollController _scrollController = ScrollController();
  //输入框
  ChatInput _chatInput = ChatInput();
  //会话
  SessionEntity _sessionEntity = SessionEntity();
  Map _currentAccount = {}; //用户信息 读取 /api/v1/user/other 他人主页？

  //获取用户信息
  void _refreshAccount() {
    AccountApi.otherProfile(this.widget.sessionId, (data, msg) {
      if (data != null) {
        setState(() {
          _currentAccount = Map.from(data);
        });
      } else {
        showToast(msg, context);
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

    kLog("faceUrl:${_entity.faceUrl}");
    kLog("unreadMessageNum:${_entity.unreadMessageNum}");
    kLog("nickname:${_entity.nickname}");
    kLog("id:${_entity.id}");
    kLog("type:${_entity.type}");

    if (_entity != null) {
      setState(() {
        _sessionEntity = _entity;
        this._getMessages();
      });
    }
  }

  //消息列表
  List<MessageEntity> _messageList = [];
  //获取消息
  void _getMessages() async {
    List<MessageEntity> _list = await TencentImPlugin.getMessages(
      sessionId: this.widget.sessionId,
      sessionType: SessionType.C2C,
      number: 20,
    );

    if (_list != null) {
      _list.sort((i1, i2) {
        return i2.timestamp.compareTo(i1.timestamp);
      });
      setState(() {
        _messageList = _list;
        kLog("消息数:${_messageList.length}");
      });
    }
  }

  ///发消息
  void _sendMessage(content) {
    if (ObjectUtil.isEmpty(_sessionEntity.nickname)) {
      showToast("该账号未注册到聊天系统", context);
      return;
    }

    TencentImPlugin.sendMessage(
      sessionId: this.widget.sessionId,
      sessionType: SessionType.C2C,
      node: TextMessageNode(
        content: content,
      ),
    ).then((res) {
      if (res != null) {
        setState(() {
          _messageList.insert(0, res);
        });
      }
    }).catchError((error) {
      showToast(error.toString(), context);
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      int offset = _scrollController.position.pixels.toInt();
      if (offset != 0) {
        _chatInput.closeChatInput();
      }
    });

    this._getConversation();
    Future.delayed(Duration(milliseconds: 300), () {
      this._refreshAccount();

      //接受消息输入
      _chatInput.sendHandle((content) {
        this._sendMessage(content);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();

    _scrollController.dispose();
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    //返回、未读消息数
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        height: AppBar().preferredSize.height - 6 * 2,
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
                            (_sessionEntity.unreadMessageNum != null &&
                                    _sessionEntity.unreadMessageNum > 0)
                                ? Container(
                                    padding:
                                        EdgeInsets.fromLTRB(7, 2.5, 7, 2.5),
                                    child: Text(
                                      "${_sessionEntity.unreadMessageNum}" "",
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
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: ObjectUtil.isEmpty(_currentAccount["nickname"]) !=
                              true
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                //用户名
                                Text(
                                  _currentAccount["nickname"],
                                  style: TextStyle(
                                    color: rgba(0, 0, 0, 1),
                                    fontSize: 18,
                                  ),
                                ),
                                //在线状态，距离
                                Text(
                                  this._statusDistance(),
                                  style: TextStyle(
                                    color: rgba(204, 204, 204, 1),
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                              ],
                            ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    //主页按钮
                    Container(
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
                    ),
                  ],
                ),
              ),
              //聊天内容
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  reverse: true,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return ChartMessageCell(
                      message: _messageList[index],
                    );
                  },
                  itemCount: _messageList.length,
                ),
              ),
              //输入框
              _chatInput,
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

/// 文本消息节点
class TextMessageNode extends MessageNode {
  /// 文本内容
  String content;

  TextMessageNode({
    @required this.content,
  }) : super(MessageNodeType.Text);

  TextMessageNode.fromJson(Map<String, dynamic> json)
      : super(MessageNodeType.Text) {
    content = json['content'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data["content"] = this.content;
    return data;
  }
}
