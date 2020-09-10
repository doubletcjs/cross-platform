import 'package:corner_app/pages/function/general_dialog.dart';
import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StoreDynamicPost extends StatelessWidget {
  kObjectFunctionBlock tapHandle;
  StoreDynamicPost({
    Key key,
    this.tapHandle,
  }) : super(key: key);

  List _postItemList = [
    {
      "name": "照片",
      "icon": "images/dynamic_post_photo@3x.png",
      "mark": "photo",
    },
    {
      "name": "视频",
      "icon": "images/dynamic_post_video@3x.png",
      "mark": "video",
    },
    {
      "name": "直播",
      "icon": "images/dynamic_post_live@3x.png",
      "mark": "live",
    },
  ];

  show(BuildContext context) {
    GeneralDialog().show(
      context,
      backgroundPadding: EdgeInsets.zero,
      backgroundAlignment: Alignment.bottomCenter,
      containerContent: this,
      barrierDismissible: true,
      backgroundColor: Color.fromRGBO(0, 0, 0, 0.4),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(
        top: 28,
        bottom: MediaQuery.of(context).padding.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 发布
          Container(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
            ),
            child: Text(
              "发布",
              style: TextStyle(
                fontSize: 20,
                color: rgba(50, 50, 50, 1),
              ),
            ),
          ),
          Container(
            height: 351.5,
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: 38,
              bottom: 38,
            ),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _postItemList.map((item) {
                    return InkWell(
                      onTap: () {
                        if (tapHandle != null) {
                          tapHandle(item["mark"]);
                        }

                        Navigator.of(context).pop();
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            item["icon"],
                            width: 72,
                            height: 72,
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            item["name"],
                            style: TextStyle(
                              fontSize: 16,
                              color: rgba(50, 50, 50, 1),
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          // 取消
          Container(
            height: 48,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: rgba(247, 246, 245, 1),
              borderRadius: BorderRadius.circular(4),
            ),
            margin: EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 44.5,
            ),
            child: FlatButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.of(context).pop();
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                "取消",
                style: TextStyle(
                  fontSize: 18,
                  color: rgba(50, 50, 50, 1),
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
