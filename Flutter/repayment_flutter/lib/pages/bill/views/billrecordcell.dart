import 'package:flutter/material.dart';
import 'package:repayment_flutter/pages/bill/billdetail.dart';
import 'package:repayment_flutter/public/public.dart';

class BillRecordCell extends StatelessWidget {
  Map bill;
  kObjectFunctionBlock onClose;
  BillRecordCell({Key key, this.onClose, this.bill}) : super(key: key);

  void _billDetail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return BillDetailPage(
            bill: bill,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buttonWidget(
      Container(
        height: 65,
        padding: EdgeInsets.fromLTRB(15, 0, 7, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  ClipRRect(
                    child: Image.asset(
                      "${bill["icon"]}",
                      width: 22,
                      height: 22,
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.circular(22 / 2),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "${bill["name"]}",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        "${bill["firstdate"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Text(
                  "${double.parse('${bill["eachamount"]}').toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontFamily: "Oswald",
                  ),
                ),
                SizedBox(
                  width: 6,
                ),
                Image.asset(
                  "images/icon_forward_small.png",
                  fit: BoxFit.fitWidth,
                  width: 6,
                ),
              ],
            ),
          ],
        ),
      ),
      context,
      color: Colors.white,
      onTap: () {
        if (this.onClose != null) {
          this._billDetail(context);
          Future.delayed(Duration(milliseconds: 100), () {
            this.onClose(context);
          });
        } else {
          this._billDetail(context);
        }
      },
    );
  }
}
