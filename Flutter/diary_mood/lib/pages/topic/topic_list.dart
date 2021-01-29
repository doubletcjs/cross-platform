import 'dart:math';

import 'package:diary_mood/public/public.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TopicList extends StatefulWidget {
  kObjectFunctionBlock topicHandle;
  TopicList({
    Key key,
    this.topicHandle,
  }) : super(key: key);

  @override
  _TopicListState createState() => _TopicListState();
}

class _TopicListState extends State<TopicList> {
  TextEditingController _editingController = TextEditingController();
  List _dataList = [
    "",
    "",
    "",
    "",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Expanded(
              child: Container(
                height: 38,
                margin: EdgeInsets.only(left: 15),
                padding: EdgeInsets.only(left: 15, right: 15),
                decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.circular(38 / 2),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _editingController,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 10),
                          hintText: "#",
                          hintStyle: TextStyle(
                            color: rgba(166, 163, 163, 1),
                            fontSize: 16,
                          ),
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                        onChanged: (value) {
                          _dataList.clear();
                          int count = Random().nextInt(10 - 5);
                          for (var i = 0; i < count; i++) {
                            _dataList.add("value");
                          }
                          setState(() {});
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 12),
                      child: FlatButton(
                        padding: EdgeInsets.zero,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        height: 20,
                        minWidth: 0,
                        onPressed: () {
                          _editingController.text = "";
                          setState(() {});
                        },
                        child: Icon(
                          Icons.close,
                          size: 20,
                          color: Colors.black26,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            FlatButton(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: EdgeInsets.only(left: 15, right: 15),
              minWidth: 0,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "取消",
                style: TextStyle(
                  color: rgba(255, 255, 255, 1),
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
        actions: [],
        leading: null,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              "#微博赚钱季#",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            subtitle: Text(
              "讨论 506.0万",
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            onTap: () {
              if (this.widget.topicHandle != null) {
                this.widget.topicHandle({});
              }

              Navigator.of(context).pop();
            },
          );
        },
        itemCount: _dataList.length,
      ),
    );
  }
}
