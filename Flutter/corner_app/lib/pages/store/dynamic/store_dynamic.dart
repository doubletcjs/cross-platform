import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StoreDynamicPage extends StatefulWidget {
  int tab = 0;
  StoreDynamicPage({
    Key key,
    this.tab = 0,
  }) : super(key: key);

  @override
  _StoreDynamicPageState createState() => _StoreDynamicPageState();
}

class _StoreDynamicPageState extends State<StoreDynamicPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container();
  }
}
