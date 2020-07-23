import 'package:flutter/material.dart';
import '../../../function/generaldialog.dart';
import '../../../../public/public.dart';

class ReportAlert extends StatelessWidget {
  ReportAlert({Key key}) : super(key: key);

  show(BuildContext context) {
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

  List<String> _reportItems = [
    "举报",
    "拉黑",
    "取消",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          10, 0, 10, 18.5 + MediaQuery.of(context).padding.bottom),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: _reportItems.map((item) {
          int index = _reportItems.indexOf(item);
          return Container(
            height: 49,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              border: index == _reportItems.length - 1
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
                if (item == "取消") {
                  Navigator.of(context).pop();
                }
              },
              child: Text(
                "$item",
                style: TextStyle(
                  color: rgba(51, 51, 51, 1),
                  fontSize: 18,
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
