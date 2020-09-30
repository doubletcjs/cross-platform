import 'package:corner_app/pages/module/store/module/space/views/sapce_coupons_banner.dart';
import 'package:corner_app/pages/module/store/views/store_product_cell.dart';
import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// ignore: must_be_immutable
class SpaceStorePage extends StatefulWidget {
  int tab = 0;
  SpaceStorePage({
    Key key,
    this.tab = 0,
  }) : super(key: key);

  _SpaceStorePageState state = _SpaceStorePageState();

  @override
  _SpaceStorePageState createState() {
    return state;
  }
}

class _SpaceStorePageState extends State<SpaceStorePage>
    with AutomaticKeepAliveClientMixin {
  List _products = [
    {"name": "活性釉沙拉碗，西榆木黑白色", "price": 69.00},
    {"name": "小碗上釉的粗陶器", "price": 38.00},
    {"name": "大理石圆形托盘，带小边框", "price": 99.00},
    {"name": "大理石小碗", "price": 88.00},
    {"name": "彩色陶器三件套", "price": 138.00},
    {"name": "仪式茶蜡烛  每种茶香气都舒缓和舒适", "price": 79.00},
  ];

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: rgba(247, 246, 245, 1),
      child: ListView(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 84),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        // primary: false,
        children: [
          SpaceCouponsBanner(
            banners: [
              "",
              "",
              "",
              "",
            ],
          ),
          Container(
            color: rgba(247, 246, 245, 1),
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 0,
              top: 0,
            ),
            child: CustomScrollView(
              shrinkWrap: true,
              // primary: false,
              physics: NeverScrollableScrollPhysics(),
              slivers: [
                SliverStaggeredGrid.countBuilder(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  staggeredTileBuilder: (index) {
                    return StaggeredTile.fit(1);
                  },
                  itemBuilder: (context, index) {
                    var product = _products[index];
                    return StoreProductCell(
                      product: product,
                    );
                  },
                  itemCount: _products.length,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
