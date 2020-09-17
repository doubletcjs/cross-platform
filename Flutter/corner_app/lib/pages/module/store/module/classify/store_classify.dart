import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

class StoreClassifyPage extends StatefulWidget {
  StoreClassifyPage({Key key}) : super(key: key);

  @override
  _StoreClassifyPageState createState() => _StoreClassifyPageState();
}

class _StoreClassifyPageState extends State<StoreClassifyPage> {
  double _classifyWidth = 0;
  int _classifyIndex = 0;
  List<String> _classifyList = [
    "推荐",
    "热门",
    "陶器",
    "大理石",
    "其他",
  ];

  @override
  Widget build(BuildContext context) {
    if (_classifyWidth == 0) {
      _classifyWidth = (MediaQuery.of(context).size.width - 125 - 32) / 2;
    }

    return Scaffold(
      backgroundColor: rgba(247, 246, 245, 1),
      appBar: customAppBar(
        title: "分类",
        defaultBack: true,
      ),
      body: Row(
        children: [
          Container(
            width: 125,
            height: MediaQuery.of(context).size.height,
            color: rgba(255, 255, 255, 1),
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Container(
                  height: 48,
                  color: _classifyIndex == index
                      ? rgba(247, 246, 245, 1)
                      : rgba(255, 255, 255, 1),
                  child: Stack(
                    children: [
                      FlatButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          setState(() {
                            _classifyIndex = index;
                          });
                        },
                        child: Center(
                          child: Text(
                            "${_classifyList[index]}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: _classifyIndex == index
                                  ? rgba(235, 102, 91, 1)
                                  : rgba(50, 50, 50, 1),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16,
                        top: 0,
                        bottom: 0,
                        child: Center(
                          child: Container(
                            height: 16,
                            width: 3,
                            decoration: BoxDecoration(
                              color: _classifyIndex == index
                                  ? rgba(235, 102, 91, 1)
                                  : rgba(255, 255, 255, 1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              itemCount: _classifyList.length,
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.only(
                left: 8,
                top: 12,
                right: 16,
                bottom: MediaQuery.of(context).padding.bottom,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                childAspectRatio: 1 / 1.35,
              ),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    networkImage(
                      "https://avatars1.githubusercontent.com/u/17046133?v=4",
                      Size(_classifyWidth, _classifyWidth),
                      BorderRadius.circular(8),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "仪式蜡烛",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        color: rgba(50, 50, 50, 1),
                      ),
                    ),
                  ],
                );
              },
              itemCount: 5,
            ),
          ),
        ],
      ),
    );
  }
}
