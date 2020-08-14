import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../account/views/account_function_cell.dart';
import '../../public/public.dart';
import 'api/near_api.dart';
import 'package:flutter/widgets.dart';

class NearList extends StatefulWidget {
  int listType = 0; //0 "附近" 1 "在线" 2 "新人" 3 "认证" 4 "推荐"

  NearList({
    Key key,
    this.listType = 0,
  }) : super(key: key);

  @override
  _NearListState createState() => _NearListState();
}

class _NearListState extends State<NearList>
    with AutomaticKeepAliveClientMixin {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List _dataList = [];
  int _page = 1;
  int _perPage = 15;
  bool _showLoadMore = false;

  String _longitude = ""; //经度
  String _latitude = ""; //纬度

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
    void _handleData(data, msg) {
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
    }

    if (this.widget.listType == 0) {
      NearListApi.near(
          this._longitude, this._latitude, this._page, this._perPage,
          (data, msg) {
        _handleData(data, msg);
      });
    } else {
      /*
      type integer 类型 1：在线，2：新人，3：推荐，4：认证 
      sort string 距离排序 DESC：距离降序，其他：距离升序，默认DESC
    */
      //listType 0 "附近" 1 "在线" 2 "新人" 3 "认证" 4 "推荐"
      int _type = this.widget.listType == 1
          ? 1
          : this.widget.listType == 2
              ? 2
              : this.widget.listType == 3
                  ? 4
                  : this.widget.listType == 4 ? 3 : 1;

      NearListApi.nearList(this._longitude, this._latitude, _type, "DESC",
          this._page, this._perPage, (data, msg) {
        _handleData(data, msg);
      });
    }
  }

  @override
  void initState() {
    super.initState();

    DartNotificationCenter.subscribe(
        channel: "kNearTabSwitch",
        observer: this,
        onNotification: (options) {
          if (options["index"] == this.widget.listType) {
            setState(() {
              _longitude = options["longitude"];
              _latitude = options["latitude"];

              if (_dataList.length == 0) {
                _refreshController.requestRefresh();
              }
            });
          }
        });
  }

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
    DartNotificationCenter.unsubscribe(observer: this);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return functionRefresher(
      _refreshController,
      ListView.builder(
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return AccountFunctionCell(
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
    );
  }
}
