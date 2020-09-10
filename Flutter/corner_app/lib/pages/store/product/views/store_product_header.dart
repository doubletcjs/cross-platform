import 'package:corner_app/pages/store/classify/store_classify.dart';
import 'package:corner_app/pages/store/home/views/store_tabbar.dart';
import 'package:corner_app/pages/store/product/store_product_detail.dart';
import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StoreProductHeader extends StatefulWidget {
  int tabIndex = 0;
  kObjectFunctionBlock tabSwitchHandle;
  StoreProductHeader({
    Key key,
    this.tabIndex = 0,
    this.tabSwitchHandle,
  }) : super(key: key);

  @override
  _StoreProductHeaderState createState() => _StoreProductHeaderState();
}

class _StoreProductHeaderState extends State<StoreProductHeader>
    with AutomaticKeepAliveClientMixin {
  // 分类
  void _showClassify() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return StoreClassifyPage();
      }),
    );
  }

  // 商铺详情
  void _showDetail() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return StoreProductDetail();
      }),
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      height: 64 + 44.0 + 8,
      decoration: BoxDecoration(
        color: rgba(255, 255, 255, 1),
        border: Border(
          top: BorderSide(
            width: 8,
            color: rgba(247, 246, 245, 1),
          ),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 64,
            padding: EdgeInsets.fromLTRB(21.5, 0, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    this._showDetail();
                  },
                  child: Row(
                    children: [
                      // 封面
                      networkImage(
                        "https://avatars1.githubusercontent.com/u/17046133?v=4",
                        Size(40, 40),
                        BorderRadius.circular(40 / 2),
                      ),
                      SizedBox(
                        width: 13,
                      ),
                      // 店名
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: 220,
                        ),
                        child: Text(
                          "每日一食记的小铺",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 18,
                            color: rgba(50, 50, 50, 1),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Image.asset(
                        "images/detail_arrow@3x.png",
                        height: 10,
                        width: 6,
                      ),
                    ],
                  ),
                ),
                // 客服
                Row(
                  children: [
                    Image.asset(
                      "images/store_service@3x.png",
                      height: 21.73,
                      width: 24,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "客服",
                      style: TextStyle(
                        fontSize: 14,
                        color: rgba(235, 102, 91, 1),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            child: Stack(
              children: [
                StoreTabBar(
                  tabList: [
                    "推荐",
                    "销量",
                    "价格",
                  ],
                  height: 44,
                  tabIndex: this.widget.tabIndex,
                  tabSwitchHandle: (tab) {
                    setState(() {
                      this.widget.tabIndex = tab;
                      if (this.widget.tabSwitchHandle != null) {
                        this.widget.tabSwitchHandle(tab);
                      }
                    });
                  },
                ),
                // 分类
                Positioned(
                  right: 16,
                  height: 44,
                  child: InkWell(
                    onTap: () {
                      this._showClassify();
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          "images/store_classify@3x.png",
                          height: 16,
                          width: 16,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "分类",
                          style: TextStyle(
                            fontSize: 13,
                            color: rgba(50, 50, 50, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
