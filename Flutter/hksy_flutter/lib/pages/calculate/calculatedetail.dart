import 'package:flutter/material.dart';
import 'package:hksy_flutter/public/public.dart';

class CalculateDetail extends StatefulWidget {
  CalculateDetail({Key key}) : super(key: key);

  @override
  _CalculateDetailState createState() => _CalculateDetailState();
}

class _CalculateDetailState extends State<CalculateDetail>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<String> _tabs = [
    "全部",
    "兑换",
    "互转",
  ];

  List _dataList = [
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      appBar: customAppBar(
        title: "HKC兑转明细",
        brightness: Brightness.dark,
        backgroundColor: kMainBackgroundColor,
        color: Colors.white,
      ),
      body: Column(
        children: <Widget>[
          TabBar(
            tabs: _tabs.map((e) {
              return Tab(
                text: e,
              );
            }).toList(),
            controller: _tabController,
            labelColor: rgba(23, 96, 255, 1),
            labelStyle: TextStyle(
              color: rgba(23, 96, 255, 1),
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelColor: rgba(255, 255, 255, 1),
            unselectedLabelStyle: TextStyle(
              color: rgba(255, 255, 255, 1),
              fontSize: 15,
              fontWeight: FontWeight.normal,
            ),
            indicatorWeight: 1.5,
            indicatorColor: rgba(23, 96, 255, 1),
            indicatorSize: TabBarIndicatorSize.label,
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.fromLTRB(
                  12, 20, 12, MediaQuery.of(context).padding.bottom),
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  height: 84.5,
                  decoration: BoxDecoration(
                    color: rgba(28, 35, 63, 1),
                    borderRadius: index == 0
                        ? BorderRadius.only(
                            topLeft: Radius.circular(7.5),
                            topRight: Radius.circular(7.5),
                          )
                        : index == _dataList.length - 1
                            ? BorderRadius.only(
                                bottomLeft: Radius.circular(7.5),
                                bottomRight: Radius.circular(7.5),
                              )
                            : BorderRadius.zero,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "+10000HKC",
                              style: TextStyle(
                                color: rgba(255, 255, 255, 1),
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  "2020-10-11",
                                  style: TextStyle(
                                    color: rgba(145, 152, 173, 1),
                                    fontSize: 11,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "17:48",
                                  style: TextStyle(
                                    color: rgba(145, 152, 173, 1),
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Text(
                        "转入",
                        style: TextStyle(
                          color: rgba(255, 255, 255, 1),
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        width: 14,
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Row(
                  children: <Widget>[
                    Container(
                      width: 20,
                      height: 0.5,
                      color: rgba(28, 35, 63, 1),
                    ),
                    Expanded(
                      child: Container(
                        height: 0.5,
                        color: rgba(255, 255, 255, 0.2),
                      ),
                    ),
                    Container(
                      width: 20,
                      height: 0.5,
                      color: rgba(28, 35, 63, 1),
                    ),
                  ],
                );
              },
              itemCount: _dataList.length,
            ),
          ),
        ],
      ),
    );
  }
}
