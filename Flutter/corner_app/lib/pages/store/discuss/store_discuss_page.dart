import 'package:corner_app/pages/store/discuss/views/store_discuss_cell.dart';
import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StoreDiscussPage extends StatefulWidget {
  int tab = 2;
  StoreDiscussPage({
    Key key,
    this.tab = 2,
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
    return Container(
      color: rgba(247, 246, 245, 1),
      child: ListView.builder(
        shrinkWrap: true,
        // primary: false,
        itemBuilder: (context, index) {
          return StoreDiscussCell(
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
