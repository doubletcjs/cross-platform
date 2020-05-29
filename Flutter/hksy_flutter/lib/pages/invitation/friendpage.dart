import 'package:flutter/material.dart';
import 'package:hksy_flutter/pages/invitation/views/friendsectioncell.dart';

class FriendPage extends StatefulWidget {
  FriendPage({Key key}) : super(key: key);

  @override
  _FriendPageState createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.fromLTRB(
        12,
        20,
        12,
        MediaQuery.of(context).padding.bottom,
      ),
      itemBuilder: (context, index) {
        return FriendSection(
          title: "邀请好友明细",
          emptyPlaceholder: "暂无好友信息～",
          cells: <Widget>[
            FriendCell(
              detail: {},
            ),
            FriendCell(
              detail: {},
            ),
            FriendCell(
              detail: {},
            ),
            FriendCell(
              detail: {},
              showLine: false,
            ),
          ],
        );
      },
      itemCount: 1,
    );
  }
}
