import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hksy_flutter/function/paycode/paycodeinput.dart';
import 'package:hksy_flutter/public/public.dart';

class CoinRollout extends StatefulWidget {
  CoinRollout({Key key}) : super(key: key);

  @override
  _CoinRolloutState createState() => _CoinRolloutState();
}

class _CoinRolloutState extends State<CoinRollout> {
  TextEditingController _numberEditingController = TextEditingController();

  void _rolloutAll() {
    setState(() {
      _numberEditingController.text = "13420";
    });
  }

  void _confirmRollout() {
    if (isStringEmpty(_numberEditingController.text) == true ||
        double.parse(_numberEditingController.text) <= 0.0) {
      showToast("请输入转出金额", context);
      return;
    }

    PaycodeInput(
      inputHandle: (password) {
        Navigator.of(context).pop();
      },
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      appBar: customAppBar(
        title: "转出",
        brightness: Brightness.dark,
        backgroundColor: kMainBackgroundColor,
        color: Colors.white,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(12, 24.5, 12, 37),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "可转出金币",
                    style: TextStyle(
                      fontSize: 15,
                      color: rgba(145, 152, 173, 1),
                    ),
                  ),
                  Text(
                    "0个",
                    style: TextStyle(
                      fontSize: 15,
                      color: rgba(145, 152, 173, 1),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
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
                            "转出金币数量",
                            style: TextStyle(
                              fontSize: 18,
                              color: rgba(255, 255, 255, 1),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: TextField(
                                  controller: _numberEditingController,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: rgba(255, 255, 255, 1),
                                  ),
                                  decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    hintText: "请输入转出金币数量",
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
                              SizedBox(
                                width: 12,
                              ),
                              Material(
                                color: rgba(28, 35, 63, 1),
                                child: InkWell(
                                  onTap: () {
                                    this._rolloutAll();
                                  },
                                  child: Text(
                                    "全部转出",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: rgba(23, 96, 255, 1),
                                    ),
                                  ),
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
                  this._confirmRollout();
                },
                child: Text(
                  "确认转出",
                  style: TextStyle(
                    color: rgba(255, 255, 255, 1),
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
