import 'package:flutter/material.dart';
import 'package:hksy_flutter/function/generaldialog.dart';
import 'package:hksy_flutter/public/public.dart';

class OrderConfirm extends StatefulWidget {
  Map product = {};
  kObjectFunctionBlock confirmHandle;
  OrderConfirm({Key key, this.confirmHandle, this.product}) : super(key: key);

  @override
  _OrderConfirmState createState() => _OrderConfirmState();

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
}

class _OrderConfirmState extends State<OrderConfirm> {
  List<String> _itemList = [
    "商品",
    "售卖价格",
    "当前余额",
  ];

  String _coin = "";
  String _price = "";
  bool _balanceOut = false;

  void _refreshAccount() {
    fetchUser((obj) {
      Map info = Map.from(obj);
      setState(() {
        _price = "${this.widget.product["productPreferentialPrice"]}";
        _coin = "${info["coin"]}";

        double _tempPrice = double.parse(_price);
        double _tempCoin = double.parse(_coin);

        if (_tempPrice - _tempCoin > 0) {
          _balanceOut = true;
        }
      });
    });
  }

  @override
  void didUpdateWidget(OrderConfirm oldWidget) {
    super.didUpdateWidget(oldWidget);

    this._refreshAccount();
  }

  @override
  void initState() {
    super.initState();
    this._refreshAccount();
  }

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
                          this.widget.product == null ||
                                  this.widget.product.length == 0
                              ? ""
                              : index == 0
                                  ? "${this.widget.product["productName"]}"
                                  : index == 1
                                      ? _price
                                      : index == 2 ? _coin : "",
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
          _balanceOut == true
              ? Container(
                  padding: EdgeInsets.fromLTRB(
                      0,
                      MediaQuery.of(context).orientation ==
                              Orientation.landscape
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
                )
              : Container(),
          _balanceOut == true
              ? SizedBox(
                  height: MediaQuery.of(context).orientation ==
                          Orientation.landscape
                      ? MediaQuery.of(context).padding.top
                      : 89,
                )
              : SizedBox(
                  height: 0,
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
                          if (this.widget.confirmHandle != null) {
                            this.widget.confirmHandle(_balanceOut);
                          }
                        });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.5),
                      ),
                      child: Text(
                        _balanceOut ? "去充值" : "购买",
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
