import 'package:corner_app/pages/function/scale_tabbar.dart';
import 'package:corner_app/pages/function/sticky/sticky_navigator_bar.dart';
import 'package:corner_app/pages/function/sticky/sticky_scrollview.dart';
import 'package:corner_app/pages/store/detail/store_detail.dart';
import 'package:corner_app/pages/store/discuss/store_discuss_page.dart';
import 'package:corner_app/pages/store/dynamic/store_dynamic_page.dart';
import 'package:corner_app/pages/store/dynamic/store_dynamic_post.dart';
import 'package:corner_app/pages/store/home/store_search_page.dart';
import 'package:corner_app/pages/store/home/views/store_banner.dart';
import 'package:corner_app/pages/store/home/views/store_header.dart';
import 'package:corner_app/pages/store/home/views/store_live.dart';
import 'package:corner_app/pages/store/home/views/store_tabbar.dart';
import 'package:corner_app/pages/store/product/store_product_page.dart';
import 'package:corner_app/pages/store/product/views/store_product_header.dart';
import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

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

  double _headerHeight = 0;
  double _stickyOpacity = 0;
  double _stickyBarHeight = 88;
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

  // 发布
  void _dynamicPost() {
    StoreDynamicPost(
      tapHandle: (mark) {},
    ).show(context);
  }

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: 3);

    _header = ListView(
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
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

    Future.delayed(Duration(milliseconds: 200), () {
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
                  stickyBarHeight: _stickyBarHeight,
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
                    physics: NeverScrollableScrollPhysics(),
                    controller: _tabController,
                    children: [
                      _dynamicPage,
                      _productPage,
                      _discussPage,
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
      floatingActionButton: _stickyOpacity == 1
          ? (_tabIndex == 2
              ? Container(
                  width: MediaQuery.of(context).size.width - 32,
                  height: 48,
                  decoration: BoxDecoration(
                    color: rgba(255, 255, 255, 1),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: rgba(0, 0, 0, 0.16),
                        blurRadius: 8,
                        offset: Offset.zero,
                      ),
                    ],
                  ),
                  child: FlatButton(
                    padding: EdgeInsets.fromLTRB(23.5, 0, 22.5, 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "留下你的精彩讨论吧",
                          style: TextStyle(
                            fontSize: 16,
                            color: rgba(153, 153, 153, 1),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Image.asset(
                          "images/input_bar_icon@3x.png",
                          width: 28,
                          height: 28,
                        ),
                      ],
                    ),
                  ),
                )
              : Container(
                  width: 84,
                  height: 84,
                  child: Stack(
                    children: [
                      FlatButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          if (_tabIndex == 0) {
                            this._dynamicPost();
                          }
                        },
                        child: Image.asset(
                          _tabIndex == 1
                              ? "images/store_shopping_cart@3x.png"
                              : "images/dynamic_post@3x.png",
                          width: 84,
                          height: 84,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(84 / 2),
                        ),
                      ),
                      _tabIndex == 1
                          ? Positioned(
                              top: 6,
                              right: 12,
                              child: Container(
                                height: 20,
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(
                                  left: 6.5,
                                  right: 6.5,
                                ),
                                constraints: BoxConstraints(
                                  minWidth: 20,
                                ),
                                decoration: BoxDecoration(
                                  color: rgba(235, 102, 91, 1),
                                  borderRadius: BorderRadius.circular(20 / 2),
                                ),
                                child: Text(
                                  "1",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: rgba(255, 255, 255, 1),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ))
          : Container(),
    );
  }
}
