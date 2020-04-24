import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:repayment_flutter/pages/bill/views/billeditorialcell.dart';
import 'package:repayment_flutter/pages/bill/views/billeditorialheader.dart';
import 'package:repayment_flutter/pages/bill/views/billeditorialkeboard.dart';
import 'package:repayment_flutter/public/public.dart';

class BillEditorialPage extends StatefulWidget {
  final bool isCreation;
  BillEditorialPage({Key key, this.isCreation = false}) : super(key: key);

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

  Map _bill = {};

  @override
  void initState() {
    super.initState();
    _header = BillEditorialHeader();
    _keyboard = BillEditorialKeyboard(
      inputHandle: (number) {
        setState(() {
          _header.reloadNumber("$number");
          _bill["amount"] = double.parse("$number").toStringAsFixed(2);
        });
      },
      saveHandle: () {
        kLog("bill:" + _bill.toString());

        Navigator.of(context).pop();
      },
      saveAndCreateHandle: () {
        kLog("bill:" + _bill.toString());

        Navigator.of(context).pop();
      },
    );

    _bill["amount"] = "";
    _bill["name"] = "";
    _bill["date"] = "";
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
                          _bill["name"] = "$value";
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
