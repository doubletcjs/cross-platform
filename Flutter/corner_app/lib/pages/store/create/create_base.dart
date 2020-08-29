import 'package:corner_app/pages/store/create/create_detail.dart';
import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

class CreateBase extends StatefulWidget {
  CreateBase({Key key}) : super(key: key);

  @override
  _CreateBaseState createState() => _CreateBaseState();
}

class _CreateBaseState extends State<CreateBase> {
  var _cover;
  // 下一步
  void _createDetail() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return CreateDetail();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rgba(255, 255, 255, 1),
      appBar: customAppBar(
        leftItems: [
          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "取消",
                style: TextStyle(
                  color: rgba(51, 51, 51, 1),
                  fontSize: 16,
                ),
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
              onPressed: () {
                this._createDetail();
              },
              child: Text(
                "下一步",
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
            top: 28,
            left: 16,
            right: 16,
          ),
          children: [
            // 封面
            Container(
              width: 226,
              height: 301,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                children: [
                  Image.asset(
                    "images/creation_image_cover@3x.png",
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 11.5,
                    right: 4.5,
                    width: 52,
                    height: 52,
                    child: FlatButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      child: Image.asset(
                        "images/creation_image_addition@3x.png",
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(52 / 2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 28,
            ),
            // 输入框
            Container(
              height: 40,
              decoration: BoxDecoration(
                color: rgba(247, 246, 245, 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: rgba(50, 50, 50, 1),
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  hintText: "请输入角落名称",
                  hintStyle: TextStyle(
                    color: rgba(153, 153, 153, 1),
                    fontSize: 14,
                  ),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
