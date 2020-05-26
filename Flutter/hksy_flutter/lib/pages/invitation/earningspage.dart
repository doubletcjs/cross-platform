import 'package:flutter/material.dart';
import 'package:hksy_flutter/pages/invitation/views/earningheader.dart';
import 'package:hksy_flutter/pages/invitation/views/invitesectioncell.dart';

class EarningsPage extends StatefulWidget {
  EarningsPage({Key key}) : super(key: key);

  @override
  _EarningsPageState createState() => _EarningsPageState();
}

class _EarningsPageState extends State<EarningsPage> {
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
        return index == 0
            ? Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 35),
                child: EarningHeader(),
              )
            : InvitationSection(
                title: "邀请收益明细",
                emptyPlaceholder: "暂无收益信息～",
                cells: <Widget>[
                  InvitationCell(
                    detail: {},
                  ),
                  InvitationCell(
                    detail: {},
                  ),
                  InvitationCell(
                    detail: {},
                  ),
                  InvitationCell(
                    detail: {},
                  ),
                  InvitationCell(
                    detail: {},
                  ),
                  InvitationCell(
                    detail: {},
                  ),
                  InvitationCell(
                    detail: {},
                  ),
                  InvitationCell(
                    detail: {},
                  ),
                  InvitationCell(
                    detail: {},
                  ),
                  InvitationCell(
                    detail: {},
                  ),
                  InvitationCell(
                    detail: {},
                  ),
                  InvitationCell(
                    detail: {},
                  ),
                  InvitationCell(
                    detail: {},
                  ),
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
      itemCount: 2,
    );
  }
}
