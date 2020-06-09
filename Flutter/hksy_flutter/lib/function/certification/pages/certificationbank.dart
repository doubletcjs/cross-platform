import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hksy_flutter/public/public.dart';

typedef kCertificationBlock = void Function(Map object);

class CertificationBank extends StatefulWidget {
  kCertificationBlock inputHandle;
  CertificationBank({Key key, this.inputHandle}) : super(key: key);

  @override
  _CertificationBankState createState() => _CertificationBankState();
}

class _CertificationBankState extends State<CertificationBank> {
  TextEditingController _bankCardEditingController = TextEditingController();
  TextEditingController _bankNameEditingController = TextEditingController();
  TextEditingController _addressEditingController = TextEditingController();

  void _handlInfo() {
    if (this.widget.inputHandle != null) {
      this.widget.inputHandle({
        "bankcard": _bankCardEditingController.text,
        "bankname": _bankNameEditingController.text,
        "bankaddress": _addressEditingController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: ListView(
        padding: EdgeInsets.fromLTRB(12, 12, 12, 0),
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(20, 20.5, 10.5, 0),
            decoration: BoxDecoration(
              color: rgba(28, 35, 63, 1),
              borderRadius: BorderRadius.circular(7.5),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "填写银行卡信息",
                    style: TextStyle(
                      fontSize: 18,
                      color: rgba(255, 255, 255, 1),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.5,
                ),
                Container(
                  height: 60.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "银行卡号：",
                        style: TextStyle(
                          fontSize: 15,
                          color: rgba(255, 255, 255, 1),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: TextField(
                          controller: _bankCardEditingController,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 15,
                            color: rgba(255, 255, 255, 1),
                          ),
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: "请输入银行卡号",
                            hintStyle: TextStyle(
                              fontSize: 15,
                              color: rgba(145, 152, 173, 1),
                            ),
                          ),
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(11),
                          ],
                          keyboardType: TextInputType.number,
                          onChanged: (text) {
                            this._handlInfo();
                          },
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: rgba(21, 25, 54, 1),
                        width: 0.5,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 60.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "持卡银行：",
                        style: TextStyle(
                          fontSize: 15,
                          color: rgba(255, 255, 255, 1),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: TextField(
                          controller: _bankNameEditingController,
                          textAlign: TextAlign.right,
                          enabled: false,
                          style: TextStyle(
                            fontSize: 15,
                            color: rgba(255, 255, 255, 1),
                          ),
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: "获取持卡银行",
                            hintStyle: TextStyle(
                              fontSize: 15,
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
                        color: rgba(21, 25, 54, 1),
                        width: 0.5,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 60.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "开户支行：",
                        style: TextStyle(
                          fontSize: 15,
                          color: rgba(255, 255, 255, 1),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: TextField(
                          controller: _addressEditingController,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 15,
                            color: rgba(255, 255, 255, 1),
                          ),
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: "请输入开户支行地址",
                            hintStyle: TextStyle(
                              fontSize: 15,
                              color: rgba(145, 152, 173, 1),
                            ),
                          ),
                          onChanged: (text) {
                            this._handlInfo();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
