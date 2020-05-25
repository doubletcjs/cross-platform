import 'package:flutter/material.dart';
import 'package:hksy_flutter/function/certification/certificationinfo.dart';
import 'package:hksy_flutter/function/infosectioncell.dart';
import 'package:hksy_flutter/public/public.dart';

class CertificationCenter extends StatefulWidget {
  CertificationCenter({Key key}) : super(key: key);

  @override
  _CertificationCenterState createState() => _CertificationCenterState();
}

class _CertificationCenterState extends State<CertificationCenter> {
  Widget _accountInfo() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 26.5, 12, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.asset(
                "images/default_avatar@3x.png",
                width: 59,
                height: 59,
              ),
              SizedBox(
                width: 19.5,
              ),
              Expanded(
                child: Text(
                  "ID12347865",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 20,
                    color: rgba(255, 255, 255, 1),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "个人隐私信息安全保障中",
            style: TextStyle(
              fontSize: 13,
              color: rgba(145, 152, 173, 1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _certificationStatus() {
    return Container(
      padding: EdgeInsets.fromLTRB(20.5, 12, 12, 12),
      child: Text(
        "已实名",
        style: TextStyle(
          fontSize: 15,
          color: rgba(255, 255, 255, 1),
        ),
      ),
      decoration: BoxDecoration(
        color: rgba(23, 96, 255, 1),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(22.5),
          bottomLeft: Radius.circular(22.5),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      appBar: customAppBar(
        title: "身份管理中心",
        brightness: Brightness.dark,
        backgroundColor: kMainBackgroundColor,
        color: Colors.white,
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(12, 20, 12, 0),
        children: <Widget>[
          InfoSection(
            padding: EdgeInsets.fromLTRB(20, 15, 0, 17.5),
            cells: <Widget>[
              InfoCell(
                padding: EdgeInsets.zero,
                showLine: false,
                leftChild: _accountInfo(),
                rightChild: _certificationStatus(),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          InfoSection(
            cells: <Widget>[
              InfoCell(
                name: "实名信息",
                value: "未完善",
                tapHandle: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return CertificationInfo();
                      },
                    ),
                  );
                },
              ),
              InfoCell(
                name: "身份验证",
                value: "未完善",
                showLine: false,
              ),
            ],
          )
        ],
      ),
    );
  }
}
