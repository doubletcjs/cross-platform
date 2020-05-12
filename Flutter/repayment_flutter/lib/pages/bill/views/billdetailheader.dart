import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repayment_flutter/pages/bill/billeditorial.dart';
import 'package:repayment_flutter/public/public.dart';

class BillDetailHeader extends StatelessWidget {
  Map bill;
  BillDetailHeader({Key key, this.bill}) : super(key: key);

  List<String> _itemList = ["账单金额", "还款期限", "还款周期"];

  void _edittingBill(BuildContext context) {
    Future.delayed(
      Duration(milliseconds: 300),
      () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return BillEditorialPage();
            },
          ),
        );
      },
    );
  }

  void _handleDeleteBill(BuildContext context) {}

  void _deleteBill(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "提示",
          ),
          content: Text("确定要删除该记录吗？"),
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
                Future.delayed(Duration(milliseconds: 400), () {
                  this._handleDeleteBill(context);
                });
              },
              child: Text(
                "确定",
              ),
            ),
          ],
        );
      },
    );
  }

  void _moreActions(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "取消",
              style: TextStyle(
                fontSize: 16,
                color: kMainColor,
              ),
            ),
          ),
          actions: <Widget>[
            CupertinoActionSheetAction(
              onPressed: () {
                this._edittingBill(context);
                Navigator.of(context).pop();
              },
              child: Text(
                "编辑",
                style: TextStyle(
                  fontSize: 16,
                  color: kMainColor,
                ),
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                this._deleteBill(context);
                Navigator.of(context).pop();
              },
              child: Text(
                "删除",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 22),
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.fromLTRB(18, 18, 15, 18),
        decoration: BoxDecoration(
          color: kMainColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "${bill["name"]}",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "${double.parse('${bill["eachamount"]}').toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontFamily: "Oswald",
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          "剩余待还总金额（元）",
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: buttonWidget(
                    Icon(
                      Icons.more_horiz,
                      color: Colors.white,
                    ),
                    context,
                    onTap: () {
                      this._moreActions(context);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 14,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _itemList.map(
                (item) {
                  var index = _itemList.indexOf(item);
                  return Column(
                    children: <Widget>[
                      Text(
                        index == 0
                            ? "${double.parse('${double.parse('${bill["eachamount"]}') * (int.parse('${bill['repaymentterms']}') + 1)}').toStringAsFixed(2)}"
                            : index == 1
                                ? "${int.parse('${bill['repaymentterms']}') + 1}"
                                : "每${int.parse('${bill['repaymentperiod']}'.split('|').first) + 1}${int.parse('${bill['repaymentperiod']}'.split('|').last) == 0 ? '个月' : '天'}",
                        style: TextStyle(
                          fontSize: 19,
                          color: Colors.white,
                          fontFamily: "Oswald",
                        ),
                      ),
                      Text(
                        item,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  );
                },
              ).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
