import 'package:corner_app/pages/store/dynamic/views/store_dynamic_cell.dart';
import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// ignore: must_be_immutable
class StoreDynamicPage extends StatefulWidget {
  int tab = 0;
  StoreDynamicPage({
    Key key,
    this.tab = 0,
  }) : super(key: key);

  @override
  _StoreDynamicPageState createState() => _StoreDynamicPageState();
}

class _StoreDynamicPageState extends State<StoreDynamicPage>
    with AutomaticKeepAliveClientMixin {
  List _dataList = [
    "123",
    "2434",
    "135253",
    "23515",
    "qwerqwer",
    "q2342ew",
    "1wefcwer",
    "qwrdbqerhy",
    "wefgadgadgaddasfasd",
    "23423423413413241234",
    "fasdfasdfwefwef2",
    "aw45324142",
    "q3rb q3455",
    "qey43vasd4wt",
    "54wbe5ber",
    "qet34eavw34qtwx",
    "aw436tqsagv34wgaqw43g",
    "q34qt34g",
    "jd83mcjw,fmw",
    "03of,w9ew,mwiv,s;",
    "s0wskwckske,c",
    "202k,v,wk2",
    "223",
    "111111",
    "222222",
    "33333",
    "44444",
  ];

  GlobalKey _globalKey = GlobalKey();
  double _tableHeight = 0;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  // 加载更多
  void _onLoadMore() {
    Future.delayed(Duration(milliseconds: 4200), () {
      setState(() {
        _dataList.add("5555");
        _dataList.add("555345");
        _dataList.add("5555111");
        _dataList.add("5555222");
        _dataList.add("5555333");
        _dataList.add("5555444");

        _refreshController.loadComplete();
      });
    });
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        _tableHeight = _globalKey.currentContext.size.height;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _tableHeight == 0
        ? Column(
            key: _globalKey,
            children: _dataList.map((data) {
              var index = _dataList.indexOf(data);
              return StoreDynamicCell(
                row: index,
              );
            }).toList(),
          )
        : Container(
            color: rgba(247, 246, 245, 1),
            height: _tableHeight,
            child: functionRefresher(
              _refreshController,
              ListView.builder(
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return StoreDynamicCell(
                    row: index,
                  );
                },
                itemCount: _dataList.length,
              ),
              enableRefresh: false,
              enableLoadMore: true,
              onLoadMore: () {
                this._onLoadMore();
              },
            ),
          );
  }
}
