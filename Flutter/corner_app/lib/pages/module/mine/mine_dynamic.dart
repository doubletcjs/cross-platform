import 'package:corner_app/pages/module/mine/views/mine_dynamic_cell.dart';
import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// ignore: must_be_immutable
class MineDynamic extends StatefulWidget {
  int tab = 0;
  MineDynamic({
    Key key,
    this.tab = 0,
  }) : super(key: key);

  _MineDynamicState state = _MineDynamicState();

  @override
  _MineDynamicState createState() {
    return state;
  }
}

class _MineDynamicState extends State<MineDynamic>
    with AutomaticKeepAliveClientMixin {
  List _dynamicList = [
    {
      "title": "视频标题",
      "isVedio": true,
      "cover": "",
      "object": {"width": 335, "height": 424, "url": ""},
      "account": {"name": "是凉白开鸭是凉白开鸭", "avatar": ""},
      "likeCount": 123,
      "isLike": false,
    },
    {
      "title": "文章标题最多不可以超过20个字符超这显示…",
      "isVedio": false,
      "cover": "",
      "object": {"width": 335, "height": 250, "url": ""},
      "account": {"name": "是凉白开鸭", "avatar": ""},
      "likeCount": 4123,
      "isLike": true,
    },
    {
      "title": "文章标题最多不可以超过20个字符超这显示…",
      "isVedio": false,
      "cover": "",
      "object": {"width": 335, "height": 250, "url": ""},
      "account": {"name": "是凉白开鸭是凉白开鸭", "avatar": ""},
      "likeCount": 6123,
      "isLike": false,
    },
    {
      "title": "文章标题",
      "isVedio": false,
      "cover": "",
      "object": {"width": 335, "height": 424, "url": ""},
      "account": {"name": "是凉白开鸭是凉白开鸭", "avatar": ""},
      "likeCount": 1123,
      "isLike": false,
    },
    {
      "title": "视频标题aaa",
      "isVedio": true,
      "cover": "",
      "object": {"width": 335, "height": 250, "url": ""},
      "account": {"name": "是凉白开鸭…", "avatar": ""},
      "likeCount": 8123,
      "isLike": false,
    },
    {
      "title": "视频标题aaa",
      "isVedio": true,
      "cover": "",
      "object": {"width": 335, "height": 250, "url": ""},
      "account": {"name": "是凉白开鸭…", "avatar": ""},
      "likeCount": 8123,
      "isLike": false,
    },
    {
      "title": "视频标题aaa",
      "isVedio": true,
      "cover": "",
      "object": {"width": 335, "height": 250, "url": ""},
      "account": {"name": "是凉白开鸭…", "avatar": ""},
      "likeCount": 8123,
      "isLike": false,
    },
  ];

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.separated(
      padding: EdgeInsets.only(
        bottom: 48 + 44.0,
      ),
      itemBuilder: (context, index) {
        return Container(
          height: 55,
          child: InkWell(
            onTap: () {},
            child: Text("$index"),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Container(
          height: 1,
          color: Colors.red,
        );
      },
      itemCount: 20,
    );
    // return ListView(
    //   shrinkWrap: true,
    //   physics: NeverScrollableScrollPhysics(),
    //   padding: EdgeInsets.zero,
    //   children: [
    //     Container(
    //       color: rgba(247, 246, 245, 1),
    //       padding: EdgeInsets.only(
    //         left: 16,
    //         right: 16,
    //         bottom: 0,
    //         top: 0,
    //       ),
    //       child: CustomScrollView(
    //         shrinkWrap: true,
    //         // primary: false,
    //         physics: NeverScrollableScrollPhysics(),
    //         slivers: [
    //           SliverStaggeredGrid.countBuilder(
    //             crossAxisCount: 2,
    //             mainAxisSpacing: 8,
    //             crossAxisSpacing: 8,
    //             staggeredTileBuilder: (index) {
    //               return StaggeredTile.fit(1);
    //             },
    //             itemBuilder: (context, index) {
    //               kLog("TAB:${this.widget.tab}");
    //               var dynamic = _dynamicList[index];
    //               return MineDynamicCell(
    //                 dynamic: dynamic,
    //                 isDraft: this.widget.tab == 1 ? true : false,
    //               );
    //             },
    //             itemCount: _dynamicList.length,
    //           ),
    //         ],
    //       ),
    //     ),
    //   ],
    // );
  }
}
