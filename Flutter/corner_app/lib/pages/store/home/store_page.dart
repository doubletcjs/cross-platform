import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

class StorePage extends StatefulWidget {
  StorePage({Key key}) : super(key: key);

  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    this.tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            elevation: 0,
            expandedHeight: 250,
            automaticallyImplyLeading: false,
            titleSpacing: 0,
            backgroundColor: new Color.fromRGBO(0, 0, 0, 0.0),
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.none,
              // title: Text('Sliver-sticky效果'),
              title: Container(
                color: rgba(0, 0, 0, 0.4),
                height: 250,
              ),
              titlePadding: EdgeInsets.zero,
              background: Stack(
                children: [
                  Container(
                    child: Image.asset(
                      "images/homepages_default_bg.png",
                      fit: BoxFit.fitWidth,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: StickyTabBarDelegate(
              child: TabBar(
                labelColor: Colors.black,
                controller: this.tabController,
                tabs: <Widget>[
                  Tab(text: 'Home'),
                  Tab(text: 'Profile'),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: this.tabController,
              children: <Widget>[
                Center(child: Text('Content of Home')),
                Center(child: Text('Content of Profile')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;

  StickyTabBarDelegate({@required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return this.child;
  }

  @override
  double get maxExtent => this.child.preferredSize.height;

  @override
  double get minExtent => this.child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
