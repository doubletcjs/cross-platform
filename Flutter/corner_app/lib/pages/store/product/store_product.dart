import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StoreProductPage extends StatefulWidget {
  int tab = 0;
  StoreProductPage({
    Key key,
    this.tab = 0,
  }) : super(key: key);

  @override
  _StoreProductPageState createState() => _StoreProductPageState();
}

class _StoreProductPageState extends State<StoreProductPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container();
  }
}
