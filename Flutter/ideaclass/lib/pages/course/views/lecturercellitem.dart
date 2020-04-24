import 'package:flutter/material.dart';
import 'package:ideaclass/public/public.dart';

class LecturerCellItem extends StatelessWidget {
  Map lecturer;
  LecturerCellItem({this.lecturer});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 115,
      height: 137,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: rgba(0, 0, 0, 0.1),
            blurRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 19,
          ),
          buttonWidget(
            Stack(
              children: <Widget>[
                ClipRRect(
                  child: FadeInImage.assetNetwork(
                    placeholder: "images/user_head_default@3x.png",
                    image: lecturer["avatar"],
                    width: 56,
                    height: 56,
                  ),
                  borderRadius: BorderRadius.circular(56 / 2),
                ),
                lecturer["isLector"] == 1
                    ? Positioned(
                        bottom: 0,
                        right: 0,
                        child: Image.asset(
                          "images/lecturer_logo@3x.png",
                          width: 18,
                          height: 24,
                        ),
                      )
                    : Container(),
              ],
            ),
            context,
            onTap: () {
              kLog("any");
            },
            radius: BorderRadius.circular(56 / 2),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Text(
              lecturer["nickname"],
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                color: rgba(23, 23, 23, 1),
              ),
            ),
          ),
          SizedBox(
            height: 7,
          ),
          buttonWidget(
            Text(
              lecturer["nickname"] == 1 ? "已关注" : "+关注",
              style: TextStyle(
                fontSize: 10,
                color: rgba(24, 159, 248, 1),
              ),
            ),
            context,
            onTap: () {
              kLog("any");
            },
          ),
        ],
      ),
    );
  }
}
