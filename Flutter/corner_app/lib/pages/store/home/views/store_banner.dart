import 'package:cached_network_image/cached_network_image.dart';
import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class StoreBanner extends StatelessWidget {
  const StoreBanner({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
      color: rgba(247, 246, 245, 1),
      height: 120.0 + 12 * 2,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return networkImage(
            "https://avatars1.githubusercontent.com/u/17046133?v=4",
            Size(120, 120),
            BorderRadius.circular(8),
          );
        },
        itemCount: 3,
        autoplay: true,
      ),
    );
  }
}
