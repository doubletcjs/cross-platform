import 'package:diary_mood/pages/mood/views/comment_card.dart';
import 'package:diary_mood/pages/mood/views/comment_input.dart';
import 'package:diary_mood/pages/mood/views/mood_card.dart';
import 'package:diary_mood/public/public.dart';
import 'package:diary_mood/public/widget/action_sheet.dart';
import 'package:diary_mood/public/widget/alert_view.dart';
import 'package:flutter/material.dart';

class MoodDetailPage extends StatefulWidget {
  MoodDetailPage({Key key}) : super(key: key);

  @override
  _MoodDetailPageState createState() => _MoodDetailPageState();
}

class _MoodDetailPageState extends State<MoodDetailPage> {
  List _commentList = [
    "",
    "",
    "",
  ];
  CommentInput _commentInput;

  // 举报
  void _reportAction() {
    void _report() {
      kLog("_report");
    }

    void _cancel() {
      kLog("_cancel");
    }

    ActionSheet(
      titles: ["举报", "取消"],
      actions: [
        () {
          _report();
        },
        () {
          _cancel();
        }
      ],
    ).show(context);

    _commentInput.closeCommentInput();
  }

  @override
  void initState() {
    super.initState();

    if (mounted) {
      _commentInput = CommentInput(
        sendHandle: (object) {
          showToast("$object");
          Future.delayed(Duration(milliseconds: 500), () {
            _commentInput.cleanCloseComment();
          });
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("详情"),
        actions: [
          IconButton(
            icon: Icon(Icons.more_horiz),
            onPressed: () {
              this._reportAction();
            },
          ),
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: GestureDetector(
          onTap: () {
            _commentInput.closeCommentInput();
          },
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      // 动态详情
                      return Container(
                        color: rgba(255, 255, 255, 1),
                        child: MoodBaseCard(
                          dianzanHandle: () {
                            _commentInput.closeCommentInput();
                          },
                          topicHandle: (object) {
                            _commentInput.closeCommentInput();
                          },
                          accountHandle: () {
                            _commentInput.closeCommentInput();
                          },
                        ),
                      );
                    } else if (index == 1) {
                      // 评论数
                      return Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 8),
                        decoration: BoxDecoration(
                          color: rgba(255, 255, 255, 1),
                          border: Border(
                            top: BorderSide(
                              width: 8,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            bottom: BorderSide(
                              width: 0.5,
                              color: rgba(239, 239, 239, 1),
                            ),
                          ),
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "评论 ${_commentList.length}",
                          style: TextStyle(
                            color: rgba(51, 51, 51, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      );
                    }

                    // 评论列表
                    return _commentList.length == 0
                        ? Container(
                            height: 187,
                            color: rgba(255, 255, 255, 1),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "images/zanwupinglun@3x.png",
                                  width: 82,
                                  height: 61,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "暂无评论",
                                  style: TextStyle(
                                    color: rgba(204, 204, 204, 1),
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(
                            color: rgba(255, 255, 255, 1),
                            padding: EdgeInsets.only(
                                bottom: index - 2 == _commentList.length - 1
                                    ? 14
                                    : 0),
                            child: CommentCard(
                              replyHandle: () {
                                _commentInput.replyAccount({});
                              },
                              deleteHandle: () {
                                _commentInput.closeCommentInput();

                                AlertView(
                                  title: "",
                                  content: "是否删除该评论？",
                                ).show(context);
                              },
                            ),
                          );
                  },
                  itemCount:
                      2 + (_commentList.length == 0 ? 1 : _commentList.length),
                ),
              ),
              // 评论输入框
              _commentInput,
            ],
          ),
        ),
      ),
    );
  }
}
