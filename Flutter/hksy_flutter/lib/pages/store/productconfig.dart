import 'package:flutter/material.dart';

class ProductConfig extends StatelessWidget {
  const ProductConfig({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[Image.asset(name)],
    );
  }
}
