import 'package:flutter/material.dart';
import 'package:time_flies/public/public.dart';

class SearchCenter extends StatefulWidget {
  SearchCenter({Key key}) : super(key: key);

  @override
  _SearchCenterState createState() => _SearchCenterState();
}

class _SearchCenterState extends State<SearchCenter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        titleView: Row(
          children: [
            Expanded(
              child: TextField(
                style: TextStyle(
                  fontSize: 17,
                ),
                decoration: InputDecoration(
                  hintText: "搜索",
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              width: 14,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "取消",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
