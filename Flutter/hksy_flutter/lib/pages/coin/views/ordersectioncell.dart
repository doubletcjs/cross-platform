import 'package:flutter/material.dart';
import 'package:hksy_flutter/public/public.dart';

class OrderSection extends StatelessWidget {
  List<Widget> cells = [];
  String emptyPlaceholder = "";
  OrderSection({Key key, this.cells, this.emptyPlaceholder = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      decoration: BoxDecoration(
        color: rgba(28, 35, 63, 1),
        borderRadius: BorderRadius.circular(7.5),
      ),
      child: cells.length > 0
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
                            "+10000.00",
                            style: TextStyle(
                              fontSize: 15,
                              color: rgba(255, 255, 255, 1),
                            ),
                          ),
                          SizedBox(
                            height: 8.5,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "2020-10-11",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: rgba(145, 152, 173, 1),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "17:48",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: rgba(145, 152, 173, 1),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        "已充值",
                        style: TextStyle(
                          fontSize: 15,
                          color: rgba(255, 255, 255, 1), //rgba(255, 52, 101, 1)
                        ),
                      ),
                    ],
                  ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 31.5),
            child: Text(
              "*钱款未到对公账户",
              style: TextStyle(
                fontSize: 11,
                color: rgba(255, 52, 101, 1),
              ),
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
