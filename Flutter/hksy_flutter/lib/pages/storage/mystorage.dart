import 'package:flutter/material.dart';
import 'package:hksy_flutter/pages/invitation/views/invitesectioncell.dart';
import 'package:hksy_flutter/pages/storage/views/storageheader.dart';
import 'package:hksy_flutter/public/public.dart';

class MyStoragePage extends StatefulWidget {
  MyStoragePage({Key key}) : super(key: key);

  @override
  _MyStoragePageState createState() => _MyStoragePageState();
}

class _MyStoragePageState extends State<MyStoragePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      appBar: customAppBar(
        title: "我的存储",
        brightness: Brightness.dark,
        backgroundColor: kMainBackgroundColor,
        color: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(12, 20, 12, 0),
        child: Column(
          children: <Widget>[
            StorageHeader(),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.fromLTRB(
                    0, 35, 0, MediaQuery.of(context).padding.bottom),
                itemBuilder: (context, index) {
                  return InvitationSection(
                    title: "直排业绩",
                    emptyPlaceholder: "暂无业绩信息～",
                    cells: <Widget>[
                      // InvitationCell(),
                      // InvitationCell(),
                      // InvitationCell(),
                      // InvitationCell(),
                      // InvitationCell(),
                      // InvitationCell(
                      //   showLine: false,
                      // ),
                    ],
                  );
                },
                itemCount: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
