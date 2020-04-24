import 'package:flutter/material.dart';
import 'package:ideaclass/components/functionsection.dart';
import 'package:ideaclass/pages/course/views/lecturercellitem.dart';
import 'package:ideaclass/public/public.dart';

class LecturerListView extends StatelessWidget {
  List dataList;
  String section;

  LecturerListView({this.dataList, this.section});

  @override
  Widget build(BuildContext context) {
    return (dataList == null || dataList.length == 0)
        ? Container()
        : Container(
            padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
            color: rgba(239, 239, 239, 1),
            child: Column(
              children: <Widget>[
                section != null
                    ? Container(
                        padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                        color: Colors.white,
                        child: FunctionSection(
                          title: section,
                        ),
                      )
                    : Container(),
                Container(
                  color: Colors.white,
                  height: 151,
                  child: ListView.builder(
                    padding: EdgeInsets.fromLTRB(14, 4, 14, 10),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        padding:
                            EdgeInsets.fromLTRB(index == 0 ? 0 : 10, 0, 0, 0),
                        child: LecturerCellItem(
                          lecturer: dataList[index],
                        ),
                      );
                    },
                    itemCount: dataList.length,
                  ),
                ),
              ],
            ),
          );
  }
}
