import 'package:corner_app/pages/function/general_complaint.dart';
import 'package:corner_app/pages/function/general_share.dart';
import 'package:corner_app/pages/function/sticky/sticky_navigator_bar.dart';
import 'package:corner_app/pages/function/sticky/sticky_scrollview.dart';
import 'package:corner_app/pages/module/space/views/space_header.dart';
import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

class SpaceTouristPage extends StatefulWidget {
  SpaceTouristPage({Key key}) : super(key: key);

  @override
  _SpaceTouristPageState createState() => _SpaceTouristPageState();
}

class _SpaceTouristPageState extends State<SpaceTouristPage>
    with SingleTickerProviderStateMixin {
  GlobalKey _headerGlobalKey = GlobalKey();

  double _headerHeight = 0;
  double _stickyOpacity = 0;
  double _stickyBarHeight = 44 + 18.5;
  double _mixTopBarHeight;

  Widget _header;

  TabController _tabController;
  int _tabIndex = 0;

  // 分享
  void _shareAction() {
    GeneralShare(
      shareHandle: (item) {
        kLog("$item");
        if (item == "report") {
          GeneralComplaint().show(context);
        }
      },
    ).show(context);
  }

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: 2);
    _header = Column(
      children: [
        SpaceHeader(
          globalKey: _headerGlobalKey,
          isTourist: true,
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
                          child: Row(
                            children: [
                              "精选内容",
                              "商店",
                            ].map((tab) {
                              var index = [
                                "精选内容",
                                "商店",
                              ].indexOf(tab);
                              return Stack(
                                children: [
                                  FlatButton(
                                    onPressed: () {
                                      setState(() {
                                        _tabIndex = index;
                                        _tabController.index = index;
                                      });
                                    },
                                    child: Text(
                                      "$tab",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: _tabIndex == index
                                            ? rgba(50, 50, 50, 1)
                                            : rgba(153, 153, 153, 1),
                                        fontWeight: _tabIndex == index
                                            ? FontWeight.w500
                                            : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  _tabIndex == index
                                      ? Positioned(
                                          left: 0,
                                          right: 0,
                                          bottom: 0,
                                          child: Center(
                                            child: Container(
                                              width: 16,
                                              height: 3,
                                              decoration: BoxDecoration(
                                                color: rgba(235, 102, 91, 1),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        3 / 2),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container(),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  contentView: TabBarView(
                    controller: _tabController,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      TabViewItem(
                        tabKey: Key(kBaseStorePagePositionKey + "0"),
                        child: Container(),
                      ),
                      TabViewItem(
                        tabKey: Key(kBaseStorePagePositionKey + "1"),
                        child: Container(),
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
                ), // 导航栏
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
            // 分享
            rights: Container(
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
                  "images/icon_tourist_share@3x.png",
                  width: 20,
                  height: 20,
                ),
                onPressed: () {
                  this._shareAction();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
