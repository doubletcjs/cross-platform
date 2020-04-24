import 'package:flutter/material.dart';
import 'package:ideaclass/public/public.dart';

class CourseLecturerInfo extends StatefulWidget {
  Map course;
  CourseLecturerInfo({this.course});

  @override
  _CourseLecturerInfoState createState() => _CourseLecturerInfoState();
}

class _CourseLecturerInfoState extends State<CourseLecturerInfo> {
  @override
  Widget build(BuildContext context) {
    return this.widget.course == null
        ? Container()
        : Container(
            padding: EdgeInsets.fromLTRB(14, 14, 14, 16),
            margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "老师介绍",
                  style: TextStyle(
                    fontSize: 12,
                    color: rgba(181, 181, 181, 1),
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(21, 13, 21, 13),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: rgba(0, 0, 0, 0.1),
                        blurRadius: 6,
                        spreadRadius: 0.2,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 76,
                        child: Column(
                          children: <Widget>[
                            buttonWidget(
                              ClipRRect(
                                child: this.widget.course["avatar"] == null
                                    ? Image.asset("images/placeholder@3x.png")
                                    : Image.network(
                                        "${this.widget.course["avatar"]}",
                                        width: 56,
                                        height: 56,
                                      ),
                                borderRadius: BorderRadius.circular(56 / 2),
                              ),
                              context,
                              onTap: () {},
                              radius: BorderRadius.circular(56 / 2),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${this.widget.course["nickname"]}",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                color: rgba(23, 23, 23, 1),
                              ),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            buttonWidget(
                              Text(
                                this.widget.course["isFollow"] == 0
                                    ? "+关注"
                                    : "已关注",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: rgba(24, 159, 248, 1),
                                ),
                              ),
                              context,
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 39,
                      ),
                      Expanded(
                        child: Container(
                          height: 100,
                          child: ListView(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            children: <Widget>[
                              Text(
                                "${this.widget.course["introduction"]}",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: rgba(88, 88, 88, 1),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
