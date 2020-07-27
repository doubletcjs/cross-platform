import 'package:flutter/material.dart';
import '../../public/public.dart';
import 'views/settingsectioncell.dart';

class FeedBackPage extends StatefulWidget {
  FeedBackPage({Key key}) : super(key: key);

  @override
  _FeedBackPageState createState() => _FeedBackPageState();
}

class _FeedBackPageState extends State<FeedBackPage> {
  //提交
  void _onConfirm() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rgba(248, 248, 248, 1),
      appBar: customAppBar(
        title: "意见反馈",
        elevation: 0.5,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: ListView(
          children: <Widget>[
            SettingBaseSection(),
            //反馈内容
            Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: TextField(
                maxLines: 6,
                style: TextStyle(
                  color: rgba(51, 51, 51, 1),
                  fontSize: 14,
                ),
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: "请留下您宝贵的意见，我们会及时回复您",
                  hintStyle: TextStyle(
                    color: rgba(171, 171, 171, 1),
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            //分割线
            Container(
              color: Colors.white,
              child: Container(
                height: 0.5,
                color: rgba(233, 233, 233, 1),
              ),
            ),
            //联系方式
            Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: TextField(
                style: TextStyle(
                  color: rgba(51, 51, 51, 1),
                  fontSize: 14,
                ),
                textInputAction: TextInputAction.done,
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
              height: 20,
            ),
            //提交
            Container(
              height: 44,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.fromLTRB(22, 0, 22, 0),
              decoration: BoxDecoration(
                color: rgba(216, 216, 216, 1),
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
