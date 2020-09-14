import 'package:corner_app/pages/function/scale_tabbar.dart';
import 'package:corner_app/pages/function/sticky/sticky_navigator_bar.dart';
import 'package:corner_app/pages/store/detail/store_detail.dart';
import 'package:corner_app/pages/store/discuss/store_discuss_page.dart';
import 'package:corner_app/pages/store/dynamic/store_dynamic_page.dart';
import 'package:corner_app/pages/store/home/store_search_page.dart';
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
  double _stickyOpacity = 0;
  double _stickyBarHeight = 88;

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
          NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 200.0,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin,
                    background: Container(
                      height: 200,
                      color: Colors.green,
                    ),
                  ),
                ),
              ];
            },
            pinnedHeaderSliverHeightBuilder: () {
              return _stickyBarHeight;
            },
            innerScrollPositionKeyBuilder: () {
              kLog("indes:${"Tab_$_tabIndex"}");
              return Key("Tab_$_tabIndex");
            },
            body: Column(
              children: [
                Container(
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
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      Container(),
                      Container(),
                      Container(),
                    ],
                  ),
                ),
              ],
            ),
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
