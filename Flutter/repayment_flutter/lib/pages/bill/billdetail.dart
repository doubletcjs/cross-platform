import 'package:flutter/material.dart';
import 'package:repayment_flutter/pages/bill/views/billdetailcell.dart';
import 'package:repayment_flutter/pages/bill/views/billdetailheader.dart';
import 'package:repayment_flutter/public/public.dart';

class BillDetailPage extends StatefulWidget {
  BillDetailPage({Key key}) : super(key: key);

  @override
  _BillDetailPageState createState() => _BillDetailPageState();
}

class _BillDetailPageState extends State<BillDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "帐单详情",
      ),
      body: Column(
        children: <Widget>[
          BillDetailHeader(),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return BillDetailCell();
              },
              itemCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}
