import 'package:flutter/material.dart';
import 'package:hksy_flutter/public/public.dart';

class ProductCell extends StatefulWidget {
  Map product;
  double diffSpace = 24.0;
  double spacing = 11.0;
  ProductCell({
    Key key,
    this.diffSpace = 24.0,
    this.spacing = 11.0,
    this.product,
  }) : super(key: key);

  @override
  _ProductCellState createState() => _ProductCellState();
}

class _ProductCellState extends State<ProductCell> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width -
              this.widget.diffSpace -
              this.widget.spacing) /
          2,
      child: Column(
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Image.asset(
                  "images/main_product_thumbnail@3x.png",
                ),
                Positioned(
                  left: 16.5,
                  bottom: 31,
                  right: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "HK iCloud-2T",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15,
                          color: rgba(255, 255, 255, 1),
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        "- 为IPFS量身定制",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 7.5,
                          color: rgba(255, 255, 255, 1),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: rgba(27, 36, 62, 1),
              borderRadius: BorderRadius.circular(7.5),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "华科闪云存储器2T",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 15,
              color: rgba(255, 255, 255, 1),
            ),
          ),
          Text(
            "4360.0/个",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 15,
              color: rgba(23, 96, 255, 1),
            ),
          ),
        ],
      ),
    );
  }
}
