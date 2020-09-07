import 'package:corner_app/pages/function/general_dialog.dart';
import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

class GeneralComplaint extends StatelessWidget {
  GeneralComplaint({Key key}) : super(key: key);
  List<String> _complaintList = [
    "敏感时政",
    "垃圾广告",
    "人身攻击",
    "内容抄袭",
  ];

  show(BuildContext context) {
    GeneralDialog().show(
      context,
      backgroundPadding: EdgeInsets.zero,
      backgroundAlignment: Alignment.bottomCenter,
      containerContent: this,
      barrierDismissible: true,
      backgroundColor: Color.fromRGBO(0, 0, 0, 0.4),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 420,
      color: rgba(255, 255, 255, 1),
      padding: EdgeInsets.only(
        top: 32,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
            ),
            child: Text(
              "投诉",
              style: TextStyle(
                fontSize: 20,
                color: rgba(50, 50, 50, 1),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
              ),
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 12,
                  children: _complaintList.map((complaint) {
                    return Container(
                      decoration: BoxDecoration(
                        color: rgba(247, 246, 245, 1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      width:
                          (MediaQuery.of(context).size.width - 16 * 2 - 8 * 2) /
                              3,
                      height: 28,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        onPressed: () {},
                        child: Text(
                          complaint,
                          style: TextStyle(
                            fontSize: 14,
                            color: rgba(50, 50, 50, 1),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 48 + MediaQuery.of(context).padding.bottom,
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom,
            ),
            child: FlatButton(
              color: rgba(247, 246, 245, 1),
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "取消",
                style: TextStyle(
                  fontSize: 18,
                  color: rgba(50, 50, 50, 1),
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
