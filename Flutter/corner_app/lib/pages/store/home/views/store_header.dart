import 'package:cached_network_image/cached_network_image.dart';
import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

class StoreHeader extends StatelessWidget {
  const StoreHeader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "images/homepages_default_bg.png",
          height: 217 + MediaQuery.of(context).padding.top,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Container(
          color: rgba(0, 0, 0, 0.4),
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 92,
              ),
              // 店铺信息
              Container(
                padding: EdgeInsets.only(
                  left: 14.5,
                  right: 14.5,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // 封面
                        networkImage(
                          "https://avatars1.githubusercontent.com/u/17046133?v=4",
                          Size(50.5, 50.5),
                          BorderRadius.circular(50.5 / 2),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        // 名称
                        Expanded(
                          child: Text(
                            "每日一食记",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 20,
                              color: rgba(255, 255, 255, 1),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 13.5,
                    ),
                    Text(
                      "23361人已加入·138篇内容",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: rgba(255, 255, 255, 0.5),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 19.5,
              ),
              Image.asset(
                "images/introduction_header@3x.png",
                fit: BoxFit.contain,
                width: MediaQuery.of(context).size.width,
              ),
              // 简介
              Container(
                color: Colors.white,
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: 28,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "简介",
                      style: TextStyle(
                        fontSize: 14,
                        color: rgba(50, 50, 50, 1),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Text(
                        "相濡以滋味，相忘于江湖，每一个制造和享用美食的人无不经历江湖夜雨，期待桃李春风。",
                        style: TextStyle(
                          fontSize: 14,
                          color: rgba(153, 153, 153, 1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
