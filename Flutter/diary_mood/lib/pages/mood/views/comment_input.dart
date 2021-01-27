import 'package:common_utils/common_utils.dart';
import 'package:diary_mood/public/public.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CommentInput extends StatefulWidget {
  kObjectFunctionBlock sendHandle;
  CommentInput({
    Key key,
    this.sendHandle,
  }) : super(key: key);

  _CommentInputState _state;
  @override
  _CommentInputState createState() {
    if (_state == null) {
      _state = _CommentInputState();
    }

    return _state;
  }

  void setPlaceholder(String placeholder) {
    _state._setPlaceholder(placeholder);
  }

  // 回复对象
  void replyAccount(Map account) {
    _state._replyAccount(account);
  }

  // 关闭输入框
  void closeCommentInput() {
    _state._closeCommentInput();
  }

  void cleanCloseComment() {
    _state._cleanCloseComment();
  }
}

class _CommentInputState extends State<CommentInput> {
  TextEditingController _textEditingController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  String _placeholder = "发布评论";
  bool _isReply = false;

  void _setPlaceholder(String placeholder) {
    _placeholder = placeholder;
    setState(() {});
  }

  // 关闭输入框
  void _closeCommentInput() {
    if (_focusNode.canRequestFocus) {
      // 失去焦点
      _focusNode.unfocus();
    }

    if (_isReply) {
      _isReply = false;
      _placeholder = "发布评论";
      setState(() {});
    }
  }

  void _cleanCloseComment() {
    _textEditingController.text = "";
    this._closeCommentInput();
  }

  // 回复对象
  void _replyAccount(Map account) {
    _focusNode.requestFocus();
    _isReply = true;
    _placeholder = "回复";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          16, 5, 16, 5 + MediaQuery.of(context).padding.bottom),
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 7),
        decoration: BoxDecoration(
          color: rgba(254, 254, 254, 1),
          borderRadius: BorderRadius.circular(45 / 2),
        ),
        constraints: BoxConstraints(
          maxHeight: 45.0 * 2.5,
          minHeight: 45,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
              child: TextField(
                maxLines: null,
                keyboardType: TextInputType.multiline,
                focusNode: _focusNode,
                controller: _textEditingController,
                style: TextStyle(
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  hintText: _placeholder,
                  hintStyle: TextStyle(
                    color: rgba(204, 204, 204, 1),
                    fontSize: 16,
                  ),
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              width: 16,
            ),
            // 发送
            Container(
              height: 31,
              margin: EdgeInsets.only(bottom: 8.5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [rgba(255, 44, 96, 1), rgba(255, 114, 81, 1)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(31 / 2),
              ),
              alignment: Alignment.center,
              child: FlatButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                minWidth: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(31 / 2),
                ),
                onPressed: () {
                  if (ObjectUtil.isEmptyString(_textEditingController.text) ==
                      false) {
                    if (this.widget.sendHandle != null) {
                      this.widget.sendHandle(_textEditingController.text);
                    }
                  }
                },
                child: Text(
                  "发送",
                  style: TextStyle(
                    fontSize: 13,
                    color: rgba(255, 255, 255, 1),
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
