import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:hksy_flutter/pages/coin/orderdetail.dart';
import 'package:hksy_flutter/public/public.dart';

class CoinSection extends StatelessWidget {
  List<Widget> cells = [];
  String title = "";
  String emptyPlaceholder = "";
  CoinSection(
      {Key key, this.cells, this.title = "", this.emptyPlaceholder = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 35, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  color: rgba(255, 255, 255, 1),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return OrderDetail();
                      },
                    ),
                  );
                },
                child: Row(
                  children: <Widget>[
                    Text(
                      "更多",
                      style: TextStyle(
                        fontSize: 13,
                        color: rgba(145, 152, 173, 1),
                      ),
                    ),
                    SizedBox(
                      width: 7.5,
                    ),
                    Image.asset(
                      "images/right_arrow@3x.png",
                      width: 14,
                      fit: BoxFit.fitWidth,
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          cells.length > 0
              ? Column(
                  children: cells,
                )
              : Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(0, 40, 0, 90),
                  child: Text(
                    emptyPlaceholder,
                    style: TextStyle(
                      fontSize: 15,
                      color: rgba(145, 152, 173, 1),
                    ),
                  ),
                ),
        ],
      ),
      decoration: BoxDecoration(
        color: rgba(28, 35, 63, 1),
        borderRadius: BorderRadius.circular(7.5),
      ),
    );
  }
}

class CoinCell extends StatelessWidget {
  bool showLine = true;
  Map detail;
  CoinCell({
    Key key,
    this.showLine = true,
    this.detail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 25, 0, 21.5),
      child: detail == null
          ? Container()
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  (detail["type"] == 47 ||
                          detail["type"] == 43 ||
                          detail["type"] == 38)
                      ? "images/ico_mygold_list_cell_recharge@3x.png"
                      : (detail["type"] == 33 ||
                              detail["type"] == 63 ||
                              detail["type"] == 62)
                          ? "images/ico_mygold_list_cell_cashout@3x.png"
                          : "images/ico_mygold_list_cell_transfer@3x.png",
                  width: 32,
                  fit: BoxFit.fitWidth,
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            (detail["type"] == 47 ||
                                    detail["type"] == 43 ||
                                    detail["type"] == 38 ||
                                    detail["type"] == 33 ||
                                    detail["type"] == 63 ||
                                    detail["type"] == 62)
                                ? TextUtil.hideNumber(detail["myaccont"])
                                : TextUtil.hideNumber(detail["otheraccont"]),
                            style: TextStyle(
                              fontSize: 15,
                              color: rgba(255, 255, 255, 1),
                            ),
                          ),
                          SizedBox(
                            height: 9,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                DateUtil.formatDate(
                                    DateUtil.getDateTime(detail["createTime"]),
                                    format: "yyyy-MM-dd"),
                                style: TextStyle(
                                  fontSize: 11,
                                  color: rgba(145, 152, 173, 1),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                DateUtil.formatDate(
                                    DateUtil.getDateTime(detail["createTime"]),
                                    format: "HH:mm"),
                                style: TextStyle(
                                  fontSize: 11,
                                  color: rgba(145, 152, 173, 1),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Text(
                        "${detail["inOrOut"] == 0 ? '-' : '+'}" +
                            "${double.parse('${detail["amount"]}').toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 15,
                          color: rgba(255, 255, 255, 1),
                        ),
                      ),
                    ],
                  ),
                ),
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
