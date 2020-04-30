import 'package:flutter/material.dart';
import 'package:repayment_flutter/pages/bill/billdetail.dart';
import 'package:repayment_flutter/public/public.dart';

class HomeBillCell extends StatefulWidget {
  kObjectFunctionBlock onClose;
  HomeBillCell({Key key, this.onClose}) : super(key: key);

  @override
  _HomeBillCellState createState() => _HomeBillCellState();
}

class _HomeBillCellState extends State<HomeBillCell> {
  void _billDetail() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return BillDetailPage();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buttonWidget(
      Container(
        padding: EdgeInsets.fromLTRB(17, 12, 17, 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                  child: Image.asset(
                    "images/icon_loan_customise.png",
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "招商银行",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      "04月21日 第4/6期",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      "本期已还",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Image.asset(
                      "images/icon_forward_small.png",
                      fit: BoxFit.fitWidth,
                      width: 5,
                    ),
                  ],
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  "532.22",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                    fontFamily: "Oswald",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      context,
      onTap: () {
        if (this.widget.onClose != null) {
          this._billDetail();
          Future.delayed(Duration(milliseconds: 100), () {
            this.widget.onClose(context);
          });
        } else {
          this._billDetail();
        }
      },
      color: Colors.white,
    );
  }
}
