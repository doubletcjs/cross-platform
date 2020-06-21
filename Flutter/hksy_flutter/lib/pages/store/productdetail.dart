import 'package:flutter/material.dart';
import 'package:hksy_flutter/function/paycode/paycodeinput.dart';
import 'package:hksy_flutter/pages/coin/cashrecharge.dart';
import 'package:hksy_flutter/pages/store/api/storeapi.dart';
import 'package:hksy_flutter/pages/store/ordercomplete.dart';
import 'package:hksy_flutter/pages/store/orderconfirm.dart';
import 'package:hksy_flutter/pages/store/productconfig.dart';
import 'package:hksy_flutter/pages/store/productinfo.dart';
import 'package:hksy_flutter/pages/store/productservice.dart';
import 'package:hksy_flutter/public/public.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';

class ProductDetail extends StatefulWidget {
  String productId = "";
  ProductDetail({Key key, this.productId = ""}) : super(key: key);

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
  Map _product = {};

  void _getProductDetail() {
    XsProgressHud hud = initHUD(context);
    StoreApi.getProductDetail(this.widget.productId, (data, msg) {
      hideHUD(hud);
      if (data != null) {
        setState(() {
          _product = data;
        });
      } else {
        showToast(msg, context);
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: _tabs.length, vsync: this);

    Future.delayed(Duration(milliseconds: 400), () {
      this._getProductDetail();
    });
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
      body: isStringEmpty(this.widget.productId) || _product.length == 0
          ? Container()
          : Column(
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
                            ProductInfo(
                              product: _product,
                            ),
                            ProductConfig(),
                            ProductService(),
                          ],
                          index: _tabController.index,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 49 + MediaQuery.of(context).padding.bottom,
                  color: rgba(23, 96, 255, 1),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: 49,
                        width: MediaQuery.of(context).size.width,
                        child: FlatButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            OrderConfirm(
                              product: _product,
                              confirmHandle: (isRecharge) {
                                if (isRecharge) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return CashRecharge();
                                      },
                                    ),
                                  );
                                } else {
                                  PaycodeInput(
                                    inputHandle: (password) {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return OrderComplete();
                                          },
                                        ),
                                      );
                                    },
                                  ).show(context);
                                }
                              },
                            ).show(context);
                          },
                          child: Text(
                            "立即购买",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
