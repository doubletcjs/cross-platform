import 'package:flutter/material.dart';
import 'nearlist.dart';
import '../../public/public.dart';

class NearPage extends StatefulWidget {
  NearPage({Key key}) : super(key: key);

  @override
  _NearPageState createState() => _NearPageState();
}

class _NearPageState extends State<NearPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      body: Stack(
        children: <Widget>[
          transparentAppBar(
            brightness: Brightness.light,
          ),
          NearTabView(),
        ],
      ),
    );
  }
}

class NearTabView extends StatefulWidget {
  NearTabView({Key key}) : super(key: key);

  @override
  _NearTabViewState createState() => _NearTabViewState();
}

class _NearTabViewState extends State<NearTabView>
    with SingleTickerProviderStateMixin {
  List<String> _tabs = [
    "附近",
    "在线",
    "新人",
    "认证",
    "推荐",
  ];
  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.fromLTRB(0, MediaQuery.of(context).padding.top + 8, 0, 0),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(17.5, 0, 17.5, 0),
            height: 35.5,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.only(right: 26),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _tabController.index = index;
                      });
                    },
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: 32.5,
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            _tabs[index],
                            style: TextStyle(
                              fontSize: index == _tabController.index ? 23 : 15,
                              color: index == _tabController.index
                                  ? rgba(18, 18, 18, 1)
                                  : rgba(153, 153, 153, 1),
                              fontWeight: index == _tabController.index
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          bottom: 0,
                          right: 0,
                          child: Center(
                            child: Container(
                              width: 6,
                              height: 3,
                              decoration: BoxDecoration(
                                color: index == _tabController.index
                                    ? rgba(18, 18, 18, 1)
                                    : null,
                                borderRadius: BorderRadius.circular(1.5),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: _tabs.length,
            ),
          ),
          Expanded(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: _tabs.map((tab) {
                int index = _tabs.indexOf(tab);
                return NearList(
                  listType: index,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
