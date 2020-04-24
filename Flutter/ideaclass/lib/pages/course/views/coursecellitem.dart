import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ideaclass/public/public.dart';

class CourseCellItem extends StatelessWidget {
  Map course = {};
  double cellWidth = 0.0;
  CourseCellItem({this.course});

  @override
  Widget build(BuildContext context) {
    if (cellWidth == 0.0) {
      cellWidth = (MediaQuery.of(context).size.width - 12 * 3) / 2;
    }

    return Container(
      width: cellWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          radiusNetworkImage(
            "${course["coverUrl"]}",
            cellWidth,
            (cellWidth * 97) / 172, // 172/97 = cellWidth/x
            radius: BorderRadius.circular(4),
          ),
          SizedBox(
            height: 9,
          ),
          Container(
            height: 35,
            width: cellWidth,
            child: Text(
              "${course["title"]}",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                color: rgba(23, 23, 23, 1),
              ),
            ),
          ),
          SizedBox(
            height: 9,
          ),
          Row(
            children: <Widget>[
              RatingBar(
                initialRating: course["score"],
                minRating: 0.1,
                maxRating: 5.0,
                itemCount: 5,
                itemSize: 12,
                itemBuilder: (context, index) {
                  return Icon(
                    Icons.star,
                    color: Colors.amber,
                  );
                },
                onRatingUpdate: null,
              ),
              SizedBox(
                width: 6,
              ),
              Text(
                "${course["score"]}分",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.amber,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 9,
          ),
          Text(
            (course["isFree"] == 1 || course["vipPrice"] == 0.0)
                ? "免费"
                : ("￥" + "${course["price"]}"),
            style: TextStyle(
              fontSize: 12,
              color: (course["isFree"] == 1 || course["vipPrice"] == 0.0)
                  ? kMainColor
                  : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
} 
