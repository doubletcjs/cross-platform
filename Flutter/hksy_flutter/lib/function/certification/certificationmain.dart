import 'dart:io';

import 'package:common_utils/common_utils.dart';
import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/material.dart';
import 'package:hksy_flutter/function/certification/pages/certificationbank.dart';
import 'package:hksy_flutter/function/certification/pages/certificationbase.dart';
import 'package:hksy_flutter/function/certification/pages/certificationphone.dart';
import 'package:hksy_flutter/public/public.dart';
import 'package:hksy_flutter/public/networking.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';

import '../../public/public.dart';
import '../../public/public.dart';
import '../../public/public.dart';
import '../../public/public.dart';
import '../account/api/accountapi.dart';

class CertificationMain extends StatefulWidget {
  int type = 0;
  CertificationMain({Key key, this.type = 0}) : super(key: key);

  @override
  _CertificationMainState createState() => _CertificationMainState();
}

class _CertificationMainState extends State<CertificationMain> {
  int _currentIndex = 0;
  Map _uploadPackage = {};

  List<String> _certificationItems = [
    "身份认证",
    "绑定手机",
    "绑定银行卡",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      appBar: customAppBar(
        title: this.widget.type == 0 ? "身份证验证" : "其它证验证",
        brightness: Brightness.dark,
        backgroundColor: kMainBackgroundColor,
        color: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(44, 0, 44, 0),
            color: rgba(28, 35, 63, 1),
            height: 72.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(11, 0, 18, 0),
                  child: Image.asset(
                    "images/xuhao${_currentIndex + 1}@3x.png",
                    // height: 19.5 * 1.4,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _certificationItems.map((item) {
                    int index = _certificationItems.indexOf(item);
                    return Text(
                      item,
                      style: TextStyle(
                        color: index == _currentIndex
                            ? rgba(255, 255, 255, 1)
                            : rgba(145, 152, 173, 1),
                        fontSize: 11.5,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Expanded(
            child: _currentIndex == 0
                ? CertificationBase(
                    inputHandle: (package) {
                      setState(() {
                        _uploadPackage["identityImgReverse"] =
                            package["reverse"];
                        _uploadPackage["identityImgFront"] = package["front"];
                        _uploadPackage["name"] = package["name"];
                        _uploadPackage["idcard"] = package["idcard"];
                      });
                    },
                  )
                : _currentIndex == 1
                    ? CertificationPhone(
                        inputHandle: (package) {
                          setState(() {
                            _uploadPackage["phone"] = package["phone"];
                          });
                        },
                      )
                    : CertificationBank(
                        inputHandle: (package) {
                          setState(() {
                            _uploadPackage["bankcard"] = package["bankcard"];
                            _uploadPackage["bankname"] = package["bankname"];
                            _uploadPackage["bankaddress"] =
                                package["bankaddress"];
                          });
                        },
                      ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(
                12, 0, 12, 48.5 + MediaQuery.of(context).padding.bottom),
            height: 49,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: rgba(23, 96, 255, 1),
              borderRadius: BorderRadius.circular(7.5),
            ),
            child: FlatButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                if (_currentIndex == 0) {
                  if (isStringEmpty(_uploadPackage["name"])) {
                    showToast("请输入姓名", context);
                    return;
                  }

                  var idcard = "身份证";
                  if (this.widget.type == 0) {
                    //身份证
                    if (RegexUtil.isIDCard18Exact(_uploadPackage["idcard"]) ==
                        false) {
                      showToast("请输入正确的身份证号", context);
                      return;
                    }
                  } else {
                    idcard = "证件";
                    //其它证件
                    if (isStringEmpty(_uploadPackage["idcard"])) {
                      showToast("请输入证件号码", context);
                      return;
                    }
                  }

                  if (isStringEmpty(_uploadPackage["identityImgFront"])) {
                    showToast("请上传$idcard" + "正面图片", context);
                    return;
                  }

                  if (isStringEmpty(_uploadPackage["identityImgReverse"])) {
                    showToast("请上传$idcard" + "反面图片", context);
                    return;
                  }
                } else if (_currentIndex == 1) {
                  if (RegexUtil.isMobileExact(_uploadPackage["phone"]) ==
                      false) {
                    showToast("请输入正确的手机号", context);
                    return;
                  }
                } else if (_currentIndex == 2) {
                  if (isStringEmpty(_uploadPackage["bankcard"])) {
                    showToast("请输入银行卡号", context);
                    return;
                  }

                  if (isStringEmpty(_uploadPackage["bankaddress"])) {
                    showToast("请输入开户行地址", context);
                    return;
                  }
                }

                setState(() {
                  if (_currentIndex == 2) {
                    XsProgressHud hud = initHUD(context);
                    Networking.uploadFiles("uploadImgs", [
                      File(_uploadPackage["identityImgFront"]),
                      File(_uploadPackage["identityImgReverse"]),
                    ], (data, msg) {
                      if (data != null) {
                        var list = List.from(data);
                        if (list.length == 2) {
                          hideHUD(hud);
                          showToast("图片上传失败!", context);
                        } else {
                          _uploadPackage["identityImgFront"] = list[0];
                          _uploadPackage["identityImgReverse"] = list[1];

                          AccountApi.authentication(_uploadPackage,
                              (data, msg) {
                            if (data != null) {
                              hideHUD(hud);
                              showToast("认证提交成功", context);
                              DartNotificationCenter.post(
                                  channel: kRefreshAccountNotification);

                              Future.delayed(Duration(milliseconds: 1600), () {
                                Navigator.of(context).pop();
                              });
                            } else {
                              hideHUD(hud);
                              showToast(msg, context);
                            }
                          });
                        }
                      } else {
                        hideHUD(hud);
                        showToast(msg, context);
                      }
                    });
                  } else {
                    _currentIndex += 1;
                  }
                });
              },
              child: Text(
                _currentIndex == 2 ? "提交信息" : "下一步",
                style: TextStyle(
                  color: rgba(255, 255, 255, 1),
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
