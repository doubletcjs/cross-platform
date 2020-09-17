import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

class SpaceDetailHeader extends StatelessWidget {
  const SpaceDetailHeader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: rgba(255, 255, 255, 1),
      padding: EdgeInsets.fromLTRB(16, 30, 16, 20),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: rgba(255, 255, 255, 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 4),
                  blurRadius: 6,
                ),
              ],
            ),
            child: networkImage(
              "",
              Size(50.5, 50.5),
              BorderRadius.circular(4),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            "每日一食记",
            style: TextStyle(
              fontSize: 20,
              color: rgba(50, 50, 50, 1),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "ID:1234658",
                style: TextStyle(
                  fontSize: 14,
                  color: rgba(50, 50, 50, 1),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: rgba(235, 102, 91, 1),
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Text(
                  "生活",
                  style: TextStyle(
                    fontSize: 12,
                    color: rgba(235, 102, 91, 1),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "简介",
                style: TextStyle(
                  fontSize: 16,
                  color: rgba(50, 50, 50, 1),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 26.5,
              ),
              Expanded(
                child: Text(
                  "相濡以滋味，相忘于江湖，每一个制造和享用美食的人无不经历江湖夜雨，期待桃李春风。",
                  style: TextStyle(
                    fontSize: 16,
                    color: rgba(153, 153, 153, 1),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
