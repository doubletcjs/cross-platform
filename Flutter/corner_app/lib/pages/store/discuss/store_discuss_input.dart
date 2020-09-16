import 'package:corner_app/pages/function/general_dialog.dart';
import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

class StoreDiscussInput extends StatefulWidget {
  StoreDiscussInput({Key key}) : super(key: key);

  @override
  _StoreDiscussInputState createState() => _StoreDiscussInputState();

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

class _StoreDiscussInputState extends State<StoreDiscussInput> {
  TextEditingController _editingController = TextEditingController();

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
                    maxHeight: 120,
                  ),
                  child: TextField(
                    autofocus: true,
                    maxLines: null,
                    controller: _editingController,
                    decoration: InputDecoration(
                      hintText: "留下你的精彩讨论吧",
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
                onTap: () {},
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
