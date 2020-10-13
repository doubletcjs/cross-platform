import 'package:flutter/material.dart';
import 'package:time_flies/pages/home/views/home_page_header.dart';
import 'package:time_flies/public/public.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey _headerGlobalKey = GlobalKey();
  Widget _header;
  double _headerHeight = 0;

  @override
  void initState() {
    super.initState();

    _header = HomePageHeader(globalKey: _headerGlobalKey);
    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        _headerHeight = _headerGlobalKey.currentContext.size.height;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _headerHeight == 0
          ? _header
          : NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    expandedHeight: _headerHeight,
                    pinned: true,
                    elevation: 0,
                    backgroundColor: Colors.white,
                    iconTheme: IconThemeData(color: Colors.black),
                    leading: BackButton(),
                    brightness: Theme.of(context).brightness,
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.pin,
                      background: _header,
                    ),
                  ),
                ];
              },
              body: Container(),
            ),
    );
  }
}
