import 'package:cached_network_image/cached_network_image.dart';
import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

class StoreLive extends StatelessWidget {
  const StoreLive({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: rgba(247, 246, 245, 1),
      child: Column(
        children: [
          SizedBox(
            height: 12,
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(16, 28, 16, 28),
            child: Row(
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
                          imageUrl: "",
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
