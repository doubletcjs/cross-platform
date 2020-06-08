import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hksy_flutter/public/public.dart';

class UsdtRecharge extends StatefulWidget {
  UsdtRecharge({Key key}) : super(key: key);

  @override
  _UsdtRechargeState createState() => _UsdtRechargeState();
}

class _UsdtRechargeState extends State<UsdtRecharge> {
  void _copyUsdt() {
    ClipboardData data = new ClipboardData(text: "要复制的内容");
    Clipboard.setData(data);

    Future.delayed(Duration(milliseconds: 200), () {
      showToast("复制成功", context);
    });
  }

  void _saveUsdtQrcode() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      appBar: customAppBar(
        title: "USDT充值",
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
                    "金币",
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
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
                    padding: EdgeInsets.fromLTRB(16.5, 38, 16.5, 31),
                    decoration: BoxDecoration(
                      color: rgba(28, 35, 63, 1),
                      borderRadius: BorderRadius.circular(7.5),
                    ),
                    child: Column(
                      children: <Widget>[
                        Image.network(
                          "http://app.hkicloud.com/static/usdt/1PCUGksYSEPdcXrrHHE3QkYmQWWxq3VRr9.png",
                          width: 180,
                          height: 180,
                        ),
                        SizedBox(
                          height: 18.5,
                        ),
                        InkWell(
                          onTap: () {
                            this._saveUsdtQrcode();
                          },
                          child: Text(
                            "保存二维码",
                            style: TextStyle(
                              fontSize: 15,
                              color: rgba(23, 96, 255, 1),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 31,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "0xb701eafb2a741349afd1496f50819458160279d250",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: rgba(145, 152, 173, 1),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 36.5,
                            ),
                            Container(
                              height: 32,
                              decoration: BoxDecoration(
                                color: rgba(23, 96, 255, 1),
                                borderRadius: BorderRadius.circular(7.5),
                              ),
                              child: FlatButton(
                                padding: EdgeInsets.fromLTRB(10, 5.1, 10, 5.5),
                                onPressed: () {
                                  this._copyUsdt();
                                },
                                child: Text(
                                  "复制链接",
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
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(12, 29, 12, 29),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "注意：",
                        "1. 请勿向上述地址充值任何非USDT资产，否则资 产将不可找回；",
                        "2. 请注意次地址为BTC链上的USDT；",
                        "3. 1到6次网络确认可到账，到账后自动转换为金币；",
                        "4. 最小充值金额100 USDT，小于最小金额的充值将不会上账且无法退回。",
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
              height: MediaQuery.of(context).padding.bottom,
            ),
          ],
        ),
      ),
    );
  }
}
