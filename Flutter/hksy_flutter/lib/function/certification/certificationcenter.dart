import 'package:flutter/material.dart';
import 'package:hksy_flutter/function/actionsheet.dart';
import 'package:hksy_flutter/function/certification/certificationinfo.dart';
import 'package:hksy_flutter/function/certification/certificationmain.dart';
import 'package:hksy_flutter/function/infosectioncell.dart';
import 'package:hksy_flutter/public/public.dart';

class CertificationCenter extends StatefulWidget {
  CertificationCenter({Key key}) : super(key: key);

  @override
  _CertificationCenterState createState() => _CertificationCenterState();
}

class _CertificationCenterState extends State<CertificationCenter> {
  Map _account = {};

  void _refreshAccount() {
    setState(() {
      _account = currentAcctount;
    });
  }

  @override
  void didUpdateWidget(CertificationCenter oldWidget) {
    super.didUpdateWidget(oldWidget);

    this._refreshAccount();
  }

  @override
  void initState() {
    super.initState();
    this._refreshAccount();
  }

  Widget _accountInfo() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 26.5, 12, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _account["avater"] != null && "${_account["avater"]}".length > 0
                  ? Image.network(
                      "${_account["avater"]}",
                      width: 59,
                      height: 59,
                    )
                  : Image.asset(
                      "images/default_avatar@3x.png",
                      width: 59,
                      height: 59,
                    ),
              SizedBox(
                width: 19.5,
              ),
              Expanded(
                child: Text(
                  "${_account["nickname"]}".length > 0
                      ? "${_account["nickname"]}"
                      : "",
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
        _account["personalStatus"] == 1 ? "已实名" : "未验证", //未验证
        style: TextStyle(
          fontSize: 15,
          color: rgba(255, 255, 255, 1),
        ),
      ),
      decoration: BoxDecoration(
        color: _account["personalStatus"] == 1
            ? rgba(23, 96, 255, 1)
            : rgba(145, 152, 173, 1), //rgba(145, 152, 173, 1)
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
                value: _account["personalStatus"] == 1 ? "已上传" : "未完善",
                tapHandle: () {
                  if (_account["personalStatus"] == 1) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return CertificationInfo();
                        },
                      ),
                    );
                  } else {
                    showToast("未实名", context);
                  }
                },
              ),
              InfoCell(
                name: "身份验证",
                value: _account["personalStatus"] == 1 ? "已上传" : "未完善",
                showLine: false,
                tapHandle: () {
                  ActionSheet(
                    cancel: "取消",
                    titles: [
                      "大陆身份证",
                      "其他证件",
                    ],
                    handle: (isCancel, index) {
                      if (isCancel == false) {
                        if (_account["personalStatus"] == 1) {
                          showToast("已实名", context);
                        } else {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return CertificationMain(
                                  type: index,
                                );
                              },
                            ),
                          );
                        }
                      }
                    },
                  ).show(context);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
