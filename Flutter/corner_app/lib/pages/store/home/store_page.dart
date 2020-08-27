import 'package:corner_app/pages/store/home/views/store_banner.dart';
import 'package:corner_app/pages/store/home/views/store_header.dart';
import 'package:corner_app/pages/store/home/views/store_live.dart';
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
  double _stickyHeight = 0;
  Widget _header;

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
        _expandedHeight = _globalKey.currentContext.size.height + 44;
      });
    });
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

      // _opacity/1 = x/(MediaQuery.of(context).padding.top + 44)
      setState(() {
        _stickyOpacity = _opacity;
        _stickyHeight = _opacity * (MediaQuery.of(context).padding.top + 44);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollViewController.dispose();
    _tabController.dispose();
  }

  Widget _buildListView(String s) {
    return ListView.separated(
        itemCount: 20,
        separatorBuilder: (BuildContext context, int index) => Divider(
              color: Colors.grey,
              height: 1,
            ),
        itemBuilder: (BuildContext context, int index) {
          return Container(
              color: Colors.white,
              child: ListTile(title: Text("$s第$index 个条目")));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _expandedHeight == 0
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
                    stretchTriggerOffset:
                        MediaQuery.of(context).padding.top + 44 + 44,
                    expandedHeight: _expandedHeight,
                    elevation: 0,
                    automaticallyImplyLeading: false,
                    titleSpacing: 0,
                    brightness: Brightness.light,
                    //头部
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      background: _header,
                    ),
                    bottom: PreferredSize(
                      child: Container(
                        height: 44 + _stickyHeight,
                        child: Stack(
                          children: [
                            Opacity(
                              opacity: _stickyOpacity,
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 0,
                                    width: MediaQuery.of(context).size.width,
                                    height: 217 +
                                        MediaQuery.of(context).padding.top -
                                        20,
                                    child: Image.asset(
                                      "images/homepages_default_bg.png",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    child: Container(
                                      color: rgba(0, 0, 0, 0.4),
                                      padding: EdgeInsets.only(
                                        top: MediaQuery.of(context).padding.top,
                                      ),
                                      child: // 顶部栏
                                          Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              // 返回
                                              Container(
                                                width: 44,
                                                height: 44,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          44 / 2),
                                                ),
                                                child: FlatButton(
                                                  padding: EdgeInsets.zero,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            44 / 2),
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
                                              InkWell(
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text(
                                                  "每日一食记",
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color:
                                                        rgba(255, 255, 255, 1),
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
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          28 / 2),
                                                ),
                                                child: FlatButton(
                                                  padding: EdgeInsets.zero,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            28 / 2),
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
                                                  onPressed: () {},
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
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              left: 0,
                              bottom: 0,
                              right: 0,
                              height: 44,
                              child: Container(
                                color: Colors.green,
                                child: TabBar(
                                  controller: _tabController,
                                  tabs: [
                                    Tab(text: "aaa"),
                                    Tab(text: "bbb"),
                                    Tab(text: "ccc"),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      preferredSize: Size.fromHeight(44 + _stickyHeight),
                    ),
                  ),
                ];
              },
              body: TabBarView(
                controller: _tabController,
                children: [
                  _buildListView("aaa:"),
                  _buildListView("bbb:"),
                  _buildListView("ccc:"),
                ],
              ),
            ),
    );
  }
}
