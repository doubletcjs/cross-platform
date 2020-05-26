import 'package:flutter/material.dart';
import 'package:hksy_flutter/public/public.dart';

class ProductService extends StatelessWidget {
  const ProductService({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
          child: Row(
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
                "包装售后",
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
        ),
        Image.asset(
          "images/1585120161108.jpg",
          fit: BoxFit.fitWidth,
        ),
      ],
    );
  }
}
