import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hksy_flutter/pages/coin/transfercomplete.dart';
import 'package:hksy_flutter/public/public.dart';
import 'package:image_pickers/Media.dart';
import 'package:image_pickers/UIConfig.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';

class CashRecharge extends StatefulWidget {
  CashRecharge({Key key}) : super(key: key);

  @override
  _CashRechargeState createState() => _CashRechargeState();
}

class _CashRechargeState extends State<CashRecharge> {
  TextEditingController _numberEditingController = TextEditingController();
  int _maxImages = 9;
  List<File> _selectFiles = [
    File("images/addImg@3x.png"),
  ];

  List<String> _paymentItems = [
    "收款方户名：",
    "收款方开户行：",
    "收款方账号：",
  ];

  void _confirmAction() {
    if (isStringEmpty(_numberEditingController.text) ||
        double.parse(_numberEditingController.text) <= 0.0) {
      showToast("请输入金额,必须大于0", context);
      return;
    }

    if (_selectFiles.length <= 1) {
      showToast("请上传凭证", context);
      return;
    }

    FocusScope.of(context).requestFocus(FocusNode());
    this._uploadImages();
  }

  void _uploadImages() {
    XsProgressHud hud = initHUD(context);
    Future.delayed(Duration(milliseconds: 800), () {
      hideHUD(hud);
      this._confirmRecharge();
    });
  }

  void _confirmRecharge() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return TransferComplete(
            completeType: 2,
          );
        },
      ),
    );

    Future.delayed(Duration(milliseconds: 400), () {
      this._emptyInput();
    });
  }

  void _emptyInput() {
    setState(() {
      _numberEditingController.text = "";
      _selectFiles = [
        File("images/addImg@3x.png"),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      appBar: customAppBar(
        title: "现金充值",
        brightness: Brightness.dark,
        backgroundColor: kMainBackgroundColor,
        color: Colors.white,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(12, 15.5, 12, 0),
              padding: EdgeInsets.fromLTRB(20, 20.5, 10.5, 12.5),
              decoration: BoxDecoration(
                color: rgba(28, 35, 63, 1),
                borderRadius: BorderRadius.circular(7.5),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "请按提示信息向我司付款",
                      style: TextStyle(
                        fontSize: 18,
                        color: rgba(255, 255, 255, 1),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12.5,
                  ),
                  Column(
                    children: _paymentItems.map(
                      (item) {
                        var index = _paymentItems.indexOf(item);
                        return Container(
                          height: 54,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                item,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: rgba(255, 255, 255, 1),
                                ),
                              ),
                              Expanded(
                                child: Container(),
                              ),
                              Text(
                                "请联系销售人员或者相关人员",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: rgba(145, 152, 173, 1),
                                ),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            border: index < _paymentItems.length - 1
                                ? Border(
                                    bottom: BorderSide(
                                        color: rgba(145, 152, 173, 0.2),
                                        width: 0.5),
                                  )
                                : Border(),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
              padding: EdgeInsets.fromLTRB(20, 20.5, 10.5, 45),
              decoration: BoxDecoration(
                color: rgba(28, 35, 63, 1),
                borderRadius: BorderRadius.circular(7.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "付款完成后提交凭证",
                      style: TextStyle(
                        fontSize: 18,
                        color: rgba(255, 255, 255, 1),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    height: 54,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "转账金额：",
                          style: TextStyle(
                            fontSize: 15,
                            color: rgba(255, 255, 255, 1),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: _numberEditingController,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 13,
                              color: rgba(255, 255, 255, 1),
                            ),
                            decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: "请输入充值金额",
                              hintStyle: TextStyle(
                                fontSize: 13,
                                color: rgba(145, 152, 173, 1),
                              ),
                            ),
                            inputFormatters: [
                              WhitelistingTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(18),
                            ],
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            color: rgba(145, 152, 173, 0.2), width: 0.5),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "上传充值凭证",
                    style: TextStyle(
                      fontSize: 15,
                      color: rgba(255, 255, 255, 1),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 36, 0, 0),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: _selectFiles.map(
                        (file) {
                          var index = _selectFiles.indexOf(file);
                          var isAdd = file.path == "images/addImg@3x.png";
                          return Container(
                            width: 259,
                            height: 138.5,
                            margin: EdgeInsets.fromLTRB(
                                0, index == 0 ? 0 : 12, 0, 0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: rgba(21, 25, 54, 1),
                              borderRadius: BorderRadius.circular(7.5),
                            ),
                            child: Stack(
                              children: <Widget>[
                                FlatButton(
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7.5),
                                  ),
                                  onPressed: () {
                                    if (isAdd) {
                                      ImagePickers.pickerPaths(
                                        selectCount: _maxImages -
                                            (_selectFiles.length - 1),
                                        showCamera: true,
                                        uiConfig: UIConfig(
                                            uiThemeColor: Colors.black),
                                      ).then((List medias) {
                                        List<File> tempFiles = [];
                                        for (Media item in medias) {
                                          tempFiles.add(
                                            File(item.path),
                                          );
                                        }

                                        List<File> _lastList = _selectFiles;
                                        if (_selectFiles.length < _maxImages) {
                                          _lastList
                                              .removeAt(_lastList.length - 1);
                                        }

                                        _lastList.addAll(tempFiles);
                                        if (_lastList.length < _maxImages) {
                                          _lastList.add(
                                            File("images/addImg@3x.png"),
                                          );
                                        }

                                        setState(() {
                                          _selectFiles = _lastList;
                                        });
                                      });
                                    }
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(7.5),
                                    child: isAdd
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Image.asset(
                                                "images/addImg@3x.png",
                                                width: 27,
                                                fit: BoxFit.fitWidth,
                                              ),
                                              SizedBox(
                                                height: 11.5,
                                              ),
                                              Text(
                                                "点击上传",
                                                style: TextStyle(
                                                  color: rgba(255, 255, 255, 1),
                                                  fontSize: 11,
                                                ),
                                              ),
                                            ],
                                          )
                                        : Image.file(
                                            file,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                                Positioned(
                                  top: -7,
                                  right: -7,
                                  child: isAdd
                                      ? Container()
                                      : IconButton(
                                          icon: Image.asset(
                                            "images/ico_del@3x.png",
                                            width: 20,
                                            height: 20,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _selectFiles.removeAt(index);

                                              bool insertAdd = true;
                                              for (var item in _selectFiles) {
                                                if (item.path ==
                                                    "images/addImg@3x.png") {
                                                  insertAdd = false;
                                                  break;
                                                }
                                              }

                                              if (insertAdd) {
                                                _selectFiles.add(
                                                  File("images/addImg@3x.png"),
                                                );
                                              }
                                            });
                                          },
                                        ),
                                ),
                              ],
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 80,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
              decoration: BoxDecoration(
                color: rgba(23, 96, 255, 1),
                borderRadius: BorderRadius.circular(7.5),
              ),
              child: FlatButton(
                padding: EdgeInsets.fromLTRB(30, 14, 30, 15),
                onPressed: () {
                  this._confirmAction();
                },
                child: Text(
                  "确认充值",
                  style: TextStyle(
                    fontSize: 15,
                    color: rgba(255, 255, 255, 1),
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.5),
                ),
              ),
            ),
            SizedBox(
              height: 29,
            ),
            Text(
              "温馨提示，如有任何疑问请联系在线客服\n（请在工作日9:00-17:00之间转账）",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: rgba(145, 152, 173, 1),
                height: 2,
              ),
            ),
            SizedBox(
              height: 45 + MediaQuery.of(context).padding.bottom,
            ),
          ],
        ),
      ),
    );
  }
}
