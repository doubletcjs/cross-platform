import 'package:flutter/material.dart';
import 'package:time_flies/public/public.dart';

class AccountListPage extends StatefulWidget {
  AccountListPage({Key key}) : super(key: key);

  @override
  _AccountListPageState createState() => _AccountListPageState();
}

class _AccountListPageState extends State<AccountListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "我的关注",
        defaultBack: true,
      ),
    );
  }
}
