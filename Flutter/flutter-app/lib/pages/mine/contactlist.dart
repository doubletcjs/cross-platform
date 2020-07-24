import 'package:flutter/material.dart';
import '../../public/public.dart';

class ContactListPage extends StatefulWidget {
  ContactListPage({Key key}) : super(key: key);

  @override
  _ContactListPageState createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  List<String> _contactNames = [
    "手机号",
    "微信号",
    "QQ号",
    "抖音号",
  ];

  List<String> _contactIcons = [
    "images/contact_mobile@3x.png",
    "images/contact_wechat@3x.png",
    "images/contact_qq@3x.png",
    "images/contact_douyin@3x.png",
  ];

  //保存
  void _onSaveConfirm() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rgba(248, 248, 248, 1),
      appBar: customAppBar(
        title: "联系方式",
        elevation: 0.5,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: ListView(
          children: <Widget>[
            //联系方式列表
            Container(
              padding: EdgeInsets.fromLTRB(22, 11.5, 22, 18),
              color: kMainBackgroundColor,
              child: Column(
                children: <Widget>[
                  Text(
                    "请填写一个或多个联系方式，相互喜欢的人可以查看",
                    style: TextStyle(
                      color: rgba(153, 153, 153, 1),
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    height: 20.5,
                  ),
                  Column(
                    children: _contactNames.map((name) {
                      int index = _contactNames.indexOf(name);
                      return Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        padding: EdgeInsets.fromLTRB(14, 0, 20, 0),
                        decoration: BoxDecoration(
                          color: rgba(245, 245, 245, 1),
                          borderRadius: BorderRadius.circular(58 / 2),
                        ),
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              _contactIcons[index],
                              width: 20,
                              height: 20,
                            ),
                            SizedBox(
                              width: 9,
                            ),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  hintText: name,
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: rgba(188, 188, 188, 1),
                                  ),
                                ),
                                keyboardType: index == 0
                                    ? TextInputType.phone
                                    : (index == 1 || index == 2)
                                        ? TextInputType.number
                                        : TextInputType.text,
                                textInputAction: TextInputAction.done,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            //保存
            SizedBox(
              height: 28.5,
            ),
            //完成
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
                  this._onSaveConfirm();
                },
                child: Text(
                  "保存",
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
          ],
        ),
      ),
    );
  }
}
