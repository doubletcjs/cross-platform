import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ideaclass/pages/commons/emptyplaceholder.dart';
import 'package:ideaclass/pages/community/api/communityapi.dart';
import 'package:ideaclass/pages/community/views/communityoption.dart';
import 'package:ideaclass/pages/community/views/recommendheader.dart';
import 'package:ideaclass/public/public.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CommunityPage extends StatefulWidget {
  CommunityPage({Key key}) : super(key: key);

  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  void _postOptions() {
    CommunityOptionBottomSheet _optionBottomSheet =
        CommunityOptionBottomSheet();
    _optionBottomSheet.show(context);
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  bool _enableLoadMore = false;
  bool _refreshing = true;

  int _currPage = 1;
  int _pageSize = 20;
  List _communityList = [];

  void _requestData() {
    _refreshing = true;

    CommunityApi().getCommunityShareList(
      _currPage,
      _pageSize,
      (data, msg) {
        if (data != null) {
          Future.delayed(Duration(milliseconds: 600), () {
            _refreshController.refreshCompleted();
            _refreshing = false;
            setState(
              () {},
            );
          });
        } else {
          showToast(msg, context);

          _refreshController.refreshCompleted();
          _refreshController.loadComplete();
          _refreshing = false;
          setState(
            () {},
          );
        }
      },
    );
  }

  void _refreshData() {
    _currPage = 1;
    _requestData();
  }

  void _loadMoreData() {
    if (_enableLoadMore == true) {
      _currPage += 1;
      _requestData();
      kLog("_loadMoreData");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "社区"),
      body: functionRefresher(
        _refreshController,
        null,
        enableLoadMore: _enableLoadMore,
        onRefresh: () {
          this._refreshData();
        },
        onLoadMore: () {
          this._loadMoreData();
        },
        slivers: [
          SliverAppBar(
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: RecommendHeader(),
              titlePadding: EdgeInsets.zero,
            ),
          ),
          WaterDropMaterialHeader(),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return _communityList.length == 0
                    ? EmptyPlaceholder(
                        loading: _refreshing,
                      )
                    : Container(
                        alignment: Alignment.center,
                        color: Colors.teal[100 * (index % 9)],
                        child: Text('Grid Item $index'),
                      );
              },
              childCount:
                  _communityList.length == 0 ? 1 : _communityList.length,
            ),
          ),
          functionFooter(enable: _enableLoadMore),
        ],
      ),
      floatingActionButton: buttonWidget(
        Image.asset(
          "images/shequ-fabu@3x.png",
          width: 48,
          height: 49,
        ),
        context,
        onTap: () {
          this._postOptions();
        },
        radius: BorderRadius.circular(49 / 2),
        loginIntercept: false,
      ),
    );
  }
}
