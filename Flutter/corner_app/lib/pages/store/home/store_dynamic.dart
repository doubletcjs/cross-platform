import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

class StoreDynamicPage extends StatefulWidget {
  StoreDynamicPage({Key key}) : super(key: key);

  @override
  _StoreDynamicPageState createState() => _StoreDynamicPageState();
}

class _StoreDynamicPageState extends State<StoreDynamicPage>
    with AutomaticKeepAliveClientMixin {
  int _tabIndex = 0;
  List<String> _tabs = [
    "最新",
    "热门",
    "精华",
  ];

  @override
  bool get wantKeepAlive => true;

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Column(
      children: [
        // tab bar
        Container(
          color: rgba(255, 255, 255, 1),
          height: 44,
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
          ),
          child: Row(
            children: _tabs.map((tab) {
              var index = _tabs.indexOf(tab);
              return Container(
                width: 50.5,
                height: 20,
                decoration: BoxDecoration(
                  color: _tabIndex == index
                      ? rgba(247, 246, 245, 1)
                      : rgba(255, 255, 255, 1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: FlatButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    setState(() {
                      _tabIndex = index;
                    });
                  },
                  child: Text(
                    tab,
                    style: TextStyle(
                      fontSize: 13,
                      color: _tabIndex == index
                          ? rgba(50, 50, 50, 1)
                          : rgba(153, 153, 153, 1),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        Expanded(
          child: ListView(),
        ),
      ],
    );
  }
}
