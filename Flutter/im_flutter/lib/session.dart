import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tencent_im_plugin/entity/session_entity.dart';
import 'package:tencent_im_plugin/enums/message_node_type.dart';
import 'package:tencent_im_plugin/message_node/message_node.dart';
import 'package:tencent_im_plugin/tencent_im_plugin.dart';

class SessionPage extends StatefulWidget {
  SessionPage({Key key}) : super(key: key);

  @override
  _SessionPageState createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  List _dataList = [];
  String _account = "";
  void _messageListener(ListenerTypeEnum type, params) {
    print("type:" + "$type");
    print("params:" + "$params");
    // 新消息时更新会话列表最近的聊天记录
    if (type == ListenerTypeEnum.RefreshConversation) {
      this.setState(() {
        for (var item in params) {
          bool exist = false;
          for (var i = 0; i < _dataList.length; i++) {
            if (_dataList[i].id == item.id) {
              _dataList[i] = item;
              exist = true;
              break;
            }
          }
          if (!exist) {
            _dataList.add(item);
          }
        }

        this._sort();
      });
    }
  }

  void _getConversationList() {
    TencentImPlugin.getConversationList().then(
      (value) {
        this.setState(
          () {
            _dataList = List.from(value);
            this._sort();
          },
        );
      },
    );
  }

  ///list排序
  void _sort() {
    _dataList.sort(
      (i1, i2) => i1.message == null
          ? 0
          : i2.message == null
              ? -1
              : i2.message.timestamp.compareTo(i1.message.timestamp),
    );
  }

  ///发消息
  void _sendMessage(userId, content) {
    TencentImPlugin.sendMessage(
      sessionId: userId,
      sessionType: SessionType.C2C,
      node: TextMessageNode(
        content: content,
      ),
    ).then((res) {
      print(res.toString());
    }).catchError((error) {
      print(error.toString());
    });
  }

  //删除会话
  void _deleteConversation(SessionEntity session) {
    TencentImPlugin.deleteConversation(
      sessionId: session.id,
      sessionType: session.type,
    ).then((value) {
      if (value) {
        this.setState(() {
          this._dataList.remove(session);
        });
      }
    });
  }

  ///随机数
  String _randomBit(int len) {
    String scopeF = "123456789"; //首位
    String scopeC = "0123456789"; //中间
    String result = "";
    for (int i = 0; i < len; i++) {
      if (i == 1) {
        result = scopeF[Random().nextInt(scopeF.length)];
      } else {
        result = result + scopeC[Random().nextInt(scopeC.length)];
      }
    }
    return result;
  }

  @override
  void initState() {
    super.initState();

    //信息监听
    TencentImPlugin.addListener(_messageListener);

    this._getConversationList();

    TencentImPlugin.getLoginUser().then(
      (value) => {
        this.setState(() {
          _account = value;
        })
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    //移除信息监听
    TencentImPlugin.removeListener(_messageListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("会话" + _account),
        leading: IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () {
            TencentImPlugin.logout().then(
              (value) {
                exit(0);
              },
            );
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              this._getConversationList();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          SessionEntity session = _dataList[index];
          DateTime dateTime = session.message != null
              ? DateTime.fromMillisecondsSinceEpoch(
                  session.message.timestamp * 1000)
              : null;
          String _nickName = "";
          String _avatar = "";
          String _content = "";
          if (session.type == SessionType.System ||
              session.type == SessionType.Group) {
            _nickName = "系统账号";
            if (session.type == SessionType.Group) {
              _content = "[群系统消息]";
            } else {
              _content = session.message.note;
            }
          } else {
            _nickName = session.message.userInfo.nickName +
                session.message.userInfo.identifier;
            _avatar = session.message.userInfo.faceUrl;
            _content = session.message.note;
          }
          return InkWell(
            onLongPress: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                      "是否删除该会话？",
                    ),
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
                          this._deleteConversation(session);
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  );
                },
              );
            },
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: _avatar == ""
                    ? null
                    : Image.network(
                        _avatar,
                        fit: BoxFit.cover,
                      ).image,
              ),
              title: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _nickName,
                    ),
                  ),
                  Text(
                    dateTime == null
                        ? ""
                        : "${dateTime.year}-${dateTime.month}-${dateTime.day} ${dateTime.hour}:${dateTime.minute}:${dateTime.second}",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              subtitle: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _content,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  session.unreadMessageNum != 0
                      ? Container(
                          margin: EdgeInsets.only(top: 5),
                          padding: EdgeInsets.only(
                            top: 2,
                            bottom: 2,
                            left: 6,
                            right: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.all(
                              Radius.circular(100),
                            ),
                          ),
                          child: Text(
                            "${session.unreadMessageNum}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        )
                      : Text(""),
                ],
              ),
            ),
          );
        },
        itemCount: _dataList.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (Platform.isIOS) {
            this._sendMessage(
                "000002", "发送给安卓，来自iOS" + " __ " + "${_randomBit(4)}");
          } else {
            this._sendMessage(
                "000001", "发送给iOS，来自安卓" + " __ " + "${_randomBit(4)}");
          }
        },
        child: Icon(
          Icons.message,
        ),
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
