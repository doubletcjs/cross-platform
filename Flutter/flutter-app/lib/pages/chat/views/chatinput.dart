import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import 'package:flutter/material.dart';
import '../../../public/public.dart';

typedef _kInputChangedBlock = void Function(double height);
typedef _kInputSendBlock = void Function();
typedef _kAddEmojiBlock = void Function(String emoji);

class ChatInput extends StatefulWidget {
  //输入框尺寸变化通知block
  _kInputChangedBlock onInputChangedHandle;

  ChatInput({Key key, this.onInputChangedHandle}) : super(key: key);

  @override
  _ChatInputState createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  TextEditingController _textEditingController =
      TextEditingController(); //输入框TextEditingController
  FocusNode _focusNode = FocusNode(); //输入框FocusNode
  GlobalKey _globalKey = GlobalKey(); //功能按钮GlobalKey 用于计算功能按钮总宽度
  GlobalKey _frameGlobalKey = GlobalKey(); //输入框GlobalKey 用于计算输入框高度变化后，框件总高度
  bool _showEmoji = false; //是否显示表情

  //通知尺寸变化
  void _notificationFrameChanged() {
    if (this.widget.onInputChangedHandle != null) {
      this.widget.onInputChangedHandle(_frameGlobalKey.currentContext
          .findRenderObject()
          .paintBounds
          .size
          .height);
    }
  }

  int _maxColumn = 6; //每行6个表情
  List _emojiPages = []; //表情分页

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

  @override
  void initState() {
    super.initState();

    //框件总高度变化通知
    Future.delayed(Duration(milliseconds: 20), () {
      this._notificationFrameChanged();
    });

    _focusNode.addListener(() {
      Future.delayed(Duration(milliseconds: 140), () {
        this._notificationFrameChanged();
      });
    });

    //读取本地表情
    this._loadDefaultEmoji();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        key: _frameGlobalKey,
        color: rgba(243, 243, 243, 1),
        padding: EdgeInsets.fromLTRB(
            0,
            0,
            0,
            (_showEmoji == true ? 0 : 16.5) +
                MediaQuery.of(context).padding.bottom),
        child: Column(
          children: <Widget>[
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
                  Expanded(
                    child: Stack(
                      children: <Widget>[
                        //输入框
                        Container(
                          padding: EdgeInsets.fromLTRB(
                              0,
                              0,
                              _globalKey.currentContext == null
                                  ? 0
                                  : _globalKey.currentContext
                                      .findRenderObject()
                                      .paintBounds
                                      .size
                                      .width,
                              0),
                          constraints: BoxConstraints(
                            maxHeight: 41.0 * 3,
                            minHeight: 41,
                          ),
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
                              this._notificationFrameChanged();
                            },
                            onTap: () {
                              setState(() {
                                _showEmoji = false;
                              });
                              this._notificationFrameChanged();
                            },
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          bottom: 0,
                          child: Container(
                            key: _globalKey,
                            alignment: Alignment.topCenter,
                            child: Row(
                              children: <Widget>[
                                //表情
                                Container(
                                  height: 48,
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        _showEmoji = !_showEmoji;
                                        this._notificationFrameChanged();
                                      });

                                      if (_showEmoji) {
                                        // 失去焦点
                                        _focusNode.unfocus();
                                      } else {
                                        // 获取焦点
                                        FocusScope.of(context)
                                            .requestFocus(_focusNode);
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
                                        margin:
                                            EdgeInsets.fromLTRB(15, 0, 0, 0),
                                        child: FlatButton(
                                          onPressed: () {},
                                          child: Text(
                                            "发送",
                                            style: TextStyle(
                                              color: rgba(255, 255, 255, 1),
                                              fontSize: 13,
                                            ),
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(28 / 2),
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
                                          borderRadius:
                                              BorderRadius.circular(28 / 2),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _showEmoji == true
                ? ChatEmojiPad(
                    maxColumn: _maxColumn,
                    emojiPages: _emojiPages,
                    emojiBlock: (emoji) {
                      setState(() {
                        _textEditingController.text =
                            _textEditingController.text + emoji;
                      });
                    },
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}

class ChatEmojiPad extends StatefulWidget {
  int maxColumn = 6; //每行6个表情
  List emojiPages = []; //表情分页
  _kAddEmojiBlock emojiBlock;

  ChatEmojiPad({
    Key key,
    this.maxColumn = 6,
    this.emojiPages,
    this.emojiBlock,
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
          height: 16.5 +
              ((MediaQuery.of(context).size.width - (8 * 2)) /
                      this.widget.maxColumn) *
                  3.5,
          padding: EdgeInsets.only(left: 8, top: 16.5, right: 8, bottom: 16),
          color: rgba(243, 243, 243, 1),
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
                                if (this.widget.emojiBlock != null) {
                                  this.widget.emojiBlock(
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
                      //关闭、发送按钮
                      Positioned(
                        right: 16.5,
                        bottom: 16.5,
                        height: ((MediaQuery.of(context).size.width - (8 * 2)) /
                            this.widget.maxColumn),
                        child: Row(
                          children: <Widget>[
                            //关闭按钮
                            Container(
                              width: 30,
                              height: 30,
                              child: FlatButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {},
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
                                onPressed: () {},
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
