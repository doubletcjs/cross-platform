import 'package:corner_app/pages/function/scale_tabbar.dart';
import 'package:corner_app/pages/store/home/store_discuss.dart';
import 'package:corner_app/pages/store/home/store_dynamic.dart';
import 'package:corner_app/pages/store/home/store_product.dart';
import 'package:corner_app/pages/store/home/views/store_banner.dart';
import 'package:corner_app/pages/store/home/views/store_header.dart';
import 'package:corner_app/pages/store/home/views/store_live.dart';
import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

class StorePage extends StatefulWidget {
  StorePage({Key key}) : super(key: key);

  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          transparentAppBar(
            brightness: Brightness.light,
          ),
          StoreHeader(),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 217 + MediaQuery.of(context).padding.top - 19.5,
            child: ListView(
              primary: false,
              padding: EdgeInsets.only(
                top: 0,
              ),
              children: [
                Container(
                  height: 44,
                  color: Colors.red,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
