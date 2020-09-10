import 'package:corner_app/pages/function/general_dialog.dart';
import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

class StoreProductQrcode extends StatelessWidget {
  StoreProductQrcode({Key key}) : super(key: key);

  show(BuildContext context) {
    GeneralDialog().show(
      context,
      backgroundPadding: EdgeInsets.only(
        left: 16,
        right: 16,
      ),
      backgroundAlignment: Alignment.center,
      containerContent: this,
      barrierDismissible: true,
      backgroundColor: Color.fromRGBO(0, 0, 0, 0.4),
      contentBackgroundColor: rgba(27, 27, 27, 1),
      borderRadius: BorderRadius.circular(8),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 33,
        bottom: 37,
        left: 88,
        right: 88,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 封面
          networkImage(
            "",
            Size(40, 40),
            BorderRadius.circular(40 / 2),
          ),
          SizedBox(
            height: 12,
          ),
          // 商铺名称
          Text(
            "每日一食记的小铺",
            style: TextStyle(
              fontSize: 18,
              color: rgba(255, 255, 255, 1),
            ),
          ),
          SizedBox(
            height: 32,
          ),
          // 二维码
          Container(
            width: 167.5,
            height: 167.5,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: rgba(255, 255, 255, 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: networkImage(
              "",
              Size(147.5, 147.5),
              BorderRadius.circular(0),
            ),
          ),
          SizedBox(
            height: 42,
          ),
          // 扫一扫，分享店铺给TA
          Text(
            "扫一扫，分享店铺给TA",
            style: TextStyle(
              fontSize: 14,
              color: rgba(255, 255, 255, 1),
            ),
          ),
        ],
      ),
    );
  }
}
