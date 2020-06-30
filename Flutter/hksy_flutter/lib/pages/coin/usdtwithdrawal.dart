import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hksy_flutter/pages/coin/api/coinapi.dart';
import 'package:hksy_flutter/pages/coin/transfercomplete.dart';
import 'package:hksy_flutter/public/public.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';

class UsdtWithdrawal extends StatefulWidget {
  UsdtWithdrawal({Key key}) : super(key: key);

  @override
  _UsdtWithdrawalState createState() => _UsdtWithdrawalState();
}

class _UsdtWithdrawalState extends State<UsdtWithdrawal> {
  TextEditingController _addressEditingController = TextEditingController();
  TextEditingController _numberEditingController = TextEditingController();
  Map _account = {};

  double _inputCoin = 0.0;
  double _poundage = 0.0;
  double _usdtCount = 0.0;
  double _minCoin = 0.0;
  double _coin = 0.0;

  void _rolloutAll() {
    setState(() {
      _numberEditingController.text = "$_coin";
      this._calculateAction(_numberEditingController.text);
    });
  }

  void _calculateAction(String input) {
    if (isStringEmpty(input) == true) {
      input = "0.0";
    }

    setState(() {
      _inputCoin = double.parse(input);
      _poundage = (_inputCoin * 0.05) / 6.72;
      _usdtCount = (_inputCoin - _inputCoin * 0.05) / 6.72;
    });
  }

  void _confirmWithdrawal() {
    if (isStringEmpty(_addressEditingController.text)) {
      showToast("请输入提币地址", context);
      return;
    }

    if (_minCoin > _usdtCount) {
      showToast("最小提币数量为${_minCoin.toString()}枚USDT", context);
      return;
    }

    FocusScope.of(context).requestFocus(FocusNode());
    XsProgressHud hud = initHUD(context);
    userID((id) {
      if (isStringEmpty(id) == false) {
        CoinApi.submitUSDTWithdraw(id, _inputCoin, _usdtCount, _poundage,
            _addressEditingController.text, (data, msg) {
          if (data != null) {
            DartNotificationCenter.post(channel: kRefreshAccountNotification);
            Future.delayed(Duration(milliseconds: 800), () {
              hideHUD(hud);
              this._emptyInput();

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return TransferComplete(
                      completeType: 2,
                    );
                  },
                ),
              );
            });
          } else {
            hideHUD(hud);
            showToast(msg, context);
          }
        });
      } else {
        hideHUD(hud);
      }
    });
  }

  void _emptyInput() {
    _numberEditingController.text = "";
    _addressEditingController.text = "";
    this._calculateAction("");
  }

  void _refreshAccount() {
    setState(() {
      _account = currentAcctount;
      _minCoin = double.parse(
          double.parse("${_account['usdt_min_amount']}").toStringAsFixed(2));
      _coin =
          double.parse(double.parse("${_account['coin']}").toStringAsFixed(2));
    });
  }

  @override
  void initState() {
    super.initState();

    DartNotificationCenter.subscribe(
      channel: kUpdateAccountNotification,
      observer: this,
      onNotification: (options) {
        this._refreshAccount();
      },
    );

    this._refreshAccount();
  }

  @override
  void dispose() {
    super.dispose();

    DartNotificationCenter.unsubscribe(observer: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      appBar: customAppBar(
        title: "USDT提现",
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
                    "金币资产",
                    style: TextStyle(
                      fontSize: 15,
                      color: rgba(145, 152, 173, 1),
                    ),
                  ),
                  Text(
                    "$_coin" + "个",
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
                    padding: EdgeInsets.fromLTRB(20, 20.5, 10, 16.5),
                    decoration: BoxDecoration(
                      color: rgba(28, 35, 63, 1),
                      borderRadius: BorderRadius.circular(7.5),
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "USDT提现地址",
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
                          child: TextField(
                            controller: _addressEditingController,
                            style: TextStyle(
                              fontSize: 13,
                              color: rgba(255, 255, 255, 1),
                            ),
                            decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: "请输入或长按粘贴地址",
                              hintStyle: TextStyle(
                                fontSize: 13,
                                color: rgba(145, 152, 173, 1),
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 0.5,
                                color: rgba(145, 152, 173, 0.2),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
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
                            "提现数量",
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
                                    hintText: "可提现$_coin" + "个",
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
                                  onChanged: (text) {
                                    this._calculateAction(text);
                                  },
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
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 0.5,
                                color: rgba(145, 152, 173, 0.2),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 20.5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "手续费",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: rgba(255, 255, 255, 1),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    "${_poundage.toStringAsFixed(2)}",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: rgba(255, 255, 255, 1),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "USDT",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: rgba(255, 255, 255, 1),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(12, 54, 12, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "注意：",
                        "* 最小提币数量为${_minCoin.toString()}枚USDT",
                        "* 兑换汇率：1USDT ≈ 6.72金币",
                        "* 转出至钱包的资金，平台将收取5%的提现手续，请对资金进行合理安排",
                        "* 请在转出USDT之前，仔细核对收款钱包地址准确无误",
                      ].map((item) {
                        return Text(
                          item,
                          style: TextStyle(
                            color: rgba(145, 152, 173, 1),
                            fontSize: 11,
                            height: 1.9,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: rgba(28, 35, 63, 1),
              padding: EdgeInsets.fromLTRB(
                  12, 15.5, 12, 13.5 + MediaQuery.of(context).padding.bottom),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "到账信息",
                              style: TextStyle(
                                fontSize: 15,
                                color: rgba(255, 255, 255, 1),
                              ),
                            ),
                            SizedBox(
                              height: 8.5,
                            ),
                            Text(
                              "约为${_inputCoin.toStringAsFixed(2)}金币",
                              style: TextStyle(
                                fontSize: 11,
                                color: rgba(145, 152, 173, 1),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  "${_usdtCount.toStringAsFixed(2)}",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: rgba(255, 255, 255, 1),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 17,
                              ),
                              Text(
                                "USDT",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: rgba(255, 255, 255, 1),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 36,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: rgba(23, 96, 255, 1),
                      borderRadius: BorderRadius.circular(7.5),
                    ),
                    child: FlatButton(
                      padding: EdgeInsets.fromLTRB(30, 14, 30, 15),
                      onPressed: () {
                        this._confirmWithdrawal();
                      },
                      child: Text(
                        "确认提现",
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
                ],
              ),
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
