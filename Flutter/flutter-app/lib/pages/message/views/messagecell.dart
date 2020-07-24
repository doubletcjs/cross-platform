import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../public/public.dart';

class MessageCell extends StatefulWidget {
  EdgeInsets padding = EdgeInsets.zero;
  int redCount = 0;
  String icon = "标题";
  String title = "标题";
  String content = "内容";
  String subContent = "时间";
  kVoidFunctionBlock tapHandle;

  MessageCell({
    Key key,
    this.padding = EdgeInsets.zero,
    this.redCount = 0,
    this.icon = "",
    this.title = "标题",
    this.content = "内容",
    this.subContent = "时间",
    this.tapHandle,
  }) : super(key: key);

  @override
  _MessageCellState createState() => _MessageCellState();
}

class _MessageCellState extends State<MessageCell> {
  Size _redSize() {
    Size _size = getTextSize(
      "${this.widget.redCount}",
      TextStyle(
        fontSize: 10,
        color: rgba(255, 255, 255, 1),
      ),
    );

    if (this.widget.redCount < 10) {
      _size = Size(15, _size.height);
    } else {
      _size = Size(_size.width + 5 * 2, _size.height);
    }

    if (_size.height < 15) {
      _size = Size(_size.width, 15);
    }

    return _size;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: rgba(255, 255, 255, 1),
      child: InkWell(
        onTap: this.widget.tapHandle == null
            ? null
            : () {
                this.widget.tapHandle();
              },
        child: Container(
          padding: EdgeInsets.fromLTRB(
              0, this.widget.padding.top, 0, this.widget.padding.bottom),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                width: this.widget.padding.left,
              ),
              ClipRRect(
                child: this.widget.icon.startsWith("images/")
                    ? Image.asset(
                        this.widget.icon,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      )
                    : CachedNetworkImage(
                        imageUrl: this.widget.icon,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                borderRadius: BorderRadius.circular(50 / 2),
              ),
              SizedBox(
                width: 12.5,
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            this.widget.title,
                            style: TextStyle(
                              fontSize: 15,
                              color: rgba(18, 18, 18, 1),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          this.widget.subContent,
                          style: TextStyle(
                            fontSize: 11,
                            color: rgba(170, 170, 170, 1),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            this.widget.content,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13,
                              color: rgba(144, 144, 144, 1),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Container(
                          width: _redSize().width,
                          height: _redSize().height,
                          alignment: Alignment.center,
                          child: this.widget.redCount > 0
                              ? Text(
                                  "${this.widget.redCount}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: rgba(255, 255, 255, 1),
                                  ),
                                )
                              : Container(),
                          decoration: this.widget.redCount > 0
                              ? BoxDecoration(
                                  color: rgba(255, 73, 54, 1),
                                  borderRadius: BorderRadius.circular(
                                    _redSize().height / 2,
                                  ),
                                )
                              : BoxDecoration(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: this.widget.padding.right,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
