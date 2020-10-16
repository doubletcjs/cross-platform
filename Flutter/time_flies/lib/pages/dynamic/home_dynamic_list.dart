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
    return StaggeredGridView.countBuilder(
      padding: EdgeInsets.only(
        top: 0,
        bottom: MediaQuery.of(context).padding.bottom,
        left: 16,
        right: 16,
      ),
      crossAxisCount: 2,
      mainAxisSpacing: 16.0,
      crossAxisSpacing: 16.0,
      itemBuilder: (context, index) {
        return HomeDynamicCell();
      },
      staggeredTileBuilder: (index) {
        return StaggeredTile.fit(1);
      },
      itemCount: this.widget.dynamicType == 0 ? 20 : 30,
    );
  }
}
