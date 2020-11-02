import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart' hide NestedScrollView;
import 'package:time_flies/function/report_alert.dart';
import 'package:time_flies/pages/dynamic/home_dynamic_list.dart';
import 'package:time_flies/pages/home/views/home_page_header.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  String accountId = "";
  HomePage({
    Key key,
    this.accountId = "",
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;
  ScrollController _scrollController;

  GlobalKey _headerGlobalKey = GlobalKey();
  Widget _header;
  double _headerHeight = 0;
  double _stickyOpacity = 0;

  //更多
  void _moreAction(BuildContext context) {
    ReportAlert(
      itemHandle: (item) {
        Future.delayed(Duration(milliseconds: 300), () {
          if (item == "举报") {
          } else if (item == "拉黑") {}
        });
      },
    ).show(context);
  }

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
    _header = HomePageHeader(globalKey: _headerGlobalKey);
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        _headerHeight = _headerGlobalKey.currentContext.size.height;
      });
    });

    _scrollController = ScrollController(initialScrollOffset: 0.0);
    _scrollController.addListener(() {
      var offSet = _scrollController.offset;
      double _opacity = offSet / _headerHeight;
      if (_opacity > 1) {
        _opacity = 1;
      }

      if (_opacity < 0) {
        _opacity = 0;
      }

      if (_stickyOpacity != _opacity) {
        setState(() {
          _stickyOpacity = _opacity;
        });
      }
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: _headerHeight == 0
          ? _header
          : NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    expandedHeight:
                        _headerHeight + AppBar().preferredSize.height,
                    pinned: true,
                    elevation: 0,
                    backgroundColor: Colors.white,
                    iconTheme: IconThemeData(color: Colors.black),
                    brightness: Theme.of(context).brightness,
                    titleSpacing: 0,
                    leading: IconButton(
                      padding: EdgeInsets.zero,
                      icon: Image.asset(
                        "images/home_page_back@3x.png",
                        width: 29,
                        height: 29,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    actions: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        icon: Image.asset(
                          "images/home_page_more@3x.png",
                          width: 29,
                          height: 29,
                        ),
                        onPressed: () {
                          this._moreAction(context);
                        },
                      )
                    ],
                    title: Opacity(
                      opacity: _stickyOpacity < 0.5 ? 0 : _stickyOpacity,
                      child: Text(
                        "用户名",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    centerTitle: false,
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.pin,
                      background: _header,
                    ),
                    bottom: PreferredSize(
                      child: Container(
                        height: 44,
                        color: Colors.white,
                        child: TabBar(
                          controller: _tabController,
                          labelColor: Colors.black,
                          indicator: BoxDecoration(),
                          tabs: [
                            Tab(
                              text: "作品",
                            ),
                            Tab(
                              text: "喜欢",
                            ),
                          ],
                        ),
                      ),
                      preferredSize: Size(AppBar().preferredSize.width, 44),
                    ),
                  ),
                ];
              },
              body: TabBarView(
                controller: _tabController,
                children: [
                  TabViewItem(
                    tabKey: Key("kBaseHomePagePositionKey" + "0"),
                    child: HomeDynamicList(dynamicType: 0),
                  ),
                  TabViewItem(
                    tabKey: Key("kBaseHomePagePositionKey" + "1"),
                    child: HomeDynamicList(dynamicType: 1),
                  ),
                ],
              ),
              pinnedHeaderSliverHeightBuilder: () {
                return MediaQuery.of(context).padding.top +
                    AppBar().preferredSize.height +
                    44;
              },
              innerScrollPositionKeyBuilder: () {
                String index = "kBaseHomePagePositionKey";
                index += _tabController.index.toString();
                return Key(index);
              },
            ),
    );
  }
}

// ignore: must_be_immutable
class TabViewItem extends StatefulWidget {
  Key tabKey;
  Widget child;

  TabViewItem({
    Key key,
    @required this.tabKey,
    @required this.child,
  });

  @override
  _TabViewItemState createState() => _TabViewItemState();
}

class _TabViewItemState extends State<TabViewItem>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return NestedScrollViewInnerScrollPositionKeyWidget(
      this.widget.tabKey,
      this.widget.child,
    );
  }
}
