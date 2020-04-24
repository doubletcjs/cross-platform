import 'package:flutter/material.dart';
import 'package:ideaclass/pages/community/communityrecommend.dart';
import 'package:ideaclass/public/public.dart';

class RecommendHeader extends StatelessWidget {
  const RecommendHeader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buttonWidget(
      Container(
        height: 56,
        padding: EdgeInsets.fromLTRB(13, 0, 12, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "推些有趣的人给你",
              style: TextStyle(
                fontSize: 15,
                color: rgba(23, 23, 23, 1),
              ),
            ),
            Image.asset(
              "images/jiantou@3x.png",
              color: kMainColor,
              fit: BoxFit.fitWidth,
              width: 8,
            ),
          ],
        ),
      ),
      context,
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return CommunityRecommend();
            },
          ),
        );
      },
      color: rgba(236, 236, 236, 1),
    );
  }
}
