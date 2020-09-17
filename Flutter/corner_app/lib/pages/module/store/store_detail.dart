import 'package:corner_app/pages/module/store/store_qrcode.dart';
import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

class StoreDetail extends StatefulWidget {
  StoreDetail({Key key}) : super(key: key);

  @override
  _StoreDetailState createState() => _StoreDetailState();
}

class _StoreDetailState extends State<StoreDetail> {
  Widget _detailCell(
    String text,
    String value,
    Widget child,
    kVoidFunctionBlock tapHandle,
  ) {
    return Material(
      color: rgba(255, 255, 255, 1),
      child: InkWell(
        onTap: tapHandle,
        child: Container(
          height: 48,
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: TextStyle(
                  fontSize: 14,
                  color: rgba(153, 153, 153, 1),
                ),
              ),
              child != null
                  ? child
                  : Text(
                      value,
                      style: TextStyle(
                        fontSize: 14,
                        color: rgba(50, 50, 50, 1),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  // 显示二维码
  void _showQrcode() {
    StoreQrcode().show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rgba(255, 255, 255, 1),
      appBar: customAppBar(
        title: "商店详情",
        defaultBack: true,
      ),
      body: ListView(
        children: [
          // 商铺名
          Container(
            padding: EdgeInsets.fromLTRB(21.5, 12, 21.5, 12),
            decoration: BoxDecoration(
              color: rgba(255, 255, 255, 1),
              border: Border(
                top: BorderSide(
                  width: 12,
                  color: rgba(247, 246, 245, 1),
                ),
              ),
            ),
            child: Row(
              children: [
                networkImage(
                  "",
                  Size(40, 40),
                  BorderRadius.circular(40 / 2),
                ),
                SizedBox(
                  width: 13,
                ),
                Expanded(
                  child: Text(
                    "每日一食记的小铺",
                    style: TextStyle(
                      fontSize: 18,
                      color: rgba(50, 50, 50, 1),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 商铺简介
          Container(
            padding: EdgeInsets.fromLTRB(16, 28, 16, 19.5),
            decoration: BoxDecoration(
              color: rgba(255, 255, 255, 1),
              border: Border(
                top: BorderSide(
                  width: 12,
                  color: rgba(247, 246, 245, 1),
                ),
                bottom: BorderSide(
                  width: 12,
                  color: rgba(247, 246, 245, 1),
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "商店简介",
                  style: TextStyle(
                    fontSize: 14,
                    color: rgba(50, 50, 50, 1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  "浦贝陶的制作历史悠久，起源于明末清初，据说是随李自成军中一个叫李忠的部下将江西景德镇的陶器烧制技艺带至易门并在浦贝一带流传。后来经文物专家对浦贝“李忠碗窑”出土的陶器进行考证，得以证实“浦贝陶”的制作历史确为明末清初，至今已有350多年。",
                  style: TextStyle(
                    fontSize: 14,
                    color: rgba(153, 153, 153, 1),
                  ),
                ),
              ],
            ),
          ),
          _detailCell(
            "店铺二维码",
            "",
            Row(
              children: [
                Image.asset(
                  "images/store_qrcode@3x.png",
                  width: 20,
                  height: 20,
                ),
                SizedBox(
                  width: 21.5,
                ),
                Image.asset(
                  "images/detail_arrow@3x.png",
                  width: 5.5,
                  height: 10,
                ),
              ],
            ),
            () {
              this._showQrcode();
            },
          ),
          _detailCell("所在地", "广州", null, null),
          _detailCell("开店时间", "2020-07-24", null, null),
        ],
      ),
    );
  }
}
