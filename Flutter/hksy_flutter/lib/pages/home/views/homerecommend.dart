import 'package:flutter/material.dart';
import 'package:hksy_flutter/public/public.dart';

class HomeRecommend extends StatefulWidget {
  HomeRecommend({Key key}) : super(key: key);

  @override
  _HomeRecommendState createState() => _HomeRecommendState();
}

class _HomeRecommendState extends State<HomeRecommend> {
  List _dataList = [
    "",
    "",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(12, 0, 12, 46.5),
      child: Column(
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
            children: _dataList.map((product) {
              return Container(
                width: (MediaQuery.of(context).size.width - 24 - 11) / 2,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 210,
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
                    )
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
