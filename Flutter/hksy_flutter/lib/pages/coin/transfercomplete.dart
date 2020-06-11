import 'package:flutter/material.dart';
import 'package:hksy_flutter/pages/coin/orderdetail.dart';
import 'package:hksy_flutter/public/public.dart';

class TransferComplete extends StatelessWidget {
  int completeType = 0; // 0 全部 1 充值 2 提现 3 金币互转 4 HKC互转 5 超级存储 6 HKC兑换
  TransferComplete({Key key, this.completeType = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      appBar: customAppBar(
        title: completeType == 4
            ? "互转成功"
            : completeType == 5 ? "转出成功" : completeType == 6 ? "兑换成功" : "申请已提交",
        brightness: Brightness.dark,
        backgroundColor: kMainBackgroundColor,
        color: Colors.white,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 43,
            ),
            Image.asset(
              "images/complete@3x.png",
              width: 119,
              fit: BoxFit.fitWidth,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              completeType == 4
                  ? "互转成功"
                  : completeType == 5
                      ? "转出成功"
                      : completeType == 6 ? "兑换成功" : "申请已提交",
              style: TextStyle(
                fontSize: 15,
                color: rgba(255, 255, 255, 1),
              ),
            ),
            SizedBox(
              height: 51.5,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(23, 0, 23, 0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 49,
                      decoration: BoxDecoration(
                        color: (completeType == 4 || completeType == 5)
                            ? rgba(28, 35, 63, 1)
                            : rgba(235, 237, 240, 1),
                        borderRadius: BorderRadius.circular(7.5),
                      ),
                      child: FlatButton(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.5),
                        ),
                        onPressed: () {
                          if (completeType == 4 ||
                              completeType == 5 ||
                              completeType == 6) {
                            Navigator.of(context)
                                .popUntil(ModalRoute.withName("/"));
                          } else {
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text(
                          (completeType == 4 ||
                                  completeType == 5 ||
                                  completeType == 6)
                              ? "首页"
                              : "返回",
                          style: TextStyle(
                            fontSize: 15,
                            color: completeType == 4
                                ? rgba(145, 152, 173, 1)
                                : rgba(145, 152, 173, 1),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12.5,
                  ),
                  Expanded(
                    child: Container(
                      height: 49,
                      decoration: BoxDecoration(
                        color: rgba(23, 96, 255, 1),
                        borderRadius: BorderRadius.circular(7.5),
                      ),
                      child: FlatButton(
                        onPressed: () {
                          if (completeType == 4 || completeType == 6) {
                            Navigator.of(context)
                                .popUntil(ModalRoute.withName("/calculate"));
                          } else if (completeType == 5) {
                            Navigator.of(context).pop();
                          } else {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return OrderDetail(
                                    selectIndex: completeType,
                                  );
                                },
                              ),
                            );
                          }
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.5),
                        ),
                        child: Text(
                          (completeType == 4 || completeType == 6)
                              ? "返回算力"
                              : completeType == 5 ? "返回" : "查看订单详细",
                          style: TextStyle(
                            fontSize: 15,
                            color: rgba(255, 255, 255, 1),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
