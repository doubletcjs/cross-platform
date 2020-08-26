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

  // 头部内容
  Widget _flexibleHeader() {
    return Container(
      color: Colors.yellow,
      child: Column(
        children: [
          StoreHeader(),
          StoreLive(),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
    _tabController = TabController(vsync: this, length: 3);
    _scrollViewController.addListener(() {});
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
      body: NestedScrollView(
        controller: _scrollViewController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              pinned: true,
              floating: true,
              primary: false,
              expandedHeight: -600,
              elevation: 0,
              automaticallyImplyLeading: false,
              titleSpacing: 0,
              brightness: Brightness.light,
              //头部
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.none,
                background: StoreHeader(),
              ),
              bottom: PreferredSize(
                child: Container(
                  height: 600,
                  color: Colors.red,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
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
                preferredSize: Size.fromHeight(600),
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
