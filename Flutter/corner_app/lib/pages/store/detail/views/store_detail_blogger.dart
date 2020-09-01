import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

class StoreDetailBlogger extends StatelessWidget {
  const StoreDetailBlogger({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 20, 16, 20),
      decoration: BoxDecoration(
        color: rgba(255, 255, 255, 1),
        border: Border(
          top: BorderSide(
            width: 12,
            color: rgba(247, 246, 245, 1),
          ),
        ),
      ),
      child: Row(
        children: [
          networkImage(
            "",
            Size(40, 40),
            BorderRadius.circular(40 / 2),
          ),
          SizedBox(
            width: 12.5,
          ),
          Expanded(
            child: Text(
              "落主：红鱼",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                color: rgba(50, 50, 50, 1),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
