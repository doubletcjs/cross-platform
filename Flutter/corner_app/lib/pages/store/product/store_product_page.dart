import 'package:corner_app/pages/store/product/views/store_coupons_banner.dart';
import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// ignore: must_be_immutable
class StoreProductPage extends StatefulWidget {
  int tab = 1;
  StoreProductPage({
    Key key,
    this.tab = 1,
  }) : super(key: key);

  @override
  _StoreProductPageState createState() => _StoreProductPageState();
}

class _StoreProductPageState extends State<StoreProductPage>
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
    return ListView(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      // primary: false,
      children: [
        StoreCouponsBanner(
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
                  var itemWH =
                      (MediaQuery.of(context).size.width - 16 * 2 - 8) / 2;
                  var product = _products[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: rgba(255, 255, 255, 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        networkImage(
                          "",
                          Size(itemWH, itemWH),
                          BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(7.5, 12, 7.5, 4),
                          child: Text(
                            product["name"],
                            style: TextStyle(
                              fontSize: 14,
                              color: rgba(50, 50, 50, 1),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(7.5, 0, 7.5, 10.5),
                          child: Row(
                            children: [
                              Text(
                                "￥",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: rgba(235, 102, 91, 1),
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                "${product["price"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: rgba(235, 102, 91, 1),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: _products.length,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
