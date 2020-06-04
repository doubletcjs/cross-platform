import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hksy_flutter/function/paycode/paycodeinput.dart';
import 'package:hksy_flutter/pages/coin/transfercomplete.dart';
import 'package:hksy_flutter/public/public.dart';

class CoinTransfer extends StatefulWidget {
  CoinTransfer({Key key}) : super(key: key);

  @override
  _CoinTransferState createState() => _CoinTransferState();
}

class _CoinTransferState extends State<CoinTransfer> {
  TextEditingController _countEditingController = TextEditingController();
  TextEditingController _phoneEditingController = TextEditingController();
  void _rolloutAll() {
    setState(() {
      _countEditingController.text = "13420";
    });
  }

  void _confirmRollout() {
    if (regularMatch(_phoneEditingController.text, kPhoneRegExp) == true) {
      functionAlertView(
        context,
        title: "您确认转账到 1353335488 ？",
        content: "转账金币：100个",
        contentTextAlign: TextAlign.center,
        titleTextStyle: TextStyle(
          fontSize: 15,
          color: rgba(51, 51, 51, 1),
        ),
        titlePadding: EdgeInsets.fromLTRB(20, 40, 20, 0),
        contentTextStyle: TextStyle(
          fontSize: 15,
          color: rgba(23, 96, 255, 1),
        ),
        contentPadding: EdgeInsets.fromLTRB(20, 20.5, 20, 39),
        cancel: "取消",
        confirm: "确认",
        confirmHandle: () {
          Future.delayed(
            Duration(milliseconds: 400),
            () {
              PaycodeInput(
                inputHandle: (password) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return TransferComplete();
                      },
                    ),
                  );
                },
              ).show(context);
            },
          );
        },
      );
    } else {
      showToast("请输入正确的手机号", context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      appBar: customAppBar(
        title: "金币互转",
        brightness: Brightness.dark,
        backgroundColor: kMainBackgroundColor,
        color: Colors.white,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          color: kMainBackgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 24.5,
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "金币资产",
                            style: TextStyle(
                              fontSize: 15,
                              color: rgba(145, 152, 173, 1),
                            ),
                          ),
                          Text(
                            "13420个",
                            style: TextStyle(
                              fontSize: 15,
                              color: rgba(145, 152, 173, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 37,
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
                      padding: EdgeInsets.fromLTRB(20, 20.5, 20, 0),
                      decoration: BoxDecoration(
                        color: rgba(28, 35, 63, 1),
                        borderRadius: BorderRadius.circular(7.5),
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "转出数量",
                              style: TextStyle(
                                fontSize: 18,
                                color: rgba(255, 255, 255, 1),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5.5,
                          ),
                          Container(
                            height: 60.5,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: rgba(145, 152, 173, 0.2),
                                  width: 0.5,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: TextField(
                                    controller: _countEditingController,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: rgba(255, 255, 255, 1),
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      labelText: "可转出13420个",
                                      labelStyle: TextStyle(
                                        fontSize: 13,
                                        color: rgba(145, 152, 173, 1),
                                      ),
                                      contentPadding:
                                          EdgeInsets.fromLTRB(0, 0, 0, 13),
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
                          Container(
                            height: 60.5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "对方账户",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: rgba(255, 255, 255, 1),
                                  ),
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextField(
                                      controller: _phoneEditingController,
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: rgba(255, 255, 255, 1),
                                      ),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never,
                                        labelText: "请输入对方账户手机号码",
                                        labelStyle: TextStyle(
                                          fontSize: 13,
                                          color: rgba(145, 152, 173, 1),
                                        ),
                                        contentPadding:
                                            EdgeInsets.fromLTRB(0, 0, 0, 13),
                                      ),
                                      inputFormatters: [
                                        WhitelistingTextInputFormatter
                                            .digitsOnly,
                                        LengthLimitingTextInputFormatter(11),
                                      ],
                                      keyboardType: TextInputType.number,
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
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
