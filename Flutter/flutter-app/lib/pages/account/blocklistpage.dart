import 'package:flutter/material.dart';
import '../../public/public.dart';
import 'views/accountbasecell.dart';

class BlockListPage extends StatefulWidget {
  BlockListPage({Key key}) : super(key: key);

  @override
  _BlockListPageState createState() => _BlockListPageState();
}

class _BlockListPageState extends State<BlockListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rgba(248, 248, 248, 1),
      appBar: customAppBar(
        title: "黑名单",
        elevation: 0.5,
      ),
      body: ListView.builder(
        itemBuilder: (context, inexe) {
          return AccountBaseCell();
        },
        itemCount: 10,
      ),
    );
  }
}
