import 'package:corner_app/pages/function/scale_tabbar.dart';
import 'package:corner_app/pages/function/sticky/sticky_navigator_bar.dart';
import 'package:corner_app/pages/function/sticky/sticky_scrollview.dart';
import 'package:corner_app/pages/store/detail/store_detail.dart';
import 'package:corner_app/pages/store/discuss/store_discuss_page.dart';
import 'package:corner_app/pages/store/dynamic/store_dynamic_page.dart';
import 'package:corner_app/pages/store/home/store_search_page.dart';
import 'package:corner_app/pages/store/home/views/store_banner.dart';
import 'package:corner_app/pages/store/home/views/store_header.dart';
import 'package:corner_app/pages/store/home/views/store_live.dart';
import 'package:corner_app/pages/store/home/views/store_tabbar.dart';
import 'package:corner_app/pages/store/product/store_product_page.dart';
import 'package:corner_app/pages/store/product/views/store_product_header.dart';
import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart' hide NestedScrollView;

import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';

class StorePage extends StatefulWidget {
  StorePage({Key key}) : super(key: key);

  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage>
    with SingleTickerProviderStateMixin {
  GlobalKey _headerGlobalKey = GlobalKey();
  GlobalKey _liveGlobalKey = GlobalKey();
  GlobalKey _bannerGlobalKey = GlobalKey();

  double _stickyOpacity = 0;
  double _stickyBarHeight = 88;
  double _headerHeight = 0;
  Widget _header;

  TabController _tabController;
  int _tabIndex = 0;
  StoreDynamicPage _dynamicPage = StoreDynamicPage();
  StoreProductPage _productPage = StoreProductPage();
  StoreDiscussPage _discussPage = StoreDiscussPage();

  // 商铺详情
  void _showDetail() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return StoreDetailPage();
      }),
    );
  }

  // 搜索
  void _searchAction() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return StoreSearchPage();
      }),
    );
  }

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: 3);
    _header = Column(
      // padding: EdgeInsets.zero,
      // physics: NeverScrollableScrollPhysics(),
      children: [
        StoreHeader(
          globalKey: _headerGlobalKey,
        ),
        StoreLive(
          globalKey: _liveGlobalKey,
        ),
        StoreBanner(
          globalKey: _bannerGlobalKey,
        ),
      ],
    );

    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        _headerHeight = _headerGlobalKey.currentContext.size.height;
        _headerHeight += _liveGlobalKey.currentContext.size.height;
        _headerHeight += _bannerGlobalKey.currentContext.size.height;
        _headerHeight = _headerHeight - MediaQuery.of(context).padding.top;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _headerHeight == 0
              ? _header
              : StickyScrollView(
                  expandedHeight: _headerHeight,
                  expandedChild: _header,
                  stickyBarHeight: MediaQuery.of(context).padding.top +
                      AppBar().preferredSize.height,
                  stickyBar: Container(
                    height: _stickyBarHeight,
                    color: rgba(255, 255, 255, 1),
                    child: Column(
                      children: [
                        // tab bar
                        Container(
                          height: 44,
                          child: ScaleTabBar(
                            controller: _tabController,
                            indicator: RoundUnderlineTabIndicator(
                              borderSide: BorderSide(
                                width: 4,
                                color: rgba(235, 102, 91, 1),
                              ),
                            ),
                            tabs: [
                              Tab(text: "动态"),
                              Tab(text: "商店"),
                              Tab(text: "讨论区"),
                            ],
                            onTap: (index) {
                              setState(() {
                                if (index == 1) {
                                  _stickyBarHeight = 44 + 64 + 44 + 8.0;
                                } else {
                                  _stickyBarHeight = 88;
                                }

                                _tabIndex = index;
                              });
                            },
                            labelColor: rgba(50, 50, 50, 1),
                            unselectedLabelColor: rgba(153, 153, 153, 1),
                            labelStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            unselectedLabelStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        // sub tab bar
                        _tabIndex == 0
                            ? StoreTabBar(
                                tabList: [
                                  "最新",
                                  "热门",
                                  "精华",
                                ],
                                tabIndex: _dynamicPage.tab,
                                height: _stickyBarHeight - 44,
                                tabSwitchHandle: (tab) {
                                  setState(() {
                                    _dynamicPage.tab = tab;
                                  });
                                },
                              )
                            : _tabIndex == 2
                                ? StoreTabBar(
                                    tabList: [
                                      "最新",
                                      "热门",
                                    ],
                                    tabIndex: _productPage.tab,
                                    height: _stickyBarHeight - 44,
                                    tabSwitchHandle: (tab) {
                                      setState(() {
                                        _productPage.tab = tab;
                                      });
                                    },
                                  )
                                : _tabIndex == 1
                                    ? StoreProductHeader(
                                        tabIndex: _discussPage.tab,
                                        tabSwitchHandle: (tab) {
                                          setState(() {
                                            _discussPage.tab = tab;
                                          });
                                        },
                                      )
                                    : Container(),
                      ],
                    ),
                  ),
                  contentView: TabBarView(
                    controller: _tabController,
                    children: [
                      TabViewItem(
                        Key("kStorePagePositionKey" + "0"),
                        _stickyBarHeight +
                            MediaQuery.of(context).padding.top +
                            AppBar().preferredSize.height +
                            MediaQuery.of(context).padding.bottom,
                      ),
                      TabViewItem(
                        Key("kStorePagePositionKey" + "1"),
                        _stickyBarHeight +
                            MediaQuery.of(context).padding.top +
                            AppBar().preferredSize.height +
                            MediaQuery.of(context).padding.bottom,
                      ),
                      TabViewItem(
                        Key("kStorePagePositionKey" + "2"),
                        _stickyBarHeight +
                            MediaQuery.of(context).padding.top +
                            AppBar().preferredSize.height +
                            MediaQuery.of(context).padding.bottom,
                      ),
                    ],
                  ),
                  offsetChange: (offset) {
                    double _opacity = offset / _headerHeight;
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
                  },
                  tabIndex: _tabController.index,
                ),
          // 导航栏
          StickyNavigatorBar(
            backgroudOpacity: _stickyOpacity,
            lefts: Row(
              children: [
                // 返回
                Container(
                  width: AppBar().preferredSize.height,
                  height: AppBar().preferredSize.height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        AppBar().preferredSize.height / 2),
                  ),
                  child: FlatButton(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          AppBar().preferredSize.height / 2),
                    ),
                    child: Image.asset(
                      "images/base_back_white@3x.png",
                      width: 11,
                      height: 20,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                // 标题
                Opacity(
                  opacity: _stickyOpacity,
                  child: Text(
                    "每日一食记",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20,
                      color: rgba(255, 255, 255, 1),
                    ),
                  ),
                ),
              ],
            ),
            rights: Row(
              children: [
                // 搜索
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28 / 2),
                  ),
                  child: FlatButton(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28 / 2),
                    ),
                    child: Image.asset(
                      "images/homepage_search@3x.png",
                      width: 28,
                      height: 28,
                    ),
                    onPressed: () {
                      this._searchAction();
                    },
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                // 详情
                Container(
                  width: 28,
                  height: 28,
                  child: FlatButton(
                    padding: EdgeInsets.zero,
                    child: Image.asset(
                      "images/homepage_menu@3x.png",
                      width: 28,
                      height: 28,
                    ),
                    onPressed: () {
                      this._showDetail();
                    },
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TabViewItem extends StatefulWidget {
  const TabViewItem(
    this.tabKey,
    this.bottomSpace,
  );
  final Key tabKey;
  final double bottomSpace;

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
      ListView.builder(
        itemBuilder: (BuildContext c, int i) {
          return Container(
            //decoration: BoxDecoration(border: Border.all(color: Colors.orange,width: 1.0)),
            alignment: Alignment.center,
            height: 60.0,
            width: double.infinity,
            //color: Colors.blue,
            child: Text(widget.tabKey.toString() + ': List$i'),
            decoration: BoxDecoration(
                border: Border(
              bottom: BorderSide(
                width: 1,
                color: Colors.red,
              ),
            )),
          );
        },
        itemCount: 50,
        // padding: EdgeInsets.zero,
        padding: EdgeInsets.only(
          bottom: this.widget.bottomSpace,
        ),
      ),
    );
  }
}
