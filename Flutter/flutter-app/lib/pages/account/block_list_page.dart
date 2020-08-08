import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../public/public.dart';
import 'views/account_base_cell.dart';
import 'api/record_list_api.dart';

class BlockListPage extends StatefulWidget {
  BlockListPage({Key key}) : super(key: key);

  @override
  _BlockListPageState createState() => _BlockListPageState();
}

class _BlockListPageState extends State<BlockListPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  List _dataList = [];
  int _page = 1;
  int _perPage = 15;
  bool _showLoadMore = false;

  //加载更多
  void _loadMoreData() {
    setState(() {
      _page += 1;
      this._requestData();
    });
  }

  //刷新
  void _refreshData() {
    setState(() {
      _page = 1;
      this._requestData();
    });
  }

  //请求
  void _requestData() {
    RecordListApi.blockList(this._page, this._perPage, (data, msg) {
      if (data != null) {
        Map pagination = data["pagination"];
        List records = data["data"];

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

        if (_page == pagination["total_pages"]) {
          _refreshController.loadNoData();
          _showLoadMore = false;
        } else {
          _refreshController.loadComplete();
          _showLoadMore = true;
        }

        _refreshController.refreshCompleted();
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rgba(248, 248, 248, 1),
      appBar: customAppBar(
        title: "黑名单",
        elevation: 0.5,
      ),
      body: functionRefresher(
        _refreshController,
        ListView.builder(
          itemBuilder: (context, index) {
            return AccountBaseCell(
              account: _dataList[index],
            );
          },
          itemCount: _dataList.length,
        ),
        onRefresh: () {
          this._refreshData();
        },
        onLoadMore: () {
          this._loadMoreData();
        },
        enableLoadMore: _showLoadMore,
      ),
    );
  }
}
