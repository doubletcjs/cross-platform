import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:ideaclass/public/public.dart';

class ActivityHotSwiper extends StatefulWidget {
  List banners = [];
  ActivityHotSwiper({this.banners});

  _ActivityHotSwiperState _state;
  @override
  _ActivityHotSwiperState createState() {
    _state = _ActivityHotSwiperState();
    return _state;
  }

  void reloadData(List list) {
    if (list != null) {
      banners = list;
    }
  }
}

class _ActivityHotSwiperState extends State<ActivityHotSwiper> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(12, 0, 12, 11),
      color: Colors.white,
      height: 177,
      child: (this.widget.banners == null || this.widget.banners.length == 0)
          ? ClipRRect(
              child: Image.asset(
                "images/placeholder@3x.png",
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10),
            )
          : Swiper(
              itemCount: this.widget.banners.length,
              autoplay: true,
              itemWidth: 20,
              pagination: SwiperPagination(
                builder: DotSwiperPaginationBuilder(
                  size: 6,
                  activeSize: 6,
                  color: Colors.white38,
                  activeColor: Colors.white,
                  space: 4,
                ),
              ),
              itemBuilder: (context, index) {
                String url = "";
                if (this.widget.banners.length > 0 &&
                    this.widget.banners[index] != null) {
                  url = "${this.widget.banners[index]["picUrl"]}";
                }

                return buttonWidget(
                  radiusNetworkImage(
                    url,
                    MediaQuery.of(context).size.width - 12 * 2,
                    177,
                    radius: BorderRadius.circular(10),
                  ),
                  context,
                  onTap: () {},
                );
              },
            ),
    );
  }
}
