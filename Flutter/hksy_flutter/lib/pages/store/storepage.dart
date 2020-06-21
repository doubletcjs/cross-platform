import 'package:flutter/material.dart';
import 'package:hksy_flutter/pages/store/api/storeapi.dart';
import 'package:hksy_flutter/pages/store/views/productcell.dart';
import 'package:hksy_flutter/public/public.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class StorePage extends StatefulWidget {
  StorePage({Key key}) : super(key: key);

  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);
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
          List records = data["records"];
          setState(() {
            if (_page == 1) {
              _dataList = records;
            } else {
              _dataList = _dataList + records;
            }

            if (records.length == 0 && _page > 1) {
              _page -= 1;
            }
          });

          _refreshController.refreshCompleted();
          if (_page == data["pages"] || data["pages"] == 0) {
            _refreshController.loadNoData();
          } else {
            _refreshController.refreshCompleted();
          }
        } else {
          setState(() {
            if (_page > 1) {
              _page -= 1;
            }
          });

          _refreshController.refreshCompleted();
          _refreshController.loadComplete();
          showToast(msg, context);
        }
      },
    );
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
      body: functionRefresher(
        _refreshController,
        ListView(
          padding: EdgeInsets.fromLTRB(12, 20, 12, 20),
          children: <Widget>[
            Wrap(
              spacing: 11,
              runSpacing: 20,
              children: _dataList.map(
                (product) {
                  return ProductCell(
                    diffSpace: 12 * 2.0,
                    spacing: 11.0,
                    product: product,
                  );
                },
              ).toList(),
            ),
          ],
        ),
        onRefresh: () {
          this._refreshData();
        },
        onLoadMore: () {
          this._loadMoreData();
        },
        enableLoadMore: true,
      ),
    );
  }
}
