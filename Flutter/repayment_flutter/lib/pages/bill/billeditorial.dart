import 'package:flutter/material.dart';
import 'package:repayment_flutter/pages/bill/views/billeditorialcell.dart';
import 'package:repayment_flutter/pages/bill/views/billeditorialheader.dart';
import 'package:repayment_flutter/pages/bill/views/billeditorialkeboard.dart';
import 'package:repayment_flutter/public/billmanager.dart';
import 'package:repayment_flutter/public/public.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';

class BillEditorialPage extends StatefulWidget {
  final Map currentBill;
  BillEditorialPage({Key key, this.currentBill}) : super(key: key);

  @override
  _BillEditorialPageState createState() => _BillEditorialPageState();
}

class _BillEditorialPageState extends State<BillEditorialPage> {
  BillEditorialHeader _header;
  BillEditorialKeyboard _keyboard;
  List<String> _editorialList = [
    "账单名称",
    "首次还款日",
    "还款期限",
    "还款周期",
    "备忘：不超过20字（选填）"
  ];

  Map<String, dynamic> _bill = {};

  void _recordBill() {
    if (isStringEmpty("${_bill['name']}") == true) {
      showToast("请输入账单名称", context);
      return;
    }

    if (isStringEmpty("${_bill['amount']}") == true) {
      showToast("请输入还款金额", context);
      return;
    }

    double amount = double.parse(_bill["amount"]);
    kLog("amount:" + "$amount");
    if (amount == null || amount < 0.01) {
      showToast("请输入还款金额", context);
      return;
    }

    if (isStringEmpty("${_bill['limit']}") == true) {
      showToast("请选择还款期限", context);
      return;
    }

    if (isStringEmpty("${_bill['date']}") == true) {
      showToast("请选择首次还款日期", context);
      return;
    }

    if (isStringEmpty("${_bill['cycle']}") == true) {
      showToast("请选择还款周期", context);
      return;
    }

    Map<String, dynamic> __bill = {};
    __bill["eachamount"] = _bill["amount"];
    __bill["name"] = _bill["name"];
    __bill["icon"] = _bill["icon"];
    __bill["firstdate"] = _bill["date"];
    __bill["adddate"] = "${DateTime.now().millisecondsSinceEpoch}";
    __bill["repaymentterms"] = int.parse(_bill["limit"]);
    __bill["repaymentperiod"] = _bill["cycle"];
    __bill["remark"] = _bill["remark"];

    XsProgressHud hud = initHUD(context);
    BillManager.recordBill(
      __bill,
      (msg) {
        Future.delayed(Duration(milliseconds: 400), () {
          hideHUD(hud);
          if (msg == null) {
            Navigator.of(context).pop();
          } else {
            showToast(msg, context);
          }
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _header = BillEditorialHeader();
    _keyboard = BillEditorialKeyboard(
      inputHandle: (number) {
        setState(() {
          _header.reloadNumber("$number");
          if (isStringEmpty(number) == true) {
            _bill["amount"] = "";
          } else {
            _bill["amount"] = double.parse("$number").toStringAsFixed(2);
          }
        });
      },
      saveHandle: () {
        this._recordBill();
      },
      saveAndCreateHandle: () {
        this._recordBill();
      },
    );

    _bill["amount"] = "";
    _bill["name"] = "";
    _bill["icon"] = "";
    _bill["date"] = "";
    _bill["adddate"] = "";
    _bill["limit"] = "";
    _bill["cycle"] = "";
    _bill["remark"] = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "编辑帐单",
        backgroundColor: kMainColor,
        color: Colors.white,
        brightness: Brightness.dark,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _header,
            Expanded(
              child: ListView.separated(
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    var item = _editorialList[index];
                    return BillEditorialCell(
                      item: item,
                      value: index == 1 ? _bill["date"] : "",
                      editorialHandle: (value) {
                        if (index == 0) {
                          var nameIcon = "$value";
                          _bill["name"] = "${nameIcon.split("|").first}";
                          _bill["icon"] = "${nameIcon.split("|").last}";
                        } else if (index == 1) {
                          _bill["date"] = "$value";
                        } else if (index == 2) {
                          _bill["limit"] = "$value";
                        } else if (index == 3) {
                          _bill["cycle"] = "$value";
                        } else if (index == 4) {
                          _bill["remark"] = "$value";
                        }
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Container(
                      height: (index == 0 || index == 3) ? 8 : 1,
                    );
                  },
                  itemCount: _editorialList.length),
            ),
            _keyboard,
          ],
        ),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }
}
