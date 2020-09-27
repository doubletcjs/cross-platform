import 'package:corner_app/pages/function/general_share.dart';
import 'package:corner_app/pages/function/scale_tabbar.dart';
import 'package:corner_app/pages/function/sticky/sticky_navigator_bar.dart';
import 'package:corner_app/pages/function/sticky/sticky_scrollview.dart';
import 'package:corner_app/pages/module/mine/minedynamic.dart';
import 'package:corner_app/pages/module/mine/views/mineheader.dart';
import 'package:corner_app/pages/module/space/views/space_tabbar.dart';
import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

class MineTabPage extends StatefulWidget {
  MineTabPage({Key key}) : super(key: key);

  @override
  _MineTabPageState createState() => _MineTabPageState();
}

class _MineTabPageState extends State<MineTabPage>
    with SingleTickerProviderStateMixin {
  GlobalKey _headerGlobalKey = GlobalKey();

  double _headerHeight = 0;
  double _stickyOpacity = 0;
  double _stickyBarHeight = 44 + 48.0;
  double _mixTopBarHeight;

  Widget _header;

  TabController _tabController;
  int _tabIndex = 0;
  MineDynamic _dynamicPage = MineDynamic();

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: 3);
    _header = Column(
      children: [
        MineHeader(
          globalKey: _headerGlobalKey,
          isMinePage: true,
        ),
      ],
    );

    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        _headerHeight = _headerGlobalKey.currentContext.size.height;
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
                  brightness: _stickyOpacity >= 0.8
                      ? Brightness.light
                      : Brightness.dark,
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
                              Tab(text: "收藏"),
                              Tab(text: "喜欢"),
                            ],
                            onTap: (index) {
                              setState(() {
                                if (index == 2) {
                                  _stickyBarHeight = 44;
                                } else {
                                  _stickyBarHeight = 44 + 48.0;
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
                                  "全部动态",
                                  "草稿",
                                ],
                                tabIndex: _dynamicPage.tab,
                                height: _stickyBarHeight - 44,
                                tabSwitchHandle: (tab) {
                                  setState(() {
                                    _dynamicPage.tab = tab;
                                  });
                                },
                              )
                            : _tabIndex == 1
                                ? SpaceTabBar(
                                    tabList: [
                                      "全部动态",
                                      "商品",
                                    ],
                                    // tabIndex: _dynamicPage.tab,
                                    tabIndex: 0,
                                    height: _stickyBarHeight - 44,
                                    tabSwitchHandle: (tab) {
                                      setState(() {
                                        // _dynamicPage.tab = tab;
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
                        child: Container(),
                      ),
                      TabViewItem(
                        tabKey: Key(kBaseStorePagePositionKey + "2"),
                        child: Container(),
                      ),
                    ],
                  ),
                  offsetChange: (offSet) {
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
                  },
                  keyIndex: _tabController.index,
                ),
          StickyNavigatorBar(
            backgroudOpacity: _stickyOpacity,
            lefts: Container(
              // 返回
              width: AppBar().preferredSize.height,
              height: AppBar().preferredSize.height,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(AppBar().preferredSize.height / 2),
              ),
              child: FlatButton(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(AppBar().preferredSize.height / 2),
                ),
                child: Image.asset(
                  _stickyOpacity >= 0.8
                      ? "images/icon_me_more@3x.png"
                      : "images/homepage_menu@3x.png",
                  width: 28,
                  height: 28,
                ),
                onPressed: () {},
              ),
            ),
            rights: Container(
              // 分享
              width: AppBar().preferredSize.height,
              height: AppBar().preferredSize.height,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(AppBar().preferredSize.height / 2),
              ),
              child: FlatButton(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(AppBar().preferredSize.height / 2),
                ),
                child: Image.asset(
                  _stickyOpacity >= 0.8
                      ? "images/icon_me_share_grey@3x.png"
                      : "images/icon_me_share@3x.png",
                  width: 28,
                  height: 28,
                ),
                onPressed: () {
                  GeneralShare().show(
                    context,
                    maxRow: 4,
                    baseList: [
                      {
                        "icon": "images/share_wechat_icon@3x.png",
                        "title": "分享给\n微信好友",
                        "mark": "wechat",
                      },
                      {
                        "icon": "images/share_wechatzone_icon@3x.png",
                        "title": "分享到\n朋友圈",
                        "mark": "wechazone",
                      },
                      {
                        "icon": "images/share_weibo_icon@3x.png",
                        "title": "分享到\n微博",
                        "mark": "weibo",
                      },
                      {
                        "icon": "images/share_qq_icon@3x.png",
                        "title": "分享给\nQQ好友",
                        "mark": "qq",
                      },
                    ],
                    otherList: [],
                  );
                },
              ),
            ),
            barHeight: AppBar().preferredSize.height,
            background: Container(
              color: rgba(255, 255, 255, 1),
              width: MediaQuery.of(context).size.width,
              height: AppBar().preferredSize.height +
                  MediaQuery.of(context).padding.top,
              alignment: Alignment.bottomCenter,
              child: Container(
                height: AppBar().preferredSize.height,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    networkImage(
                      "https://avatars1.githubusercontent.com/u/17046133?v=4",
                      Size(24, 24),
                      BorderRadius.circular(24 / 2),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "是凉白开鸭",
                      style: TextStyle(
                        fontSize: 18,
                        color: rgba(50, 50, 50, 1),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
