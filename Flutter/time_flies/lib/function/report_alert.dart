import 'package:flutter/material.dart';
import 'package:time_flies/function/general_dialog.dart';
import 'package:time_flies/public/public.dart';

typedef _kReportAlertItemBlock = void Function(String item);

// ignore: must_be_immutable
class ReportAlert extends StatelessWidget {
  _kReportAlertItemBlock itemHandle;
  List<String> reportItems;
  ReportAlert({
    Key key,
    this.itemHandle,
    this.reportItems,
  }) : super(key: key);

  show(BuildContext context) {
    if (reportItems == null) {
      reportItems = [
        "举报",
        "拉黑",
        "取消",
      ];
    }

    GeneralDialog().show(
      context,
      backgroundPadding: EdgeInsets.zero,
      backgroundAlignment: Alignment.bottomCenter,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      containerContent: this,
      barrierDismissible: true,
      backgroundColor: rgba(1, 1, 1, 0.5),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          0, 0, 0, 18.5 + MediaQuery.of(context).padding.bottom),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: reportItems.map((item) {
          int index = reportItems.indexOf(item);
          return Container(
            height: 49,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              border: index == reportItems.length - 1
                  ? Border()
                  : Border(
                      bottom: BorderSide(
                        width: 0.5,
                        color: rgba(237, 237, 237, 1),
                      ),
                    ),
            ),
            child: FlatButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.of(context).pop();
                if (itemHandle != null) {
                  itemHandle(item);
                }
              },
              child: Text(
                "$item",
                style: TextStyle(
                  color: rgba(51, 51, 51, 1),
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: index == 0
                    ? BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      )
                    : BorderRadius.zero,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
