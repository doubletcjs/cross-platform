import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StoreDiscussPage extends StatefulWidget {
  int tab = 0;
  StoreDiscussPage({
    Key key,
    this.tab = 0,
  }) : super(key: key);

  @override
  _StoreDiscussPageState createState() => _StoreDiscussPageState();
}

class _StoreDiscussPageState extends State<StoreDiscussPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container();
  }
}
