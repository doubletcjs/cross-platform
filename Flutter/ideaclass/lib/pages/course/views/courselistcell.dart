import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ideaclass/pages/course/coursedetail.dart';
import 'package:ideaclass/public/public.dart';

class CourselistCell extends StatelessWidget {
  Map course;

  CourselistCell({this.course});

  void _courseDetail(BuildContext context, itemId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return CourseDetailPage(
            detailID: "$itemId",
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return course == null
        ? Container()
        : buttonWidget(
            Container(
              padding: EdgeInsets.fromLTRB(12, 8, 12, 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    child: FadeInImage.assetNetwork(
                      placeholder: "images/placeholder@3x.png",
                      image: course["coverUrl"],
                      width: 125,
                      height: 78,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  SizedBox(
                    width: 11,
                  ),
                  Expanded(
                    child: Container(
                      height: 78,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                course["title"],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: rgba(51, 51, 51, 1),
                                ),
                              ),
                              SizedBox(
                                height: 4,
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
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                (course["isFree"] == 1 ||
                                        course["vipPrice"] == 0.0)
                                    ? "免费"
                                    : ("￥" + "${course["price"]}"),
                                style: TextStyle(
                                  fontSize: 18,
                                  color: kMainColor,
                                ),
                              ),
                              Text(
                                "共${course["lessonNum"]}课时 ${course["learnNum"]}人学习",
                                style: TextStyle(
                                  fontSize: 9,
                                  color: rgba(136, 136, 136, 1),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            context,
            onTap: () {
              this._courseDetail(context, course["courseId"]);
            },
            color: Colors.white,
          );
  }
}
