import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:repayment_flutter/pages/bill/views/billdetailcell.dart';
import 'package:repayment_flutter/pages/bill/views/billdetailheader.dart';
import 'package:repayment_flutter/public/billmanager.dart';
import 'package:repayment_flutter/public/public.dart';

class BillDetailPage extends StatefulWidget {
  Map bill;
  BillDetailPage({Key key, this.bill}) : super(key: key);

  @override
  _BillDetailPageState createState() => _BillDetailPageState();
}

class _BillDetailPageState extends State<BillDetailPage> {
  List<Map<String, dynamic>> _dataList = [];

  void _refrshUnfoldBills() {
    if (this.widget.bill != null) {
      BillManager.billUnfoldBills((bills) {
        setState(() {
          _dataList = bills;
        });
      }, this.widget.bill);
    }
  }

  @override
  void initState() {
    super.initState();

    this._refrshUnfoldBills();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "帐单详情",
      ),
      body: Column(
        children: <Widget>[
          BillDetailHeader(
            bill: this.widget.bill,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return functionSlidableCell(
                  BillDetailCell(
                    bill: _dataList[index],
                  ),
                  actionExtentRatio: 80 / MediaQuery.of(context).size.width,
                  rightActions: [
                    SlideAction(
                      child: Text(
                        "设为已还",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      closeOnTap: true,
                      color: kMainColor,
                      onTap: () {},
                    ),
                  ],
                );
              },
              itemCount: _dataList.length,
            ),
          ),
        ],
      ),
    );
  }
}
