import 'package:corner_app/pages/function/scale_tabbar.dart';
import 'package:corner_app/pages/function/sticky/sticky_navigator_bar.dart';
import 'package:corner_app/pages/function/sticky/sticky_scrollview.dart';
import 'package:corner_app/pages/module/space/module/detail/space_detail.dart';
import 'package:corner_app/pages/module/discuss/discuss_input.dart';
import 'package:corner_app/pages/module/discuss/discuss_page.dart';
import 'package:corner_app/pages/module/dynamic/dynamic_page.dart';
import 'package:corner_app/pages/module/dynamic/dynamic_post.dart';
import 'package:corner_app/pages/module/space/space_search.dart';
import 'package:corner_app/pages/module/space/views/space_banner.dart';
import 'package:corner_app/pages/module/space/views/space_header.dart';
import 'package:corner_app/pages/module/space/views/space_live.dart';
import 'package:corner_app/pages/module/space/views/space_tabbar.dart';
import 'package:corner_app/pages/module/store/module/space/sapce_store_page.dart';
import 'package:corner_app/pages/module/store/module/space/views/sapce_store_header.dart';
import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart' hide NestedScrollView;

class SpacePage extends StatefulWidget {
  SpacePage({Key key}) : super(key: key);

  @override
  _SpacePageState createState() => _SpacePageState();
}

class _SpacePageState extends State<SpacePage>
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
  DynamicPage _dynamicPage = DynamicPage();
  SpaceStorePage _productPage = SpaceStorePage();
  DiscussPage _discussPage = DiscussPage();
  double _mixTopBarHeight;

  // 商铺详情
  void _showDetail() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return SpaceDetailPage();
      }),
    );
  }

  // 搜索
  void _searchAction() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return SpaceSearchPage();
      }),
    );
  }

  // 发布
  void _dynamicPost() {
    DynamicPost(
      tapHandle: (mark) {},
    ).show(context);
  }

  // 评论
  void _discussPost() {
    DiscussInput(
      postHandle: (text) {
        showToast("发布成功", context);
      },
    ).show(context);
  }

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: 3);
    _header = Column(
      children: [
        SpaceHeader(
          globalKey: _headerGlobalKey,
        ),
        SpaceLive(
          globalKey: _liveGlobalKey,
        ),
        SpaceBanner(
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

        _mixTopBarHeight = _stickyBarHeight +
            MediaQuery.of(context).padding.top +
            AppBar().preferredSize.height +
            MediaQuery.of(context).padding.bottom;
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
                  topBarHeight: _mixTopBarHeight,
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
                                _mixTopBarHeight = _stickyBarHeight +
                                    MediaQuery.of(context).padding.top +
                                    AppBar().preferredSize.height +
                                    MediaQuery.of(context).padding.bottom;
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
                            ? SpaceTabBar(
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
                                ? SpaceTabBar(
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
                                    ? SpaceStoreHeader(
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
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      TabViewItem(
                        tabKey: Key(kBaseStorePagePositionKey + "0"),
                        child: _dynamicPage,
                      ),
                      TabViewItem(
                        tabKey: Key(kBaseStorePagePositionKey + "1"),
                        child: _productPage,
                      ),
                      TabViewItem(
                        tabKey: Key(kBaseStorePagePositionKey + "2"),
                        child: _discussPage,
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
                  keyIndex: _tabController.index,
                ),
          // 导航栏
          StickyNavigatorBar(
            backgroudOpacity: _stickyOpacity,
            barHeight: AppBar().preferredSize.height,
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
      floatingActionButton: _stickyOpacity >= 0.9
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
                    onPressed: () {
                      this._discussPost();
                    },
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
      resizeToAvoidBottomInset: false,
    );
  }
}
