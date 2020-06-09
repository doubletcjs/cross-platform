import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hksy_flutter/public/public.dart';

typedef kCertificationBlock = void Function(Map object);

class CertificationPhone extends StatefulWidget {
  kCertificationBlock inputHandle;
  CertificationPhone({Key key, this.inputHandle}) : super(key: key);

  @override
  _CertificationPhoneState createState() => _CertificationPhoneState();
}

class _CertificationPhoneState extends State<CertificationPhone> {
  TextEditingController _phoneEditingController = TextEditingController();

  void _handlInfo() {
    if (this.widget.inputHandle != null) {
      this.widget.inputHandle({
        "phone": _phoneEditingController.text,
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
            padding: EdgeInsets.fromLTRB(20, 20.5, 10.5, 30),
            decoration: BoxDecoration(
              color: rgba(28, 35, 63, 1),
              borderRadius: BorderRadius.circular(7.5),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "填写手机信息",
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
                  height: 55.5,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: _phoneEditingController,
                          style: TextStyle(
                            fontSize: 15,
                            color: rgba(255, 255, 255, 1),
                          ),
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: "请输入手机号码",
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
                        color: rgba(145, 152, 173, 1),
                        width: 0.5,
                      ),
                    ),
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
