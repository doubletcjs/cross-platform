import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hksy_flutter/public/public.dart';

class HomeNotice extends StatefulWidget {
  HomeNotice({Key key}) : super(key: key);

  @override
  _HomeNoticeState createState() => _HomeNoticeState();
}

class _HomeNoticeState extends State<HomeNotice> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(12, 27.5, 12, 35),
      child: Container(
        height: 37.5,
        padding: EdgeInsets.fromLTRB(17, 2, 9, 2),
        decoration: BoxDecoration(
          color: rgba(28, 35, 63, 1),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "images/ico_home_notice@3x.png",
              fit: BoxFit.fitHeight,
            ),
            SizedBox(
              width: 8.5,
            ),
            Expanded(
              child: Swiper.children(
                children: <Widget>[
                  Text(
                    "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacccc",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      color: rgba(255, 255, 255, 1),
                    ),
                  ),
                  Text(
                    "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbcccc",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      color: rgba(255, 255, 255, 1),
                    ),
                  ),
                  Text(
                    "cccccccccccccccccccccccccccccccccccccccc",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      color: rgba(255, 255, 255, 1),
                    ),
                  ),
                ],
                scrollDirection: Axis.vertical,
                autoplay: true,
                onTap: (index) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
