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
    return ListView.builder(
      shrinkWrap: true,
      // primary: false,
      itemBuilder: (BuildContext c, int i) {
        return Container(
          //decoration: BoxDecoration(border: Border.all(color: Colors.orange,width: 1.0)),
          alignment: Alignment.center,
          height: 60.0,
          width: double.infinity,
          //color: Colors.blue,
          child: Text("讨论区" + ': List$i'),
          decoration: BoxDecoration(
              border: Border(
            bottom: BorderSide(
              width: 1,
              color: Colors.red,
            ),
          )),
        );
      },
      itemCount: 30,
      padding: EdgeInsets.zero,
    );
  }
}
