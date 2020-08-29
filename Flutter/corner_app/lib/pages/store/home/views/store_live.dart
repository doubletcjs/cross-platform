import 'package:cached_network_image/cached_network_image.dart';
import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

class StoreLive extends StatelessWidget {
  const StoreLive({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: rgba(247, 246, 245, 1),
      padding: EdgeInsets.only(top: 12),
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(16, 28, 16, 28),
        height: 197.5 + 28 * 2,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 封面
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 4),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    child: CachedNetworkImage(
                      placeholder: (context, url) {
                        return Image.asset(
                          "images/placeholder@3x.png",
                          width: 167.5,
                          height: 197.5,
                          fit: BoxFit.cover,
                        );
                      },
                      imageUrl:
                          "https://avatars1.githubusercontent.com/u/17046133?v=4",
                      width: 167.5,
                      height: 197.5,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  // 是否直播中
                  Positioned(
                    left: 12,
                    top: 12,
                    child: Container(
                      width: 52.5,
                      height: 16.5,
                      decoration: BoxDecoration(
                        color: rgba(0, 0, 0, 0.4),
                        borderRadius: BorderRadius.circular(8.5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 5,
                            height: 5,
                            decoration: BoxDecoration(
                              color: rgba(235, 102, 91, 1),
                              borderRadius: BorderRadius.circular(5 / 2),
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "直播中",
                            style: TextStyle(
                              fontSize: 11,
                              color: rgba(255, 255, 255, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 标题
                      Text(
                        "今日美食制作：柠檬水",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 18,
                          color: rgba(27, 27, 27, 1),
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      // 主播
                      Text(
                        "主播：红鱼",
                        style: TextStyle(
                          fontSize: 13,
                          color: rgba(153, 153, 153, 1),
                        ),
                      ),
                      SizedBox(
                        height: 28,
                      ),
                      // 图片列表
                      Container(
                        height: 50.5,
                        child: ListView.separated(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return networkImage(
                              "https://avatars1.githubusercontent.com/u/17046133?v=4",
                              Size(50.5, 50.5),
                              BorderRadius.circular(4),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Container(
                              width: 8,
                            );
                          },
                          itemCount: 10,
                        ),
                      ),
                    ],
                  ),
                  // 立即观看
                  Container(
                    decoration: BoxDecoration(
                      color: rgba(235, 102, 91, 1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    height: 28,
                    width: 109,
                    child: FlatButton(
                      onPressed: () {},
                      child: Text(
                        "立即观看",
                        style: TextStyle(
                          fontSize: 14,
                          color: rgba(241, 241, 241, 1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
