import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StoreDetailStack extends StatelessWidget {
  List dataList = [];
  StoreDetailStack({
    Key key,
    this.dataList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth:
            (180 * MediaQuery.of(context).size.width) / 500, // 750/180 = w/x
      ),
      height: 28,
      child: ListView(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        reverse: true,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 14.0 * (dataList.length + 1),
                child: Stack(
                  children: dataList.map((e) {
                    var index = dataList.indexOf(e);
                    return Positioned(
                      left: index * 14.0,
                      child: networkImage(
                        "https://cdn2.jianshu.io/assets/default_avatar/14-0651acff782e7a18653d7530d6b27661.jpg",
                        Size(28, 28),
                        BorderRadius.circular(28 / 2),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
