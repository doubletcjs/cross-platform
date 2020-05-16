import 'package:flutter/material.dart';
import 'package:hksy_flutter/pages/store/api/storeapi.dart';
import 'package:hksy_flutter/public/public.dart';

class StorePage extends StatefulWidget {
  StorePage({Key key}) : super(key: key);

  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  List _dataList = [];
  int _page = 1;
  int _limit = 0;

  void _loadMoreData() {
    setState(() {
      _page += 1;
      this._requestProducts();
    });
  }

  void _refreshData() {
    setState(() {
      _page = 1;
      this._requestProducts();
    });
  }

  void _requestProducts() {
    StoreApi.getProductList(
      _page,
      _limit,
      (data, msg) {
        if (data != null) {
          kLog("data:$data");
        } else {
          showToast(msg, context);
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();

    // this._requestProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      appBar: customAppBar(
        title: "商城",
        brightness: Brightness.dark,
        backgroundColor: kMainBackgroundColor,
        color: Colors.white,
      ),
      body: Center(
        child: Text("商城"),
      ),
    );
  }
}
