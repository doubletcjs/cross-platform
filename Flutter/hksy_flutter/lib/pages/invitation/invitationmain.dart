import 'package:flutter/material.dart';
import 'package:hksy_flutter/pages/invitation/earningspage.dart';
import 'package:hksy_flutter/pages/invitation/friendpage.dart';
import 'package:hksy_flutter/pages/invitation/invitationpage.dart';
import 'package:hksy_flutter/public/public.dart';

class InvitationMain extends StatefulWidget {
  InvitationMain({Key key}) : super(key: key);

  @override
  _InvitationMainState createState() => _InvitationMainState();
}

class _InvitationMainState extends State<InvitationMain>
    with TickerProviderStateMixin {
  TabController _tabController;
  List<String> _tabs = [
    "邀请收益",
    "好友列表",
    "邀请好友",
  ];

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      appBar: customAppBar(
        title: "邀请收益",
        brightness: Brightness.dark,
        backgroundColor: kMainBackgroundColor,
        color: Colors.white,
      ),
      body: Column(
        children: <Widget>[
          TabBar(
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: rgba(23, 96, 255, 1),
            indicatorWeight: 1.5,
            labelColor: rgba(23, 96, 255, 1),
            unselectedLabelColor: rgba(255, 255, 255, 1),
            labelStyle: TextStyle(
              fontSize: 15,
              color: rgba(23, 96, 255, 1),
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 15,
              color: rgba(255, 255, 255, 1),
            ),
            tabs: _tabs.map(
              (tab) {
                return Tab(
                  text: tab,
                );
              },
            ).toList(),
            onTap: (index) {
              setState(() {
                _tabController.index = index;
              });
            },
          ),
          Expanded(
            child: IndexedStack(
              children: <Widget>[
                EarningsPage(),
                FriendPage(),
                InvitationPage(),
              ],
              index: _tabController.index,
            ),
          ),
        ],
      ),
    );
  }
}
