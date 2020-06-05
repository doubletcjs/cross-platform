import 'package:flutter/material.dart';
import 'package:hksy_flutter/pages/coin/orderlist.dart';
import 'package:hksy_flutter/pages/mine/customerservice.dart';
import 'package:hksy_flutter/public/public.dart';

class OrderDetail extends StatefulWidget {
  int selectIndex = 0;
  OrderDetail({Key key, this.selectIndex = 0}) : super(key: key);

  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail>
    with TickerProviderStateMixin {
  List<String> _tabs = [
    "全部",
    "充值",
    "提现",
    "互转",
  ];
  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.index = this.widget.selectIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      appBar: customAppBar(
        title: "订单明细",
        brightness: Brightness.dark,
        backgroundColor: kMainBackgroundColor,
        color: Colors.white,
        rightItems: [
          FlatButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return CustomerService();
                  },
                ),
              );
            },
            child: Text(
              "客服",
              style: TextStyle(
                fontSize: 15,
                color: rgba(255, 255, 255, 1),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          TabBar(
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: rgba(23, 96, 255, 1),
            indicatorWeight: 1.5,
            labelColor: rgba(23, 96, 255, 1),
            unselectedLabelColor: rgba(255, 255, 255, 1),
            labelStyle: TextStyle(
              color: rgba(23, 96, 255, 1),
              fontSize: 15,
            ),
            unselectedLabelStyle: TextStyle(
              color: rgba(255, 255, 255, 1),
              fontSize: 15,
            ),
            tabs: _tabs.map(
              (tab) {
                return Tab(
                  text: tab,
                );
              },
            ).toList(),
            onTap: (index) {
              setState(() {
                _tabController.index = index;
              });
            },
          ),
          Expanded(
            child: IndexedStack(
              children: <Widget>[
                OrderList(
                  type: 0,
                ),
                OrderList(
                  type: 1,
                ),
                OrderList(
                  type: 2,
                ),
                OrderList(
                  type: 3,
                ),
              ],
              index: _tabController.index,
            ),
          ),
        ],
      ),
    );
  }
}
