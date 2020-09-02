import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StoreInfoInput extends StatefulWidget {
  int inputType = 0; //0 名称 1 简介
  kVoidFunctionBlock inputHandle;
  StoreInfoInput({
    Key key,
    this.inputType = 0,
    this.inputHandle,
  }) : super(key: key);

  @override
  _StoreInfoInputState createState() => _StoreInfoInputState();
}

class _StoreInfoInputState extends State<StoreInfoInput> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rgba(255, 255, 255, 1),
      appBar: customAppBar(
        title: this.widget.inputType == 1 ? "角落简介" : "角落名称",
        leftItems: [
          Container(
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Row(
                children: [
                  Image.asset(
                    "images/base_back@3x.png",
                    width: 11,
                    height: 20,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "返回",
                    style: TextStyle(
                      fontSize: 18,
                      color: rgba(51, 51, 51, 1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        rightItems: [
          Container(
            width: 72,
            height: 28,
            decoration: BoxDecoration(
              color: rgba(235, 102, 91, 1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: FlatButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
              child: Text(
                "完成",
                style: TextStyle(
                  fontSize: 14,
                  color: rgba(241, 241, 241, 1),
                ),
              ),
            ),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: ListView(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 34,
          ),
          children: [
            TextField(
              maxLines: this.widget.inputType == 1 ? 4 : 1,
              style: TextStyle(
                fontSize: 16,
                color: rgba(27, 27, 27, 1),
              ),
              decoration: InputDecoration(
                hintText: "输入角落名称",
                hintStyle: TextStyle(
                  fontSize: 16,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 0.5,
                    color: rgba(0, 0, 0, 0.1),
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 0.5,
                    color: rgba(0, 0, 0, 0.1),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
