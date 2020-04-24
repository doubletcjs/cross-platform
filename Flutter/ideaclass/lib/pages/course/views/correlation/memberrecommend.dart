import 'package:flutter/material.dart';
import 'package:ideaclass/components/functionsection.dart';
import 'package:ideaclass/pages/course/coursedetail.dart';
import 'package:ideaclass/public/public.dart';

class MemberRecommend extends StatelessWidget {
  List recommendCourses = [];
  var courseId;
  MemberRecommend({this.recommendCourses, this.courseId});

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
    return (recommendCourses == null || recommendCourses.length == 0)
        ? Container()
        : Container(
            margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(12, 6, 12, 9),
                  child: FunctionSection(
                    title: "会员推荐",
                  ),
                ),
                Container(
                  height: 97.0 + 9 + 16 + 12,
                  child: ListView.builder(
                    padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      var course = recommendCourses[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Stack(
                                children: <Widget>[
                                  buttonWidget(
                                    ClipRRect(
                                      child: course["coverUrl"] == null
                                          ? Image.asset(
                                              "images/placeholder@3x.png",
                                              width: 172,
                                              height: 97,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.network(
                                              course["coverUrl"],
                                              width: 172,
                                              height: 97,
                                              fit: BoxFit.cover,
                                            ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    context,
                                    onTap: () {
                                      this._courseDetail(
                                          context, course["courseId"]);
                                    },
                                  ),
                                  (course["isFree"] == 1 ||
                                          course["price"].toStringAsFixed(2) ==
                                              0.0)
                                      ? Positioned(
                                          child: Image.asset(
                                            "images/mianfei@3x.png",
                                            width: 27,
                                            height: 26,
                                          ),
                                        )
                                      : Container(),
                                ],
                              ),
                              SizedBox(
                                width: 8,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 9,
                          ),
                          buttonWidget(
                            Container(
                              width: 172,
                              child: Text(
                                "${course["title"]}",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: rgba(23, 23, 23, 1),
                                ),
                              ),
                            ),
                            context,
                            onTap: () {
                              this._courseDetail(context, course["courseId"]);
                            },
                          ),
                        ],
                      );
                    },
                    itemCount: recommendCourses.length,
                  ),
                ),
              ],
            ),
          );
  }
}
