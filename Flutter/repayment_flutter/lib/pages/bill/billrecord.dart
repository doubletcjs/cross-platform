import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:repayment_flutter/pages/bill/billnorecord.dart';
import 'package:repayment_flutter/pages/bill/views/billrecordcell.dart';
import 'package:repayment_flutter/public/billmanager.dart';
import 'package:repayment_flutter/public/public.dart';

class BillRecordPage extends StatefulWidget {
  BillRecordPage({Key key}) : super(key: key);

  @override
  _BillRecordPageState createState() => _BillRecordPageState();
}

class _BillRecordPageState extends State<BillRecordPage>
    with SingleTickerProviderStateMixin {
  List<String> _tabTexts = ["还款中", "已还清", "全部"];
  TabController _tabController;
  int _currentIndex = 0;

  List _dataList = [];

  void _refreshData() {
    BillManager.allBills((list) {
      setState(() {
        _dataList = list;
      });
    }, (msg) {
      if (msg != null) {
        showToast(msg, context);
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
    this._refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "账单记录",
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              labelPadding: EdgeInsets.zero,
              indicatorPadding: EdgeInsets.zero,
              indicatorColor: kMainColor,
              labelColor: kMainColor,
              unselectedLabelColor: Colors.grey,
              labelStyle: TextStyle(
                fontSize: 16,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 16,
              ),
              tabs: _tabTexts.map(
                (tab) {
                  return Tab(
                    text: tab,
                  );
                },
              ).toList(),
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                  this._refreshData();
                });
              },
            ),
          ),
          Expanded(
            child: _dataList.length == 0
                ? BillNoRecordPage()
                : ListView.builder(
                    itemBuilder: (context, index) {
                      return functionSlidableCell(
                        BillRecordCell(
                          bill: _dataList[index],
                          onClose: (ctx) {
                            Slidable.of(ctx).close();
                          },
                        ),
                        actionExtentRatio:
                            80 / MediaQuery.of(context).size.width,
                        rightActions: [
                          SlideAction(
                            child: Text(
                              "删除",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            closeOnTap: true,
                            color: Colors.red,
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
