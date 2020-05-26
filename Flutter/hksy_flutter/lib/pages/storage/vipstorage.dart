import 'package:flutter/material.dart';
import 'package:hksy_flutter/pages/invitation/views/invitesectioncell.dart';
import 'package:hksy_flutter/pages/storage/views/storageheader.dart';
import 'package:hksy_flutter/public/public.dart';

class VipStoragePage extends StatefulWidget {
  VipStoragePage({Key key}) : super(key: key);

  @override
  _VipStoragePageState createState() => _VipStoragePageState();
}

class _VipStoragePageState extends State<VipStoragePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      appBar: customAppBar(
        title: "超级存储",
        brightness: Brightness.dark,
        backgroundColor: kMainBackgroundColor,
        color: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(12, 20, 12, 0),
        child: Column(
          children: <Widget>[
            StorageHeader(
              isViper: true,
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.fromLTRB(
                  0,
                  35,
                  0,
                  MediaQuery.of(context).padding.bottom,
                ),
                itemBuilder: (context, index) {
                  return InvitationSection(
                    title: "分红明细",
                    emptyPlaceholder: "暂无分红信息～",
                    cells: <Widget>[
                      InvitationCell(
                        detail: {},
                        showLine: false,
                      ),
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
