import 'package:flutter/material.dart';
import 'package:ideaclass/components/functionsection.dart';
import 'package:ideaclass/pages/course/views/coursecellitem.dart';
import 'package:ideaclass/public/public.dart';

class CourseListView extends StatelessWidget {
  List dataList;
  String section;
  kObjectFunctionBlock listHandle;

  CourseListView({this.dataList, this.section, this.listHandle});

  @override
  Widget build(BuildContext context) {
    return (dataList == null || dataList.length == 0)
        ? Container()
        : Container(
            padding: EdgeInsets.fromLTRB(12, 0, 12, 12),
            color: Colors.white,
            child: Column(
              children: <Widget>[
                section != null
                    ? FunctionSection(
                        title: section,
                      )
                    : Container(),
                Container(
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: dataList.map(
                      (course) {
                        return buttonWidget(
                          CourseCellItem(
                            course: course,
                          ),
                          context,
                          onTap: () {
                            if (listHandle != null) {
                              listHandle(course);
                            }
                          },
                          radius: BorderRadius.circular(4),
                        );
                      },
                    ).toList(),
                  ),
                ),
              ],
            ),
          );
  }
}
