import 'package:flutter/material.dart';
import 'package:hksy_flutter/public/public.dart';

class ProductInfo extends StatelessWidget {
  Map product = {};
  ProductInfo({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return product == null && product.length == 0
        ? Container()
        : ListView(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
            children: <Widget>[
              Image.asset(
                "images/product_thumbnail@3x.png",
                fit: BoxFit.fitWidth,
              ),
              Container(
                color: rgba(21, 25, 54, 1),
                padding: EdgeInsets.fromLTRB(12, 20, 12, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "${product["productName"]}",
                      style: TextStyle(
                        fontSize: 23,
                        color: rgba(255, 255, 255, 1),
                      ),
                    ),
                    SizedBox(
                      height: 8.5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "${product["productPreferentialPrice"]}/个",
                          style: TextStyle(
                            fontSize: 20,
                            color: rgba(23, 96, 255, 1),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${product["productUnitPrice"]}/个",
                          style: TextStyle(
                            fontSize: 13,
                            color: rgba(145, 152, 173, 1),
                            decoration: TextDecoration.lineThrough,
                            decorationColor: rgba(145, 152, 173, 1),
                            decorationThickness: 1,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50.2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 74.5,
                          height: 0.5,
                          color: rgba(145, 152, 173, 1),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          "基本信息",
                          style: TextStyle(
                            fontSize: 23,
                            color: rgba(255, 255, 255, 1),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Container(
                          width: 74.5,
                          height: 0.5,
                          color: rgba(145, 152, 173, 1),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Image.asset(
                "images/1585120152035.jpg",
                fit: BoxFit.fitWidth,
              ),
            ],
          );
  }
}
