import 'package:corner_app/pages/store/product/views/store_coupons_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// ignore: must_be_immutable
class StoreProductPage extends StatefulWidget {
  int tab = 0;
  StoreProductPage({
    Key key,
    this.tab = 0,
  }) : super(key: key);

  @override
  _StoreProductPageState createState() => _StoreProductPageState();
}

class _StoreProductPageState extends State<StoreProductPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      children: [
        StoreCouponsBanner(
          banners: [
            "",
            "",
            "",
            "",
          ],
        ),
        CustomScrollView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          slivers: [
            SliverStaggeredGrid.countBuilder(
              crossAxisCount: 2,
              staggeredTileBuilder: (index) {
                return StaggeredTile.fit(1);
              },
              itemBuilder: (context, index) {
                return Card(
                  child: Container(
                    color: Colors.blue,
                    height: 80.0 + (index % 2 == 0 ? 80 : 40),
                    child: Center(
                      child: Text("a"),
                    ),
                  ),
                );
              },
              itemCount: 20,
            ),
          ],
        ),
      ],
    );
  }
}

/*
  // StoreCouponsBanner(
        //   banners: [
        //     "",
        //     "",
        //     "",
        //     "",
        //   ],
        // ),
        // CustomScrollView(
        //   shrinkWrap: true,
        //   slivers: [
        //     SliverStaggeredGrid.countBuilder(
        //       crossAxisCount: 2,
        //       staggeredTileBuilder: (index) {
        //         return StaggeredTile.fit(1);
        //       },
        //       itemBuilder: (context, index) {
        //         return Card(
        //           child: Container(
        //             color: Colors.blue,
        //             height: 80.0 + (index % 2 == 0 ? 80 : 40),
        //             child: Center(
        //               child: Text("a"),
        //             ),
        //           ),
        //         );
        //       },
        //       itemCount: 20,
        //     ),
        //   ],
        // ),
*/
