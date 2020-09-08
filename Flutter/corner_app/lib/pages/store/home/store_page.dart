import 'package:corner_app/pages/function/scale_tabbar.dart';
import 'package:corner_app/pages/store/detail/store_detail.dart';
import 'package:corner_app/pages/store/discuss/store_discuss_page.dart';
import 'package:corner_app/pages/store/dynamic/store_dynamic_page.dart';
import 'package:corner_app/pages/store/home/views/store_banner.dart';
import 'package:corner_app/pages/store/home/views/store_header.dart';
import 'package:corner_app/pages/store/home/views/store_live.dart';
import 'package:corner_app/pages/store/home/views/store_tabbar.dart';
import 'package:corner_app/pages/store/product/store_product_page.dart';
import 'package:corner_app/pages/store/product/views/store_product_header.dart';
import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';

class StorePage extends StatefulWidget {
  StorePage({Key key}) : super(key: key);

  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage>
    with SingleTickerProviderStateMixin {
  GlobalKey _globalKey = GlobalKey();
  double _stickyBarHeight = 0;
  double _stickyOpacity = 0;
  double _headerHeight = 0;

  double _stickyBottomBarHeight = 44.0;
  int _tabIndex = 0;

  StoreDynamicPage _dynamicPage;
  StoreProductPage _productPage;
  StoreDiscussPage _discussPage;

  TabController _tabController;
  ScrollController _scrollController;
  double _stickyHeaderOpacity = 0;

  // 详情
  void _showDetail() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return StoreDetailPage();
      }),
    );
  }

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: 3);
    _scrollController = ScrollController(initialScrollOffset: 0.0);

    _dynamicPage = StoreDynamicPage(
      scrollController: _scrollController,
    );
    _productPage = StoreProductPage();
    _discussPage = StoreDiscussPage();

    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        _stickyBarHeight =
            AppBar().preferredSize.height + MediaQuery.of(context).padding.top;
        _headerHeight = _globalKey.currentContext.size.height;
      });
    });

    _scrollController.addListener(() {
      double _opacityHeight =
          (_headerHeight - _stickyBarHeight) - AppBar().preferredSize.height;
      double _offSet = _scrollController.offset - _opacityHeight;
      double _opacity = _offSet / AppBar().preferredSize.height;
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

      if (_opacity == 1) {
        double _headerOpacity =
            (_offSet - AppBar().preferredSize.height) / _stickyBarHeight;
        if (_headerOpacity > 1) {
          _headerOpacity = 1;
        }

        if (_headerOpacity < 0) {
          _headerOpacity = 0;
        }

        if (_stickyHeaderOpacity != _headerOpacity) {
          setState(() {
            _stickyHeaderOpacity = _headerOpacity;
          });
        }
      } else {
        setState(() {
          _stickyHeaderOpacity = 0;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rgba(247, 246, 245, 1),
      body: Stack(
        children: [
          transparentAppBar(
            brightness: Brightness.dark,
          ),
          ListView(
            controller: _scrollController,
            padding: EdgeInsets.only(
              top: 0,
              bottom: MediaQuery.of(context).padding.bottom,
            ),
            children: [
              Column(
                key: _globalKey,
                mainAxisSize: MainAxisSize.min,
                children: [
                  StoreHeader(),
                  StoreLive(),
                  StoreBanner(),
                ],
              ),
              StickyHeader(
                header: Container(
                  padding: EdgeInsets.only(
                    top: _stickyBarHeight * _stickyHeaderOpacity,
                  ),
                  height: 44 +
                      _stickyBottomBarHeight +
                      _stickyBarHeight * _stickyHeaderOpacity,
                  color: rgba(255, 255, 255, 1),
                  child: Column(
                    children: [
                      Container(
                        height: 44,
                        width: MediaQuery.of(context).size.width,
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
                              _tabIndex = index;
                              if (_tabIndex == 1) {
                                _stickyBottomBarHeight = 64 + 44 + 8.0;
                              } else {
                                _stickyBottomBarHeight = 44;
                              }
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
                      _tabIndex == 0
                          ? StoreTabBar(
                              tabList: [
                                "最新",
                                "热门",
                                "精华",
                              ],
                              tabIndex: _dynamicPage.tab,
                              height: _stickyBottomBarHeight,
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
                                  height: _stickyBottomBarHeight,
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
                content: _tabIndex == 0
                    ? _dynamicPage
                    : _tabIndex == 1
                        ? _productPage
                        : _tabIndex == 2 ? _discussPage : Container(),
              ),
            ],
          ),
          Container(
            height: _stickyBarHeight,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  child: Opacity(
                    opacity: _stickyOpacity,
                    child: Stack(
                      children: [
                        Image.asset(
                          "images/homepages_default_bg.png",
                          height: 217 + MediaQuery.of(context).padding.top,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          color: rgba(0, 0, 0, 0.4),
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).padding.top,
                          ),
                          height: 217 + MediaQuery.of(context).padding.top,
                        ),
                      ],
                    ),
                  ),
                ),
                // 顶部栏
                Positioned(
                  top: MediaQuery.of(context).padding.top,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // 返回
                      Row(
                        children: [
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
                      Row(
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
                              onPressed: () {},
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
