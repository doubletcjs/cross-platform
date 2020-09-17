import 'package:common_utils/common_utils.dart';
import 'package:corner_app/pages/function/general_dialog.dart';
import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DiscussInput extends StatefulWidget {
  kObjectFunctionBlock postHandle;
  DiscussInput({
    Key key,
    this.postHandle,
  }) : super(key: key);

  @override
  _DiscussInputState createState() => _DiscussInputState();

  show(BuildContext context, {Color backgroundColor}) {
    if (backgroundColor == null) {
      backgroundColor = Color.fromRGBO(0, 0, 0, 0.4);
    }

    GeneralDialog().show(
      context,
      backgroundPadding: EdgeInsets.zero,
      backgroundAlignment: Alignment.bottomCenter,
      containerContent: this,
      barrierDismissible: true,
      backgroundColor: backgroundColor,
    );
  }
}

class _DiscussInputState extends State<DiscussInput> {
  TextEditingController _editingController = TextEditingController();

  // 发布评论
  void _postComment() {
    if (ObjectUtil.isEmptyString(_editingController.text) == false) {
      String _text = _editingController.text;
      setState(() {
        _editingController.text = "";
      });

      Navigator.of(context).pop();
      Future.delayed(Duration(milliseconds: 300), () {
        if (this.widget.postHandle != null) {
          this.widget.postHandle(_text);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          16,
          21,
          16,
          15.5 +
              MediaQuery.of(context).padding.bottom +
              MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: 100,
                  ),
                  child: TextField(
                    autofocus: true,
                    maxLines: null,
                    style: TextStyle(
                      color: rgba(50, 50, 50, 1),
                      fontSize: 14,
                    ),
                    controller: _editingController,
                    decoration: InputDecoration(
                      hintText: "留下你的精彩讨论吧",
                      hintStyle: TextStyle(
                        color: rgba(153, 153, 153, 1),
                        fontSize: 14,
                      ),
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              InkWell(
                onTap: () {
                  this._postComment();
                },
                child: Image.asset(
                  "images/input_bar_send@3x.png",
                  width: 30,
                  height: 30,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 36,
          ),
          InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(27 / 2),
            child: Image.asset(
              "images/input_bar_icon@3x.png",
              width: 27,
              height: 27,
            ),
          ),
        ],
      ),
    );
  }
}
