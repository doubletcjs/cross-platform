import 'package:flutter/material.dart';
import 'package:time_flies/public/public.dart';

class MessageCenter extends StatefulWidget {
  MessageCenter({Key key}) : super(key: key);

  @override
  _MessageCenterState createState() => _MessageCenterState();
}

class _MessageCenterState extends State<MessageCenter>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        titleView: TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
          unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 17,
          ),
          indicator: BoxDecoration(),
          tabs: [
            Tab(
              text: "私信",
            ),
            Tab(
              text: "评论",
            ),
            Tab(
              text: "喜欢",
            ),
          ],
        ),
      ),
    );
  }
}
