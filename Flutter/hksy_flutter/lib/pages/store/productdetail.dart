import 'package:flutter/material.dart';
import 'package:hksy_flutter/function/paycode/paycodeinput.dart';
import 'package:hksy_flutter/pages/store/orderconfirm.dart';
import 'package:hksy_flutter/pages/store/productconfig.dart';
import 'package:hksy_flutter/pages/store/productinfo.dart';
import 'package:hksy_flutter/pages/store/productservice.dart';
import 'package:hksy_flutter/public/public.dart';

class ProductDetail extends StatefulWidget {
  ProductDetail({Key key}) : super(key: key);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail>
    with TickerProviderStateMixin {
  List<String> _tabs = [
    "基本信息",
    "详细配置",
    "包装售后",
  ];
  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: customAppBar(
        title: "产品详情",
        brightness: Brightness.dark,
        backgroundColor: kMainBackgroundColor,
        color: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Column(
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
                      ProductInfo(),
                      ProductConfig(),
                      ProductService(),
                    ],
                    index: _tabController.index,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            child: Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(
                  0, 14, 0, 14 + MediaQuery.of(context).padding.bottom),
              color: rgba(23, 96, 255, 1),
              child: Text(
                "立即购买",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
            onTap: () {
              OrderConfirm(
                confirmHandle: (isRecharge) {
                  if (isRecharge) {
                  } else {
                    PaycodeInput().show(context);
                  }
                },
              ).show(context);
            },
          ),
        ],
      ),
    );
  }
}
