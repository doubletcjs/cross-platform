import 'package:flutter/material.dart';
import 'package:repayment_flutter/pages/bill/billeditorial.dart';
import 'package:repayment_flutter/pages/bill/emptybilpage.dart';
import 'package:repayment_flutter/pages/home/views/homebillsection.dart';
import 'package:repayment_flutter/pages/home/views/homeheader.dart';
import 'package:repayment_flutter/public/public.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _dataList = [
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    ""
  ];

  void _createBill() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return BillEditorialPage();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          transparentAppBar(brightness: Brightness.light),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _dataList.length == 0 ? EmptyBillPage() : HomeBillHeader(),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                  itemBuilder: (context, index) {
                    return HomeBillSection();
                  },
                  separatorBuilder: (context, index) {
                    return Container(
                      height: 8,
                    );
                  },
                  itemCount: _dataList.length,
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: Container(
        width: 44,
        height: 44,
        child: RaisedButton(
          color: Colors.white,
          padding: EdgeInsets.zero,
          onPressed: () {
            this._createBill();
          },
          child: Image.asset("images/add_bill_put_in.png"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(48 / 2),
          ),
        ),
      ),
    );
  }
}
