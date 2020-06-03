import 'package:flutter/material.dart';
import 'package:hksy_flutter/function/generaldialog.dart';
import 'package:hksy_flutter/public/public.dart';

class OrderConfirm extends StatelessWidget {
  kObjectFunctionBlock confirmHandle;
  OrderConfirm({Key key, this.confirmHandle}) : super(key: key);

  show(BuildContext context) {
    GeneralDialog().show(
      context,
      containerContent: this,
      backgroundAlignment: Alignment.bottomCenter,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
    );
  }

  List<String> _itemList = [
    "商品",
    "售卖价格",
    "当前余额",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 16.5,
          ),
          Text(
            "确认订单",
            style: TextStyle(
              fontSize: 18,
              color: rgba(51, 51, 51, 1),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 19.5,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
            child: Column(
              children: _itemList.map(
                (item) {
                  var index = _itemList.indexOf(item);
                  return Container(
                    height: 61,
                    decoration: BoxDecoration(
                      border: index < _itemList.length - 1
                          ? Border(
                              bottom: BorderSide(
                                color: rgba(145, 152, 173, 1),
                                width: 0.5,
                              ),
                            )
                          : Border(),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          item,
                          style: TextStyle(
                            fontSize: 15,
                            color: rgba(51, 51, 51, 1),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Text(
                          item,
                          style: TextStyle(
                            fontSize: 15,
                            color: rgba(51, 51, 51, 1),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ).toList(),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(
                0,
                MediaQuery.of(context).orientation == Orientation.landscape
                    ? 0
                    : 5,
                12,
                0),
            alignment: Alignment.centerRight,
            child: Text(
              "余额不足",
              style: TextStyle(
                fontSize: 14,
                color: rgba(248, 168, 65, 1),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).orientation == Orientation.landscape
                ? MediaQuery.of(context).padding.top
                : 89,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(21, 0, 21, 0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 49,
                    decoration: BoxDecoration(
                      color: rgba(235, 237, 240, 1),
                      borderRadius: BorderRadius.circular(7.5),
                    ),
                    child: FlatButton(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.5),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "取消",
                        style: TextStyle(
                          fontSize: 15,
                          color: rgba(145, 152, 173, 1),
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
                        Navigator.of(context).pop();
                        Future.delayed(Duration(milliseconds: 600), () {
                          if (confirmHandle != null) {
                            confirmHandle(false);
                          }
                          // if (confirmHandle != null) {
                          //   confirmHandle(true);
                          // }
                        });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.5),
                      ),
                      child: Text(
                        "购买",
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
          ),
          SizedBox(
            height: 34.5,
          ),
        ],
      ),
    );
  }
}
