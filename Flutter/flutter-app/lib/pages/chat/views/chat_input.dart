import 'dart:convert';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:flutter/material.dart';
import '../../../public/public.dart';

typedef _kAddEmojiBlock = void Function(String emoji);
typedef _kChatInputBlock = void Function(String content);
typedef _kChatVoidBlock = void Function();

class ChatInput extends StatefulWidget {
  ChatInput({Key key}) : super(key: key);

  _ChatInputState _state;

  @override
  _ChatInputState createState() {
    if (_state == null) {
      _state = _ChatInputState();
    }

    return _state;
  }

  //关闭输入框
  void closeChatInput() {
    _state._closeChatInput();
  }

  void sendHandle(_kChatInputBlock handle) {
    _state._inputHandle = handle;
  }

  void focusHandle(kVoidFunctionBlock handle) {
    _state._focusHandle = handle;
  }
}

class _ChatInputState extends State<ChatInput> {
  TextEditingController _textEditingController =
      TextEditingController(); //输入框TextEditingController

  bool _showEmoji = false; //是否显示表情
  FocusNode _focusNode = FocusNode(); //输入框FocusNode
  int _maxColumn = 6; //每行6个表情
  List _emojiPages = []; //表情分页
  _kChatInputBlock _inputHandle;
  kVoidFunctionBlock _focusHandle;

  //关闭输入框
  void _closeChatInput() {
    if (_focusNode.canRequestFocus) {
      this.setState(() {
        // 失去焦点
        _focusNode.unfocus();
        _showEmoji = false;
      });
    }
  }

  //表情分页
  void _fetchEmojiPage(List emojis) {
    //分页算法
    List<List<T>> splitList<T>(List<T> list, int len) {
      if (len <= 1) {
        return [list];
      }

      List<List<T>> result = List();
      int index = 1;

      while (true) {
        if (index * len < list.length) {
          List<T> temp = list.skip((index - 1) * len).take(len).toList();
          result.add(temp);
          index++;

          continue;
        }

        List<T> temp = list.skip((index - 1) * len).toList();
        result.add(temp);

        break;
      }

      return result;
    }

    //每页表情数
    int _emojiCount = _maxColumn * 3 - 2;
    setState(() {
      _emojiPages = splitList(emojis, _emojiCount);
    });
  }

  //读取默认表情列表
  void _loadDefaultEmoji() {
    rootBundle.loadString("assets/emojis.json").then((value) {
      setState(() {
        List _emojis = json.decode(value);
        this._fetchEmojiPage(_emojis);
      });
    });
  }

  //发送内容
  void _sendAction() {
    if (_inputHandle != null &&
        ObjectUtil.isEmptyString(_textEditingController.text) == false) {
      _inputHandle(_textEditingController.text);

      Future.delayed(Duration(milliseconds: 200), () {
        setState(() {
          _textEditingController.text = "";
          // this._closeChatInput();
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();

    //读取本地表情
    this._loadDefaultEmoji();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: rgba(243, 243, 243, 1),
      child: Column(
        children: <Widget>[
          //输入框
          Container(
            margin: EdgeInsets.fromLTRB(13.5, 0, 13.5, 0),
            padding: EdgeInsets.fromLTRB(28, 0, 16, 0),
            decoration: BoxDecoration(
              color: rgba(254, 254, 254, 1),
              borderRadius: BorderRadius.circular(48 / 2),
            ),
            constraints: BoxConstraints(
              maxHeight: 41.0 * 3,
              minHeight: 41,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: TextField(
                    controller: _textEditingController,
                    focusNode: _focusNode,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    style: TextStyle(
                      color: rgba(51, 51, 51, 1),
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      hintText: "请输入消息…",
                      hintStyle: TextStyle(
                        color: rgba(204, 204, 204, 1),
                        fontSize: 16,
                      ),
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                    ),
                    onChanged: (text) {
                      setState(() {});
                    },
                    onTap: () {
                      setState(() {
                        _showEmoji = false;
                      });

                      if (_focusHandle != null) {
                        _focusHandle();
                      }
                    },
                  ),
                ),
                Container(
                  height: 48,
                  child: Row(
                    children: <Widget>[
                      //切换表情
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 0, 7.5, 0),
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () {
                            if (_showEmoji == false) {
                              // 失去焦点
                              _focusNode.unfocus();
                              Future.delayed(Duration(milliseconds: 10), () {
                                setState(() {
                                  _showEmoji = !_showEmoji;
                                });
                              });
                            } else {
                              setState(() {
                                _showEmoji = !_showEmoji;
                              });

                              // 获取焦点
                              FocusScope.of(context).requestFocus(_focusNode);
                            }

                            if (_focusHandle != null) {
                              _focusHandle();
                            }
                          },
                          child: Image.asset(
                            _showEmoji == true
                                ? "images/chat_expression_sel@3x.png"
                                : "images/chat_expression@3x.png",
                            width: 18,
                            height: 18,
                          ),
                        ),
                      ),
                      //发送
                      _showEmoji == false &&
                              _textEditingController.text.length > 0
                          ? Container(
                              width: 64,
                              height: 28,
                              margin: EdgeInsets.fromLTRB(7.5, 0, 0, 0),
                              child: FlatButton(
                                onPressed: () {
                                  this._sendAction();
                                },
                                child: Text(
                                  "发送",
                                  style: TextStyle(
                                    color: rgba(255, 255, 255, 1),
                                    fontSize: 13,
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28 / 2),
                                ),
                              ),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    rgba(255, 44, 96, 1),
                                    rgba(255, 114, 81, 1),
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(28 / 2),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          //表情列表
          _showEmoji == true
              ? ChatEmojiPad(
                  maxColumn: _maxColumn,
                  emojiPages: _emojiPages,
                  emojiHandle: (emoji) {
                    setState(() {
                      _textEditingController.text =
                          _textEditingController.text + emoji;
                    });
                  },
                  sendHandle: () {
                    this._sendAction();
                  },
                  deleteHandle: () {
                    if (_textEditingController.text.length > 0) {
                      var deleteStr = _textEditingController.text
                          .substring(_textEditingController.text.length - 1);
                      final runes = deleteStr.runes;
                      int current = runes.elementAt(0);
                      if (current > 255) {
                        _textEditingController.text =
                            _textEditingController.text.substring(
                                0, _textEditingController.text.length - 2);
                      } else {
                        _textEditingController.text =
                            _textEditingController.text.substring(
                                0, _textEditingController.text.length - 1);
                      }
                    } else {
                      _textEditingController.text = "";
                    }
                  },
                )
              : Container(),
        ],
      ),
    );
  }
}

class ChatEmojiPad extends StatefulWidget {
  int maxColumn = 6; //每行6个表情
  List emojiPages = []; //表情分页
  _kAddEmojiBlock emojiHandle;
  _kChatVoidBlock sendHandle;
  _kChatVoidBlock deleteHandle;

  ChatEmojiPad({
    Key key,
    this.maxColumn = 6,
    this.emojiPages,
    this.emojiHandle,
    this.sendHandle,
    this.deleteHandle,
  }) : super(key: key);

  @override
  _ChatEmojiPadState createState() => _ChatEmojiPadState();
}

class _ChatEmojiPadState extends State<ChatEmojiPad> {
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        //表情列表
        Container(
          padding: EdgeInsets.only(left: 8, top: 16.5, right: 8, bottom: 16),
          color: rgba(243, 243, 243, 1),
          height: 220 + MediaQuery.of(context).padding.bottom,
          child: Stack(
            children: <Widget>[
              PageView.builder(
                scrollDirection: Axis.horizontal,
                onPageChanged: (int index) {
                  setState(() {
                    _currentPageIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  List _emojis = this.widget.emojiPages[index];
                  return Stack(
                    children: <Widget>[
                      GridView.custom(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: this.widget.maxColumn,
                          mainAxisSpacing: 0.5,
                          crossAxisSpacing: 1,
                        ),
                        childrenDelegate: SliverChildBuilderDelegate(
                          (context, idx) {
                            //表情
                            return GestureDetector(
                              onTap: () {
                                if (this.widget.emojiHandle != null) {
                                  this.widget.emojiHandle(
                                        String.fromCharCode(
                                            _emojis[idx]["unicode"]),
                                      );
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  String.fromCharCode(_emojis[idx]["unicode"]),
                                  style: TextStyle(fontSize: 33),
                                ),
                              ),
                            );
                          },
                          childCount: _emojis.length,
                        ),
                      ),
                      //删除、发送按钮
                      Positioned(
                        right: 6,
                        bottom: 23,
                        height: ((MediaQuery.of(context).size.width - (8 * 2)) /
                            this.widget.maxColumn),
                        child: Row(
                          children: <Widget>[
                            //删除按钮
                            Container(
                              width: 30,
                              height: 30,
                              child: FlatButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  if (this.widget.deleteHandle != null) {
                                    this.widget.deleteHandle();
                                  }
                                },
                                child: Image.asset(
                                  "images/chat_emoji_delete@3x.png",
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 24,
                            ),
                            //发送按钮
                            Container(
                              width: 54,
                              height: 28,
                              child: FlatButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  if (this.widget.sendHandle != null) {
                                    this.widget.sendHandle();
                                  }
                                },
                                child: Text(
                                  "发送",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: rgba(255, 255, 255, 1),
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28 / 2),
                                ),
                              ),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    rgba(255, 44, 96, 1),
                                    rgba(255, 114, 81, 1),
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(28 / 2),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
                itemCount: this.widget.emojiPages.length,
              ),
              //分页指示器
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(this.widget.emojiPages.length, (i) {
                      return Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 6,
                        ),
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentPageIndex == i
                                ? Colors.blue
                                : Colors.grey),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
        //切换默认、喜爱的表情
        Container(
          height: 44,
          padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
          color: rgba(245, 246, 247, 1),
          child: Row(
            children: <Widget>[
              //默认表情按钮
              Container(
                width: 50,
                height: 30,
                decoration: BoxDecoration(
                  color: rgba(235, 235, 235, 1),
                  borderRadius: BorderRadius.circular(30 / 2),
                ),
                child: FlatButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  child: Image.asset(
                    "images/emoij@3x.png",
                    width: 21,
                    height: 21,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30 / 2),
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              //喜爱的表情
              Container(
                width: 50,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30 / 2),
                ),
                child: FlatButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  child: Image.asset(
                    "images/favourite_emoij@3x.png",
                    width: 19,
                    height: 16.5,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30 / 2),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
