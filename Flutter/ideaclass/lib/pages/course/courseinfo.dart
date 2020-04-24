import 'package:flutter/material.dart';
import 'package:ideaclass/pages/course/views/info/coursediscounts.dart';
import 'package:ideaclass/pages/course/views/info/courseinfoheader.dart';
import 'package:ideaclass/pages/course/views/info/courselecturerinfo.dart';

class CourseInfoPage extends StatefulWidget {
  Map course;
  CourseInfoPage({this.course});

  @override
  _CourseInfoPageState createState() => _CourseInfoPageState();
}

class _CourseInfoPageState extends State<CourseInfoPage> {
  CourseInfoHeader _infoHeader = CourseInfoHeader();
  CourseDiscounts _discounts = CourseDiscounts();
  CourseLecturerInfo _lecturerInfo = CourseLecturerInfo();

  @override
  void initState() {
    super.initState();

    _infoHeader = CourseInfoHeader(
      course: this.widget.course,
    );

    _discounts = CourseDiscounts(
      course: this.widget.course,
    );

    _lecturerInfo = CourseLecturerInfo(
      course: this.widget.course,
    );
  }

  @override
  Widget build(BuildContext context) {
    return this.widget.course == null
        ? Container()
        : ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              switch (index) {
                case 0:
                  return _infoHeader;
                  break;
                case 1:
                  return _discounts;
                  break;
                case 2:
                  return _lecturerInfo;
                  break;
                default:
                  return Container();
                  break;
              }
            },
            itemCount: 3,
          );
  }
}
