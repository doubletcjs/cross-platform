import 'package:flutter/material.dart';
import 'package:time_flies/pages/dynamic/dynamic_detail.dart';
import 'package:time_flies/pages/dynamic/views/dynamic_cell.dart';
import 'package:time_flies/public/public.dart';

class DynamicList extends StatefulWidget {
  DynamicList({Key key}) : super(key: key);

  @override
  _DynamicListState createState() => _DynamicListState();
}

class _DynamicListState extends State<DynamicList>
    with AutomaticKeepAliveClientMixin {
  List _dataList = [
    {},
    {},
    {},
    {},
    {},
    {},
    {},
    {},
    {},
  ];

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(
      itemBuilder: (context, index) {
        return Card(
          color: rgba(255, 255, 255, 1),
          margin: EdgeInsets.only(
            left: 10,
            right: 10,
            bottom: 6,
          ),
          elevation: 10.0,
          shadowColor: rgba(0, 0, 0, 0.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return DynamicDetailPage(
                    dynamic: _dataList[index],
                  );
                }),
              );
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(14, 13.5, 15, 10),
              child: DynamicBaseCell(
                dynamic: _dataList[index],
              ),
            ),
          ),
        );
      },
      itemCount: _dataList.length,
    );
  }
}
