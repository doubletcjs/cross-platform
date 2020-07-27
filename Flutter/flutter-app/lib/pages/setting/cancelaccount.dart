import 'package:flutter/material.dart';
import '../../public/public.dart';
import 'views/settingsectioncell.dart';

class CancelAccountPage extends StatefulWidget {
  CancelAccountPage({Key key}) : super(key: key);

  @override
  _CancelAccountPageState createState() => _CancelAccountPageState();
}

class _CancelAccountPageState extends State<CancelAccountPage> {
  List<String> _reasonList = [
    "我已经找到我的理想型了",
    "我找不到我想要的",
    "我觉得不安全",
    "这个软件不适合我",
    "我以后再来",
    "保密",
  ];

  List<int> _reasonIndex = [];

  //理由cell
  Widget _reasonCell(index) {
    return Column(
      children: <Widget>[
        Container(
          height: 44,
          color: Colors.white,
          padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                _reasonList[index],
                style: TextStyle(
                  fontSize: 15,
                  color: rgba(51, 51, 51, 1),
                ),
              ),
              IconButton(
                icon: Icon(
                  _reasonIndex.indexOf(index) >= 0
                      ? Icons.check_box
                      : Icons.check_box_outline_blank,
                  color: _reasonIndex.indexOf(index) >= 0
                      ? rgba(255, 44, 96, 1)
                      : rgba(153, 153, 153, 1),
                ),
                onPressed: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  setState(() {
                    if (_reasonIndex.indexOf(index) >= 0) {
                      _reasonIndex.remove(index);
                    } else {
                      _reasonIndex.add(index);
                    }
                  });
                },
              ),
            ],
          ),
        ),
        index == _reasonList.length - 1
            ? Container()
            : Container(
                height: 0.5,
                color: rgba(233, 233, 233, 1),
              ),
      ],
    );
  }

  //注销
  void _onCancelConfirm() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rgba(248, 248, 248, 1),
      appBar: customAppBar(
        title: "注销账号",
        elevation: 0.5,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: ListView(
          children: <Widget>[
            //账户注销提示
            Container(
              color: rgba(248, 248, 248, 1),
              padding: EdgeInsets.fromLTRB(13.5, 8, 13.5, 8),
              alignment: Alignment.centerLeft,
              child: Text(
                "账户注销后您的个人主页不会被看见",
                style: TextStyle(
                  fontSize: 11,
                  color: rgba(188, 188, 188, 1),
                ),
              ),
            ),
            //注销原因
            SettingBaseSection(
              title: "注销原因",
            ),
            Column(
              children: _reasonList.map((reason) {
                return _reasonCell(_reasonList.indexOf(reason));
              }).toList(),
            ),
            //反馈
            SettingBaseSection(
              title: "反馈",
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: TextField(
                maxLines: 4,
                style: TextStyle(
                  color: rgba(51, 51, 51, 1),
                  fontSize: 14,
                ),
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: "给我们一些建议？",
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
            //注销
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
                  this._onCancelConfirm();
                },
                child: Text(
                  "注销",
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
