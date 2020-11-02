import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:time_flies/pages/dynamic/views/home_dynamic_cell.dart';

// ignore: must_be_immutable
class HomeDynamicList extends StatefulWidget {
  int dynamicType = 0; // 0 作品 1 喜欢
  HomeDynamicList({
    Key key,
    // ignore: invalid_required_named_param
    @required this.dynamicType = 0,
  }) : super(key: key);

  @override
  _HomeDynamicListState createState() => _HomeDynamicListState();
}

class _HomeDynamicListState extends State<HomeDynamicList> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return Container(
          height: 120,
          color: Colors.red,
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
      itemCount: this.widget.dynamicType == 0 ? 20 : 30,
    );
  }
}
