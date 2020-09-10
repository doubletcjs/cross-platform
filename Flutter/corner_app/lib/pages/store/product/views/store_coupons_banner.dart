import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

class StoreCouponsBanner extends StatefulWidget {
  final List banners;
  StoreCouponsBanner({
    Key key,
    this.banners,
  }) : super(key: key);

  @override
  _StoreCouponsBannerState createState() => _StoreCouponsBannerState();
}

class _StoreCouponsBannerState extends State<StoreCouponsBanner> {
  @override
  Widget build(BuildContext context) {
    return (this.widget.banners == null || this.widget.banners.length == 0)
        ? Container()
        : Container(
            padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
            color: rgba(247, 246, 245, 1),
            height: 80 + 12 * 2.0,
            child: ListView.separated(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
              ),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  width: (284.5 * MediaQuery.of(context).size.width) /
                      375, // 284.5/375 = x/w
                  decoration: BoxDecoration(
                    color: rgba(253, 231, 207, 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: 8,
                );
              },
              itemCount: this.widget.banners.length,
            ),
          );
  }
}
