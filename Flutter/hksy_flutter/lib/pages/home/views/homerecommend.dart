import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/material.dart';
import 'package:hksy_flutter/pages/store/views/productcell.dart';
import 'package:hksy_flutter/public/public.dart';

class HomeRecommend extends StatefulWidget {
  HomeRecommend({Key key}) : super(key: key);

  @override
  _HomeRecommendState createState() => _HomeRecommendState();
}

class _HomeRecommendState extends State<HomeRecommend> {
  List _dataList = [];

  @override
  void initState() {
    super.initState();

    DartNotificationCenter.subscribe(
      channel: "kGetMyAssetsCommend",
      observer: this,
      onNotification: (options) {
        setState(() {
          List _list = options["pList"];
          setState(() {
            _dataList = _list.sublist(0, 2);
          });
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();

    DartNotificationCenter.unsubscribe(observer: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(12, 0, 12, 46.5),
      child: _dataList.length == 0
          ? Container()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "产品推荐",
                  style: TextStyle(
                    fontSize: 23,
                    color: rgba(255, 255, 255, 1),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Wrap(
                  spacing: 11,
                  runSpacing: 11,
                  children: _dataList.map(
                    (product) {
                      return ProductCell(
                        diffSpace: 12 * 2.0,
                        spacing: 11.0,
                        product: product,
                      );
                    },
                  ).toList(),
                ),
              ],
            ),
    );
  }
}
