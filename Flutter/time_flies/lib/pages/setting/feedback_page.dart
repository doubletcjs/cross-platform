import 'package:flutter/material.dart';
import 'package:time_flies/public/public.dart';

class FeedBackPage extends StatefulWidget {
  FeedBackPage({Key key}) : super(key: key);

  @override
  _FeedBackPageState createState() => _FeedBackPageState();
}

class _FeedBackPageState extends State<FeedBackPage> {
  TextEditingController _contentEditingController = TextEditingController();
  TextEditingController _contactEditingController = TextEditingController();

  //提交
  void _onConfirm() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "意见反馈",
        defaultBack: true,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: ListView(
          children: <Widget>[
            //反馈内容
            Container(
              margin: EdgeInsets.fromLTRB(14, 10, 14, 0),
              padding: EdgeInsets.fromLTRB(19, 0, 19, 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                maxLines: 8,
                maxLength: 300,
                style: TextStyle(
                  color: rgba(51, 51, 51, 1),
                  fontSize: 14,
                ),
                textInputAction: TextInputAction.done,
                controller: _contentEditingController,
                decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: "感谢您使用尓蒙APP，请详细说明，以便我们为您解决问题。",
                  hintStyle: TextStyle(
                    color: rgba(153, 153, 153, 1),
                    fontSize: 13,
                  ),
                  helperStyle: TextStyle(
                    color: rgba(153, 153, 153, 1),
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            //联系方式
            Container(
              margin: EdgeInsets.fromLTRB(14, 12, 14, 0),
              padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                style: TextStyle(
                  color: rgba(51, 51, 51, 1),
                  fontSize: 14,
                ),
                textInputAction: TextInputAction.done,
                controller: _contactEditingController,
                decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: "您的联系方式（手机号、微信号、QQ号）",
                  hintStyle: TextStyle(
                    color: rgba(171, 171, 171, 1),
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40.5,
            ),
            //提交
            Container(
              height: 44,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.fromLTRB(22, 0, 22, 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(44 / 2),
                gradient: LinearGradient(
                  colors: [
                    rgba(255, 44, 96, 1),
                    rgba(255, 114, 81, 1),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: FlatButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  this._onConfirm();
                },
                child: Text(
                  "提交",
                  style: TextStyle(
                    fontSize: 16,
                    color: rgba(255, 255, 255, 1),
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(44 / 2),
                ),
              ),
            ),
            SizedBox(
              height: 44,
            ),
          ],
        ),
      ),
    );
  }
}
