import 'package:corner_app/public/public.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

// ignore: must_be_immutable
class StoreDynamicCell extends StatefulWidget {
  StoreDynamicCell({
    Key key,
  }) : super(key: key);

  @override
  _StoreDynamicCellState createState() => _StoreDynamicCellState();
}

class _StoreDynamicCellState extends State<StoreDynamicCell>
    with AutomaticKeepAliveClientMixin {
  bool _didExpansion = false;
  int _imageIndex = 0;

  // 收藏、评论、点赞
  Widget _functionButton(
      String icon, String content, kVoidFunctionBlock handle) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: handle,
        child: Row(
          children: [
            Image.asset(
              icon,
              width: 20,
              height: 20,
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              content,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13,
                color: rgba(50, 50, 50, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 评论
  Widget _commentWidget(List comments) {
    return Container(
      decoration: BoxDecoration(
        color: rgba(247, 246, 245, 1),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.fromLTRB(8, 12, 8, 12),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: comments.map((comment) {
          var index = comments.indexOf(comment);
          return Container(
            margin: EdgeInsets.only(
              bottom: index < comments.length - 1 ? 8 : 0,
            ),
            child: RichText(
              text: TextSpan(
                text: "${comment['name']}",
                style: TextStyle(
                  fontSize: 14,
                  color: rgba(50, 50, 50, 1),
                  fontWeight: FontWeight.w500,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    kLog("any");
                  },
                children: [
                  TextSpan(
                    text: "${comment['content']}",
                    style: TextStyle(
                      fontSize: 14,
                      color: rgba(153, 153, 153, 1),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // 文章预览
  Widget _articlePreview(String text) {
    TextStyle _style = TextStyle(
      fontSize: 14,
      color: rgba(153, 153, 153, 1),
    );
    //判断 文本是否需要截断
    bool _expansion = false;
    if (_didExpansion == false) {
      TextPainter _textPainter = TextPainter(
        maxLines: 2,
        text: TextSpan(
          text: text,
          style: _style,
        ),
        textDirection: TextDirection.ltr,
      )..layout(
          maxWidth: MediaQuery.of(context).size.width - 16 * 2,
        );

      _expansion = _textPainter.didExceedMaxLines;
    } else {
      _expansion = false;
    }

    return Column(
      children: [
        _expansion == true
            ? Text(
                text,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: _style,
              )
            : Text(
                text,
                style: _style,
              ),
        _expansion == true
            ? Container(
                margin: EdgeInsets.only(
                  top: 8,
                ),
                alignment: Alignment.centerLeft,
                child: Material(
                  color: rgba(255, 255, 255, 1),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _didExpansion = true;
                      });
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "查看全文",
                          style: TextStyle(
                            fontSize: 14,
                            color: rgba(80, 111, 176, 1),
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
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  // 图片
  Widget _imageWidget(List images) {
    double _width = MediaQuery.of(context).size.width - 16 * 2;
    double _height = (_width * 411.5) / 343.0; // 343/411.5 = _width/x
    if (images.length == 1) {
      _width = _width / 2 + 80;
      _height = ((_width * 411.5) / 343.0) + 80;
      if (_height > 600) {
        _height = 600;
      }
    }

    return Container(
      margin: EdgeInsets.only(
        top: 28,
      ),
      alignment: Alignment.bottomLeft,
      child: images.length == 1
          ? networkImage(
              "",
              Size(_width, _height),
              BorderRadius.circular(0),
            )
          : Container(
              width: _width,
              height: _height,
              child: Stack(
                children: [
                  Swiper.children(
                    children: images.map((image) {
                      return networkImage(
                        "",
                        Size(_width, _height),
                        BorderRadius.circular(0),
                      );
                    }).toList(),
                    autoplay: true,
                    autoplayDelay: 4000,
                    onIndexChanged: (index) {
                      setState(() {
                        _imageIndex = index;
                      });
                    },
                  ),
                  Positioned(
                    top: 12.5,
                    right: 12,
                    child: Container(
                      height: 23.5,
                      decoration: BoxDecoration(
                        color: rgba(0, 0, 0, 0.41),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(
                        left: 14.5,
                        right: 14.5,
                      ),
                      child: Text(
                        "${_imageIndex + 1}/${images.length}",
                        style: TextStyle(
                          color: rgba(255, 255, 255, 1),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  // 视频
  Widget _videoWidget() {
    return Container(
      margin: EdgeInsets.only(
        top: 28,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(16, 20, 16, 12),
      decoration: BoxDecoration(
        color: rgba(255, 255, 255, 1),
        border: Border(
          top: BorderSide(
            width: 8,
            color: rgba(247, 246, 245, 1),
          ),
        ),
      ),
      child: Column(
        children: [
          // 用户信息
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  children: [
                    networkImage(
                      "",
                      Size(40, 40),
                      BorderRadius.circular(40 / 2),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            // 用户名
                            Container(
                              constraints: BoxConstraints(
                                maxWidth: 250,
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
                  ],
                ),
              ),
              // 更多
              Container(
                width: 20,
                height: 20,
                child: FlatButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  child: Image.asset(
                    "images/dynamic_more@3x.png",
                  ),
                ),
              ),
            ],
          ),
          this._imageWidget(
            [
              "",
              "",
              "",
              "",
            ],
          ),
          // 内容
          Container(
            margin: EdgeInsets.only(
              top: 12,
            ),
            child: Text(
              "小时候爱吃饺子，纯粹是爱它的美味。现我们吃的，更多是饺子里的家乡味。",
              style: TextStyle(
                fontSize: 16,
                color: rgba(50, 50, 50, 1),
              ),
            ),
          ),
          // 文章预览
          Container(
            margin: EdgeInsets.only(
              top: 12,
            ),
            child: this._articlePreview(
                "我们的生活一定要充满乐趣，因为这样才能算得上是生活，我们大家平时做饭的时候。我们的生活一定要充满乐趣，因为这样才能算得上是生活，我们大家平时做饭的时候。我们的生活一定要充满乐趣，因为这样才能算得上是生活，我们大家平时做饭的时候。"),
          ),
          // 评论
          Container(
            margin: EdgeInsets.only(
              top: 12,
            ),
            child: this._commentWidget(
              [
                {
                  "name": "彩虹蛋糕：",
                  "content": "好赞，一看就很好吃的好赞，一看就很好吃的好赞，一看就很好吃的好赞，一看就很好吃的",
                },
                {
                  "name": "你喜欢不如我喜欢：",
                  "content": "摆盘太精致了",
                },
              ],
            ),
          ),
          // 收藏、评论、点赞
          Container(
            margin: EdgeInsets.only(
              top: 29,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // 收藏
                _functionButton(
                  "images/dynamic_collection@3x.png",
                  "收藏",
                  () {},
                ),
                SizedBox(
                  width: 20,
                ),
                // 评论
                _functionButton(
                  "images/dynamic_comment@3x.png",
                  "评论",
                  () {},
                ),
                SizedBox(
                  width: 20,
                ),
                // 点赞
                _functionButton(
                  "images/discuss_like@3x.png",
                  "点赞",
                  () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
