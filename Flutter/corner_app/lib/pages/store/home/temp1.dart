import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  TabController _tabController;
  int _tabIndex = 0;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _tabIndex = _tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  expandedHeight: 930.0,
                  pinned: true,
                  brightness: Brightness.light,
                  elevation: 0,
                  backgroundColor: Colors.white,
                  flexibleSpace: Container(
                    color: Colors.yellow,
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: StickyBarDelegate(
                    barHeight: _tabIndex == 0 ? 88 : 148,
                    child: Container(
                      height: _tabIndex == 0 ? 88 : 148,
                      color: Colors.green,
                      child: Column(
                        children: [
                          TabBar(
                            labelColor: Colors.black,
                            controller: _tabController,
                            tabs: <Widget>[
                              Tab(text: '资讯'),
                              Tab(text: '技术'),
                            ],
                            onTap: (index) {
                              setState(() {
                                _tabIndex = index;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: Container(
              child: ListView(
                padding: EdgeInsets.only(
                  top: 0,
                  bottom: MediaQuery.of(context).padding.bottom,
                ),
                children: [
                  Container(
                    height: 100,
                    color: Colors.red,
                  ),
                  Container(
                    height: 200,
                    color: Colors.yellow,
                  ),
                  Container(
                    height: 100,
                    color: Colors.green,
                  ),
                  Container(
                    height: 400,
                    color: Colors.brown,
                  ),
                  Container(
                    height: 300,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
          // 导航栏
          Container(
            color: Colors.red.withOpacity(0.3),
            height: AppBar().preferredSize.height +
                MediaQuery.of(context).padding.top,
          ),
        ],
      ),
    );
  }
}

class StickyBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double barHeight;

  StickyBarDelegate({@required this.child, this.barHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => barHeight;

  @override
  double get minExtent => barHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
