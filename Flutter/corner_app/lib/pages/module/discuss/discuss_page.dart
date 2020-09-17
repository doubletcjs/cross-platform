import 'package:corner_app/pages/module/discuss/views/discuss_cell.dart';
import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DiscussPage extends StatefulWidget {
  int tab = 0;
  DiscussPage({
    Key key,
    this.tab = 0,
  }) : super(key: key);

  @override
  _DiscussPageState createState() => _DiscussPageState();
}

class _DiscussPageState extends State<DiscussPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: rgba(247, 246, 245, 1),
      child: ListView.builder(
        shrinkWrap: true,
        // primary: false,
        itemBuilder: (context, index) {
          return DiscussCell(
            showBorder: index == 0,
            hideLine: index == 29,
          );
        },
        itemCount: 30,
        padding: EdgeInsets.fromLTRB(0, 0, 0, 60),
      ),
    );
  }
}
