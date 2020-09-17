import 'package:corner_app/pages/function/scale_tabbar.dart';
import 'package:corner_app/pages/function/sticky/sticky_scrollview.dart';
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

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: 3);
    _header = Column(
      children: [
        Container(
          key: _headerGlobalKey,
          color: Colors.red,
          height: 400,
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
                                // tabIndex: _dynamicPage.tab,
                                tabIndex: 0,
                                height: _stickyBarHeight - 44,
                                tabSwitchHandle: (tab) {
                                  setState(() {
                                    // _dynamicPage.tab = tab;
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
                  contentView: Container(),
                  offsetChange: (offSet) {},
                  keyIndex: _tabController.index,
                ),
        ],
      ),
    );
  }
}
