import 'package:flutter/material.dart';
import 'package:hksy_flutter/function/emptypage.dart';
import 'package:hksy_flutter/public/public.dart';

class OrderSection extends StatelessWidget {
  List<Widget> cells = [];
  String emptyPlaceholder = "";
  OrderSection({Key key, this.cells, this.emptyPlaceholder = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return cells.length > 0
        ? Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            decoration: BoxDecoration(
              color: rgba(28, 35, 63, 1),
              borderRadius: BorderRadius.circular(7.5),
            ),
            child: Column(
              children: cells,
            ),
          )
        : BaseEmptyPage(
            title: emptyPlaceholder,
            topSpace: 100,
          );
  }
}

class OrderCell extends StatelessWidget {
  Map order;
  bool showLine = true;
  OrderCell({Key key, this.showLine = true, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(0, 25, 0, 21),
            child: order == null
                ? Container()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            order["type"] == 47
                                ? "+${order['price']}"
                                : order["type"] == 33
                                    ? "+${order['cashNumber']}"
                                    : order["type"] == 24
                                        ? order["inOrOut"] == 0
                                            ? "+"
                                            : "-" + "${order['amount']}"
                                        : "",
                            style: TextStyle(
                              fontSize: 15,
                              color: rgba(255, 255, 255, 1),
                            ),
                          ),
                          SizedBox(
                            height: 8.5,
                          ),
                          Text(
                            order["type"] == 24
                                ? "${order['createTime']}\n对方账户：${order['otheraccont']}"
                                : "${order['createTime']}",
                            style: TextStyle(
                              fontSize: 11,
                              color: rgba(145, 152, 173, 1),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        order["type"] == 47
                            ? (order["status"] == 1
                                ? "已充值"
                                : (order["status"] == 0 || order["status"] == 3)
                                    ? "审核中"
                                    : "审核失败")
                            : order["type"] == 33
                                ? (order["cashStatus"] == 1
                                    ? "已提现"
                                    : (order["cashStatus"] == 0 ||
                                            order["cashStatus"] == 3)
                                        ? "审核中"
                                        : "审核失败")
                                : order["type"] == 24
                                    ? (order["inOrOut"] == 0 ? "已转出" : "已转入")
                                    : "",
                        style: TextStyle(
                          fontSize: 15,
                          color: (order["type"] == 47 && order["status"] == 2)
                              ? rgba(255, 52, 101, 1)
                              : (order["type"] == 33 &&
                                      order["cashStatus"] == 2)
                                  ? rgba(255, 52, 101, 1)
                                  : rgba(
                                      255, 255, 255, 1), //rgba(255, 52, 101, 1)
                        ),
                      ),
                    ],
                  ),
          ),
          (order["type"] == 47 && order["status"] == 2)
              ? Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 31.5),
                  child: Text(
                    "${order["remark"]}",
                    style: TextStyle(
                      fontSize: 11,
                      color: rgba(255, 52, 101, 1),
                    ),
                  ),
                )
              : (order["type"] == 33 && order["cashStatus"] == 2)
                  ? Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 31.5),
                      child: Text(
                        "${order["verifyInfo"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: rgba(255, 52, 101, 1),
                        ),
                      ),
                    )
                  : Container(),
        ],
      ),
      decoration: BoxDecoration(
        border: showLine == true
            ? Border(
                bottom: BorderSide(
                  color: rgba(255, 255, 255, 0.2),
                  width: 1,
                ),
              )
            : Border(),
      ),
    );
  }
}
