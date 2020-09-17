import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

class SpaceCouponsBanner extends StatefulWidget {
  final List banners;
  SpaceCouponsBanner({
    Key key,
    this.banners,
  }) : super(key: key);

  @override
  _SpaceCouponsBannerState createState() => _SpaceCouponsBannerState();
}

class _SpaceCouponsBannerState extends State<SpaceCouponsBanner> {
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
                  padding: EdgeInsets.only(
                    left: 12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              "¥",
                              style: TextStyle(
                                color: rgba(235, 102, 91, 1),
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              "50",
                              style: TextStyle(
                                color: rgba(235, 102, 91, 1),
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "全场满199可用",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: rgba(235, 102, 91, 1),
                                      fontSize: 13,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    "2020.05.20-2020.06.20",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: rgba(235, 102, 91, 1),
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 7,
                          bottom: 7,
                        ),
                        padding: EdgeInsets.only(
                          left: 15,
                          right: 15,
                        ),
                        child: Text(
                          "立即领取",
                          style: TextStyle(
                            color: rgba(235, 102, 91, 1),
                            fontSize: 14,
                          ),
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              width: 0.5,
                              color: rgba(235, 102, 91, 1),
                            ),
                          ),
                        ),
                      ),
                    ],
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
