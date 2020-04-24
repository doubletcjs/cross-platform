import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ideaclass/pages/account/agreementpage.dart';
import 'package:ideaclass/public/public.dart';

class CertificationPage extends StatelessWidget {
  TextEditingController _nameEditingController = TextEditingController();
  TextEditingController _idcardEditingController = TextEditingController();

  void _submitAction(BuildContext context) {
    if (isStringEmpty(_nameEditingController.text) == true ||
        isStringEmpty(_idcardEditingController.text) == true) {
      showToast("请输入真实姓名或身份证号码", context);
      return;
    }

    FocusScope.of(context).requestFocus(FocusNode());
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "提示",
          ),
          content: Text(
            "该身份信息将用于您的实名认证 确认后无法更改，请谨慎填写",
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "取消",
              ),
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
                Future.delayed(
                  Duration(milliseconds: 300),
                  () {},
                );
              },
              child: Text(
                "确认",
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "实名认证",
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          color: rgba(0, 0, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 7,
              ),
              Container(
                color: Colors.white,
                height: 40,
                padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                child: Row(
                  children: <Widget>[
                    Text(
                      "真实姓名",
                      style: TextStyle(
                        fontSize: 14,
                        color: rgba(23, 23, 23, 1),
                      ),
                    ),
                    SizedBox(
                      width: 49,
                    ),
                    Expanded(
                      child: TextField(
                        controller: _nameEditingController,
                        style: TextStyle(
                          fontSize: 14,
                          color: rgba(23, 23, 23, 1),
                        ),
                        decoration: InputDecoration(
                          hasFloatingPlaceholder: false,
                          border: InputBorder.none,
                          hintText: "请输真实姓名",
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: rgba(136, 136, 136, 1),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 1,
              ),
              Container(
                color: Colors.white,
                height: 40,
                padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                child: Row(
                  children: <Widget>[
                    Text(
                      "身份证号码",
                      style: TextStyle(
                        fontSize: 14,
                        color: rgba(23, 23, 23, 1),
                      ),
                    ),
                    SizedBox(
                      width: 34,
                    ),
                    Expanded(
                      child: TextField(
                        controller: _idcardEditingController,
                        style: TextStyle(
                          fontSize: 14,
                          color: rgba(23, 23, 23, 1),
                        ),
                        decoration: InputDecoration(
                          hasFloatingPlaceholder: false,
                          border: InputBorder.none,
                          hintText: "请输入身份证号码",
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: rgba(136, 136, 136, 1),
                          ),
                        ),
                        inputFormatters: [LengthLimitingTextInputFormatter(18)],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(12, 6, 12, 0),
                child: Row(
                  children: <Widget>[
                    Text(
                      "继续表示同意",
                      style: TextStyle(
                        fontSize: 10,
                        color: rgba(136, 136, 136, 1),
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    buttonWidget(
                      Text(
                        "用户协议及隐私条款",
                        style: TextStyle(
                          fontSize: 10,
                          color: kMainColor,
                        ),
                      ),
                      context,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return AgreementPage();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(12, 70, 12, 0),
                height: 49,
                child: FlatButton(
                  onPressed: () {
                    this._submitAction(context);
                  },
                  child: Text(
                    "开始认证",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                decoration: BoxDecoration(
                  color: kMainColor,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
