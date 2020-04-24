import 'package:flutter/material.dart';
import 'package:ideaclass/pages/course/coursedetail.dart';
import 'package:ideaclass/public/public.dart';

class LecturerRecommendCell extends StatelessWidget {
  Map course;
  var courseId;
  LecturerRecommendCell({this.course, this.courseId});

  void _courseDetail(BuildContext context, itemId) {
    if (courseId != itemId) {
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
  }

  @override
  Widget build(BuildContext context) {
    return (course == null || course.length == 0)
        ? Container()
        : buttonWidget(
            Container(
              padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ClipRRect(
                    child: course["coverUrl"] == null
                        ? Image.asset(
                            "images/placeholder@3x.png",
                            width: 125,
                            height: 78,
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            course["coverUrl"],
                            width: 125,
                            height: 78,
                            fit: BoxFit.cover,
                          ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(11, 0, 0, 0),
                      height: 78,
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            top: 2,
                            left: 0,
                            right: 0,
                            child: Text(
                              course["title"] == null ? "" : course["title"],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 13,
                                color: rgba(23, 23, 23, 1),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 12,
                            left: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  (course["isFree"] == 1 ||
                                          course["price"].toStringAsFixed(2) ==
                                              0.0)
                                      ? "免费"
                                      : "${course["price"].toStringAsFixed(2)}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: kMainColor,
                                  ),
                                ),
                                Text(
                                  "共${course["lessonNum"]}课时${course["learnNum"]}人学习",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: rgba(181, 181, 181, 1),
                                  ),
                                ),
                              ],
                            ),
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
