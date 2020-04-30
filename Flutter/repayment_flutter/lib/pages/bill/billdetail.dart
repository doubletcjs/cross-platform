import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
                return functionSlidableCell(
                  BillDetailCell(),
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
              itemCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}
