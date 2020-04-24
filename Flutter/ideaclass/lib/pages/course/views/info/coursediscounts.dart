import 'package:flutter/material.dart';
import 'package:ideaclass/public/public.dart';

class CourseDiscounts extends StatefulWidget {
  Map course;
  CourseDiscounts({this.course});

  @override
  _CourseDiscountsState createState() => _CourseDiscountsState();
}

class _CourseDiscountsState extends State<CourseDiscounts> {
  @override
  Widget build(BuildContext context) {
    return this.widget.course == null
        ? Container()
        : Container(
            padding: EdgeInsets.fromLTRB(14, 20, 14, 12),
            margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "优惠",
                      style: TextStyle(
                        fontSize: 12,
                        color: rgba(181, 181, 181, 1),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                                child: Text(
                                  "课程优惠券",
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
                                width: 6,
                              ),
                              Expanded(
                                child: Text(
                                  this.widget.course["couponStr"] == null
                                      ? "暂无优惠券可领取"
                                      : "${this.widget.course["couponStr"]}",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: rgba(61, 146, 210, 1),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                                child: Text(
                                  "积分",
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
                                width: 6,
                              ),
                              Expanded(
                                child: Text(
                                  this.widget.course["integralStr"] == null
                                      ? "暂无积分可领取"
                                      : "${this.widget.course["integralStr"]}",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: rgba(61, 146, 210, 1),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    buttonWidget(
                      Row(
                        children: <Widget>[
                          Text(
                            "领券",
                            style: TextStyle(
                              fontSize: 12,
                              color: rgba(181, 181, 181, 1),
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Image.asset(
                            "images/jiantou@3x.png",
                            fit: BoxFit.fitWidth,
                            width: 6,
                          ),
                        ],
                      ),
                      context,
                      onTap: () {},
                    ),
                  ],
                ),
                SizedBox(
                  height: 18,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "服务",
                      style: TextStyle(
                        fontSize: 12,
                        color: rgba(181, 181, 181, 1),
                      ),
                    ),
                    buttonWidget(
                      Container(
                        padding: EdgeInsets.fromLTRB(28, 2, 0, 2),
                        child: Image.asset(
                          "images/jiantou@3x.png",
                          fit: BoxFit.fitWidth,
                          width: 6,
                        ),
                      ),
                      context,
                      onTap: () {},
                    ),
                  ],
                )
              ],
            ),
          );
  }
}
