import 'package:corner_app/pages/function/general_complaint.dart';
import 'package:corner_app/pages/function/general_share.dart';
import 'package:corner_app/pages/function/sticky/sticky_navigator_bar.dart';
import 'package:corner_app/pages/function/sticky/sticky_scrollview.dart';
import 'package:corner_app/pages/store/home/views/store_header.dart';
import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

class StoreTouristPage extends StatefulWidget {
  StoreTouristPage({Key key}) : super(key: key);

  @override
  _StoreTouristPageState createState() => _StoreTouristPageState();
}

class _StoreTouristPageState extends State<StoreTouristPage>
    with SingleTickerProviderStateMixin {
  GlobalKey _headerGlobalKey = GlobalKey();

  double _headerHeight = 0;
  double _stickyOpacity = 0;
  double _stickyBarHeight = 44 + 18.5;
  Widget _header;
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

    _header = ListView(
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      children: [
        StoreHeader(
          globalKey: _headerGlobalKey,
          isTourist: true,
        ),
      ],
    );

    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        _headerHeight = _headerGlobalKey.currentContext.size.height;
        _headerHeight = _headerHeight - MediaQuery.of(context).padding.top;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
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
                  contentView: Container(),
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
                ), // 导航栏
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
