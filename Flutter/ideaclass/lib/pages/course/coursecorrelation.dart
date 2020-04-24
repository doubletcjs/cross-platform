import 'package:flutter/material.dart';
import 'package:ideaclass/components/functionsection.dart';
import 'package:ideaclass/pages/course/views/correlation/lecturerrecommendcell.dart';
import 'package:ideaclass/pages/course/views/correlation/memberrecommend.dart';

class CourseCorrelationPage extends StatefulWidget {
  Map course;
  CourseCorrelationPage({this.course});

  @override
  _CourseCorrelationPageState createState() => _CourseCorrelationPageState();
}

class _CourseCorrelationPageState extends State<CourseCorrelationPage> {
  MemberRecommend _memberRecommend = MemberRecommend();
  List _lectorRecommendCourse = [];

  @override
  void initState() {
    super.initState();

    _memberRecommend = MemberRecommend(
      recommendCourses: this.widget.course["userRecommendCourse"],
      courseId: this.widget.course["courseId"],
    );

    _lectorRecommendCourse = this.widget.course["lectorRecommendCourse"];
  }

  @override
  Widget build(BuildContext context) {
    return this.widget.course == null
        ? Container()
        : ListView.separated(
            shrinkWrap: true,
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              int trueIndex = index - 2;
              return index == 0
                  ? _memberRecommend
                  : index == 1
                      ? Container(
                          margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
                          color: Colors.white,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(12, 6, 12, 9),
                            child: FunctionSection(
                              title: "老师推荐",
                            ),
                          ),
                        )
                      : LecturerRecommendCell(
                          course: _lectorRecommendCourse[trueIndex],
                          courseId: this.widget.course["courseId"],
                        );
            },
            separatorBuilder: (context, index) {
              int trueIndex = index - 2;
              return trueIndex >= 0
                  ? Container(
                      height: 16,
                      color: Colors.white,
                    )
                  : Container();
            },
            itemCount: _lectorRecommendCourse.length + 2,
          );
  }
}
