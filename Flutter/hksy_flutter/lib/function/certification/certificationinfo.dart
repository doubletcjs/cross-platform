import 'package:flutter/material.dart';
import 'package:hksy_flutter/function/infosectioncell.dart';
import 'package:hksy_flutter/public/public.dart';

class CertificationInfo extends StatefulWidget {
  CertificationInfo({Key key}) : super(key: key);

  @override
  _CertificationInfoState createState() => _CertificationInfoState();
}

class _CertificationInfoState extends State<CertificationInfo> {
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
      body: ListView.builder(
        padding: EdgeInsets.fromLTRB(12, 20, 12, 0),
        itemBuilder: (content, index) {
          return Column(
            children: <Widget>[
              InfoSection(
                cells: <Widget>[
                  InfoCell(
                    name: "姓名",
                    value: "云小宝",
                    showArrow: false,
                  ),
                  InfoCell(
                    name: "证件",
                    value: "身份证",
                    showArrow: false,
                  ),
                  InfoCell(
                    name: "证件号码",
                    value: "456014**********54",
                    showArrow: false,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              InfoSection(
                cells: <Widget>[
                  InfoCell(
                    name: "实名手机号",
                    value: "151****5578",
                    showArrow: false,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              InfoSection(
                cells: <Widget>[
                  InfoCell(
                    name: "银行卡",
                    value: "6002************** 865",
                    showArrow: false,
                  ),
                  InfoCell(
                    name: "持卡银行",
                    value: "招商银行",
                    showArrow: false,
                  ),
                  InfoCell(
                    name: "开户支行",
                    value: "广州体育支行",
                    showArrow: false,
                    showLine: false,
                  ),
                ],
              ),
            ],
          );
        },
        itemCount: 1,
      ),
    );
  }
}
