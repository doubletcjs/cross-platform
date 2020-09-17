import 'package:corner_app/pages/module/discuss/discuss_reply.dart';
import 'package:corner_app/public/public.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DiscussCell extends StatefulWidget {
  bool showBorder = false;
  bool hideLine = false;
  DiscussCell({
    Key key,
    this.showBorder = false,
    this.hideLine = false,
  }) : super(key: key);

  @override
  _DiscussCellState createState() => _DiscussCellState();
}

class _DiscussCellState extends State<DiscussCell> {
  // 已打开全文
  bool _didExpansion = false;

  Widget _commentFill(String text, double maxWidth) {
    TextStyle _style = TextStyle(
      fontSize: 16,
      color: rgba(50, 50, 50, 1),
    );

    //判断 文本是否需要截断
    bool _expansion = false;
    int _endOffset;
    if (_didExpansion == false) {
      TextPainter _textPainter = TextPainter(
        maxLines: 5,
        text: TextSpan(
          text: text,
          style: _style,
        ),
        textDirection: TextDirection.ltr,
      )..layout(
          maxWidth: maxWidth,
        );

      final linkWidth = _textPainter.width;
      final textSize = _textPainter.size;
      final position = _textPainter.getPositionForOffset(Offset(
        textSize.width - linkWidth,
        textSize.height,
      ));

      _endOffset = _textPainter.getOffsetBefore(position.offset);
      _expansion = _textPainter.didExceedMaxLines;
    } else {
      _expansion = false;
    }

    return _expansion == true
        ? RichText(
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              text: text.substring(0, _endOffset - 3) + "...  ",
              style: _style,
              children: [
                TextSpan(
                  text: "展开",
                  style: TextStyle(
                    fontSize: 16,
                    color: rgba(80, 111, 176, 1),
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      setState(() {
                        _didExpansion = true;
                      });
                    },
                ),
              ],
            ),
          )
        : Text(
            text,
            style: _style,
          );
  }

  // 回复列表
  void _replyList() {
    DiscussReply().show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: rgba(255, 255, 255, 1),
        border: this.widget.showBorder == true
            ? Border(
                top: BorderSide(
                  width: 8,
                  color: rgba(247, 246, 245, 1),
                ),
              )
            : Border(),
      ),
      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    SizedBox(
                      width: 16,
                    ),
                    // 头像
                    networkImage(
                      "",
                      Size(40, 40),
                      BorderRadius.circular(40 / 2),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              // 用户名
                              Container(
                                constraints: BoxConstraints(
                                  maxWidth: 200,
                                ),
                                child: Text(
                                  "红鱼",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: rgba(50, 50, 50, 1),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              // 博主
                              Container(
                                width: 39.5,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: rgba(235, 102, 91, 1),
                                  borderRadius: BorderRadius.circular(16 / 2),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "落主",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: rgba(255, 255, 255, 1),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // 发布时间
                          Text(
                            "30分钟前",
                            style: TextStyle(
                              fontSize: 10,
                              color: rgba(153, 153, 153, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 12,
              ),
              // 点赞
              Material(
                color: rgba(255, 255, 255, 1),
                child: InkWell(
                  onTap: () {},
                  child: Column(
                    children: [
                      Image.asset(
                        "images/discuss_like@3x.png",
                        width: 20,
                        height: 20,
                      ),
                      SizedBox(
                        height: 3.5,
                      ),
                      Text(
                        "赞",
                        style: TextStyle(
                          fontSize: 13,
                          color: rgba(50, 50, 50, 1),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 16,
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 16, left: 64, right: 74.5),
            padding: EdgeInsets.only(
              bottom: 12,
            ),
            child: Column(
              children: [
                // 回复内容
                this._commentFill(
                  "说起文人谈美食，脑子里就迸出一串串名字——季鹰归未、东坡夜饮、笠翁醉蟹、雪芹茄鲞，还有写了《藕与莼菜》的叶。说起文人谈美食，脑子里就迸出一串串名字——季鹰归未、东坡夜饮、笠翁醉蟹、雪芹茄鲞，还有写了《藕与莼菜》的叶",
                  MediaQuery.of(context).size.width - 64 - 74.5,
                ),
                // 回复数
                Container(
                  margin: EdgeInsets.only(
                    top: 12,
                  ),
                  alignment: Alignment.centerLeft,
                  child: Material(
                    color: rgba(255, 255, 255, 1),
                    child: InkWell(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "2条回复",
                            style: TextStyle(
                              fontSize: 14,
                              color: rgba(69, 95, 151, 1),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Image.asset(
                            "images/dynamic_more_content@3x.png",
                            width: 6,
                            height: 10,
                          ),
                        ],
                      ),
                      onTap: () {
                        this._replyList();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 分割线
          this.widget.hideLine == false
              ? Container(
                  margin: EdgeInsets.only(
                    left: 64,
                  ),
                  color: rgba(0, 0, 0, 0.1),
                  height: 0.5,
                )
              : Container(),
        ],
      ),
    );
  }
}
