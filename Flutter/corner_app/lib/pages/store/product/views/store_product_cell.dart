import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

class StoreProductCell extends StatefulWidget {
  Map product;
  StoreProductCell({
    Key key,
    this.product,
  }) : super(key: key);

  @override
  _StoreProductCellState createState() => _StoreProductCellState();
}

class _StoreProductCellState extends State<StoreProductCell> {
  double _itemWH = 0.0;

  @override
  Widget build(BuildContext context) {
    if (_itemWH == 0) {
      setState(() {
        _itemWH = (MediaQuery.of(context).size.width - 16 * 2 - 8) / 2;
      });
    }

    return this.widget.product == null
        ? Container()
        : Container(
            decoration: BoxDecoration(
              color: rgba(255, 255, 255, 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                networkImage(
                  "",
                  Size(_itemWH, _itemWH),
                  BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(7.5, 12, 7.5, 4),
                  child: Text(
                    this.widget.product["name"],
                    style: TextStyle(
                      fontSize: 14,
                      color: rgba(50, 50, 50, 1),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(7.5, 0, 7.5, 10.5),
                  child: Row(
                    children: [
                      Text(
                        "￥",
                        style: TextStyle(
                          fontSize: 10,
                          color: rgba(235, 102, 91, 1),
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        "${this.widget.product["price"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: rgba(235, 102, 91, 1),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
