import 'package:corner_app/pages/function/general_complaint.dart';
import 'package:corner_app/pages/function/general_share.dart';
import 'package:corner_app/pages/store/home/views/store_header.dart';
import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';

class StoreTouristPage extends StatefulWidget {
  StoreTouristPage({Key key}) : super(key: key);

  @override
  _StoreTouristPageState createState() => _StoreTouristPageState();
}

class _StoreTouristPageState extends State<StoreTouristPage>
    with SingleTickerProviderStateMixin {
  GlobalKey _globalKey = GlobalKey();
  double _stickyBarHeight = 0;
  double _stickyOpacity = 0;
  double _headerHeight = 0;

  int _tabIndex = 0;

  TabController _tabController;
  ScrollController _scrollViewController;
  double _stickyHeaderOpacity = 0;

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

    _tabController = TabController(vsync: this, length: 3);
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);

    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        _stickyBarHeight =
            AppBar().preferredSize.height + MediaQuery.of(context).padding.top;
        _headerHeight = _globalKey.currentContext.size.height;
      });
    });

    _scrollViewController.addListener(() {
      double _opacityHeight =
          (_headerHeight - _stickyBarHeight) - AppBar().preferredSize.height;
      double _offSet = _scrollViewController.offset - _opacityHeight;
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
    _scrollViewController.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          transparentAppBar(
            brightness: Brightness.dark,
          ),
          ListView(
            controller: _scrollViewController,
            padding: EdgeInsets.only(
              top: 0,
              bottom: MediaQuery.of(context).padding.bottom,
            ),
            children: [
              Column(
                key: _globalKey,
                mainAxisSize: MainAxisSize.min,
                children: [
                  StoreHeader(
                    isTourist: true,
                  ),
                ],
              ),
              StickyHeader(
                header: Container(
                  padding: EdgeInsets.only(
                    top: _stickyBarHeight * _stickyHeaderOpacity,
                  ),
                  height: 44 + _stickyBarHeight * _stickyHeaderOpacity,
                  color: rgba(255, 255, 255, 1),
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
                                            BorderRadius.circular(3 / 2),
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
                content: Container(
                  height: 800,
                ),
              )
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
                            "images/icon_tourist_share@3x.png",
                            width: 20,
                            height: 20,
                          ),
                          onPressed: () {
                            this._shareAction();
                          },
                        ),
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
