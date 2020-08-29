import 'package:corner_app/pages/function/scale_tabbar.dart';
import 'package:corner_app/pages/store/store_detail.dart';
import 'package:corner_app/pages/store/store_discuss.dart';
import 'package:corner_app/pages/store/store_dynamic.dart';
import 'package:corner_app/pages/store/store_product.dart';
import 'package:corner_app/pages/store/home/views/store_banner.dart';
import 'package:corner_app/pages/store/home/views/store_header.dart';
import 'package:corner_app/pages/store/home/views/store_live.dart';
import 'package:corner_app/pages/store/home/views/store_tabbar.dart';
import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

class StorePage extends StatefulWidget {
  StorePage({Key key}) : super(key: key);

  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollViewController;
  TabController _tabController;
  GlobalKey _globalKey = GlobalKey();
  double _expandedHeight = 0;
  double _stickyOpacity = 0;
  Widget _header;
  double _headerHeight = 0;

  double _stickyBarHeight = 0;
  double _stickyBottomBarHeight = 44.0;
  int _tabIndex = 0;

  StoreDynamicPage _dynamicPage = StoreDynamicPage();
  StoreProductPage _productPage = StoreProductPage();
  StoreDiscussPage _discussPage = StoreDiscussPage();

  // 头部内容
  void _flexibleHeader() {
    _header = Column(
      key: _globalKey,
      mainAxisSize: MainAxisSize.min,
      children: [
        StoreHeader(),
        StoreLive(),
        StoreBanner(),
      ],
    );

    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        _headerHeight = _globalKey.currentContext.size.height;
        _expandedHeight = _headerHeight + 44 + _stickyBottomBarHeight;
        _stickyBarHeight =
            AppBar().preferredSize.height + MediaQuery.of(context).padding.top;
      });
    });
  }

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
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
    this._flexibleHeader();

    _scrollViewController.addListener(() {
      double _barHeight = 44 + MediaQuery.of(context).padding.top + 44;
      double _opacity =
          _scrollViewController.offset / (_expandedHeight - _barHeight);
      if (_opacity > 1) {
        _opacity = 1;
      }

      if (_opacity < 0) {
        _opacity = 0;
      }

      setState(() {
        _stickyOpacity = _opacity;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollViewController.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          transparentAppBar(
            brightness: Brightness.light,
          ),
          _expandedHeight == 0
              ? _header
              : NestedScrollView(
                  controller: _scrollViewController,
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverAppBar(
                        pinned: true,
                        floating: true,
                        primary: false,
                        expandedHeight: _expandedHeight,
                        elevation: 0,
                        automaticallyImplyLeading: false,
                        titleSpacing: 0,
                        backgroundColor: Colors.transparent,
                        //头部
                        flexibleSpace: FlexibleSpaceBar(
                          collapseMode: CollapseMode.parallax,
                          background: _header,
                        ),
                        bottom: PreferredSize(
                          child: Container(
                            height: 44 + _stickyBottomBarHeight,
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
                                          _stickyBottomBarHeight =
                                              64 + 44 + 8.0;
                                        } else {
                                          _stickyBottomBarHeight = 44;
                                        }
                                        _expandedHeight = _headerHeight +
                                            44 +
                                            _stickyBottomBarHeight;
                                      });
                                    },
                                    labelColor: rgba(50, 50, 50, 1),
                                    unselectedLabelColor:
                                        rgba(153, 153, 153, 1),
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
                          preferredSize: Size.fromHeight(
                              44 + _stickyBarHeight + _stickyBottomBarHeight),
                        ),
                      ),
                    ];
                  },
                  body: TabBarView(
                    controller: _tabController,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      _dynamicPage,
                      _productPage,
                      _discussPage,
                    ],
                  ),
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
