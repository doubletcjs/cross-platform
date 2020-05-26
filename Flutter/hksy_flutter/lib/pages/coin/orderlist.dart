import 'package:flutter/material.dart';
import 'package:hksy_flutter/pages/coin/views/ordersectioncell.dart';

class OrderList extends StatefulWidget {
  int type = 0;
  OrderList({Key key, this.type = 0}) : super(key: key);

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.fromLTRB(
        12,
        20,
        12,
        MediaQuery.of(context).padding.bottom,
      ),
      itemBuilder: (context, index) {
        return OrderSection(
          emptyPlaceholder: "暂无订单信息～",
          cells: <Widget>[
            OrderCell(
              order: {},
            ),
            OrderCell(
              order: {},
            ),
            OrderCell(
              order: {},
            ),
            OrderCell(
              order: {},
            ),
            OrderCell(
              order: {},
              showLine: false,
            ),
          ],
        );
      },
      itemCount: 1,
    );
  }
}
