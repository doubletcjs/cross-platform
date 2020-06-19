import 'package:christian_picker_image/christian_picker_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:hksy_flutter/function/certification/certificationcenter.dart';
import 'package:hksy_flutter/function/infosectioncell.dart';
import 'package:hksy_flutter/pages/personal/editnickname.dart';
import 'package:hksy_flutter/public/public.dart';

class PersonInfo extends StatefulWidget {
  PersonInfo({Key key}) : super(key: key);

  @override
  _PersonInfoState createState() => _PersonInfoState();
}

class _PersonInfoState extends State<PersonInfo> {
  Map _account = {};

  void _refreshAccount() {
    fetchUser((obj) {
      Map info = Map.from(obj);
      setState(() {
        _account = info;
      });
    });
  }

  @override
  void didUpdateWidget(PersonInfo oldWidget) {
    super.didUpdateWidget(oldWidget);

    this._refreshAccount();
  }

  @override
  void initState() {
    super.initState();
    this._refreshAccount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      appBar: customAppBar(
        title: "个人信息",
        brightness: Brightness.dark,
        backgroundColor: kMainBackgroundColor,
        color: Colors.white,
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(12, 20, 12, 0),
        children: <Widget>[
          InfoSection(
            cells: [
              InfoCell(
                padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
                name: "头像",
                isPortrait: true,
                tapHandle: () {
                  ChristianPickerImage.pickImages(
                    maxImages: 1,
                  ).then((value) {});
                },
              ),
              InfoCell(
                name: "昵称",
                value: "${_account["nickname"]}",
                tapHandle: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return EditNickName();
                    }),
                  );
                },
              ),
              InfoCell(
                name: "账号",
                showLine: false,
                showArrow: false,
                value: "${_account["phone"]}".length == 11
                    ? TextUtil.hideNumber("${_account["phone"]}")
                    : "",
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          InfoSection(
            cells: [
              InfoCell(
                name: "实名认证",
                showLine: false,
                value: _account["personalStatus"] == 1 ? "已认证" : "未认证",
                tapHandle: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return CertificationCenter();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
