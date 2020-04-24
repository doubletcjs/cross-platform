import 'package:flutter/material.dart';
import 'package:ideaclass/public/public.dart';

class CourseInfoHeader extends StatefulWidget {
  Map course;
  CourseInfoHeader({this.course});

  @override
  _CourseInfoHeaderState createState() => _CourseInfoHeaderState();
}

class _CourseInfoHeaderState extends State<CourseInfoHeader> {
  @override
  Widget build(BuildContext context) {
    return this.widget.course == null
        ? Container()
        : Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(14, 20, 14, 12),
                margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      (this.widget.course["isFree"] == 1 ||
                              this.widget.course["price"].toStringAsFixed(2) ==
                                  0.0)
                          ? "免费"
                          : "${this.widget.course["price"].toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 18,
                        color: kMainColor,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "价格",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black38,
                          ),
                        ),
                        Text(
                          "¥" +
                              "${this.widget.course["originalPrice"].toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 12,
                            color: rgba(181, 181, 181, 1),
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "课时:共${this.widget.course["lessonNum"]}课时",
                      style: TextStyle(
                        fontSize: 10,
                        color: rgba(181, 181, 181, 1),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                          child: Text(
                            "${this.widget.course["className"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: kMainColor,
                            borderRadius: BorderRadius.circular(19 / 2),
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: Text(
                            "${this.widget.course["title"]}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "评分:${this.widget.course["score"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: rgba(202, 163, 77, 1),
                          ),
                        ),
                        Text(
                          "学习:已有${this.widget.course["learnNum"]}人",
                          style: TextStyle(
                            fontSize: 10,
                            color: rgba(181, 181, 181, 1),
                          ),
                        ),
                        Text(
                          "访问:已有${this.widget.course["viewNum"]}次",
                          style: TextStyle(
                            fontSize: 10,
                            color: rgba(181, 181, 181, 1),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Positioned(
                top: 16,
                right: 40,
                child: Column(
                  children: <Widget>[
                    buttonWidget(
                      Container(
                        width: 36,
                        height: 36,
                        child: Icon(
                          this.widget.course["isCollect"] == 0
                              ? Icons.star_border
                              : Icons.star,
                          color: rgba(223, 218, 105, 1),
                        ),
                      ),
                      context,
                      onTap: () {
                        kLog("${this.widget.course["isCollect"]}");
                      },
                    ),
                    Text(
                      "收藏",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
  }
}
