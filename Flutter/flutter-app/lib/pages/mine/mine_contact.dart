import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';
import '../../public/public.dart';
import 'api/member_api.dart';

class MineContact extends StatefulWidget {
  Map account;
  MineContact({Key key, this.account}) : super(key: key);

  @override
  _MineContactState createState() => _MineContactState();
}

class _MineContactState extends State<MineContact> {
  List<String> _contactIcons = [
    "images/contact_mobile@3x.png",
    "images/contact_wechat@3x.png",
    "images/contact_qq@3x.png",
    "images/contact_douyin@3x.png",
  ];

  List<String> _contactValues = List<String>.generate(4, (int index) => "");

  //获取联系方式
  void _getContact() {
    XsProgressHud.show(context);
    MemberApi.getContact(this.widget.account["id"], (data, msg) {
      if (data != null) {
        setState(() {
          _contactValues[0] = data["wechat"] ?? "";
          _contactValues[1] = data["tel"] ?? "";
          _contactValues[2] = data["qq"] ?? "";
          _contactValues[3] = data["douyin"] ?? "";
        });
        Future.delayed(Duration(milliseconds: 600), () {
          XsProgressHud.hide();
        });
      } else {
        XsProgressHud.hide();
        showToast(msg, context);
      }
    });
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 300), () {
      this._getContact();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rgba(248, 248, 248, 1),
      appBar: customAppBar(
        title: "联系方式",
        elevation: 0.5,
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return Container(
            color: rgba(255, 255, 255, 1),
            padding: EdgeInsets.fromLTRB(20, 20.5, 13.5, 12),
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
                  child: SelectableText(
                    _contactValues[index],
                    style: TextStyle(
                      color: rgba(0, 0, 0, 1),
                      fontSize: 14,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: _contactValues[index]));
                    showToast("复制成功", context);
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        "images/fuzhi.png",
                        width: 20,
                        height: 20,
                      ),
                      SizedBox(width: 4,),
                      Text("复制", style: TextStyle(color: rgba(166, 166, 166, 1), fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Container(
            color: rgba(255, 255, 255, 1),
            padding: EdgeInsets.fromLTRB(48, 0, 13.5, 0),
            height: 0.5,
            child: Container(
              color: rgba(85, 85, 85, 0.1),
            ),
          );
        },
        itemCount: _contactIcons.length,
      ),
    );
  }
}
