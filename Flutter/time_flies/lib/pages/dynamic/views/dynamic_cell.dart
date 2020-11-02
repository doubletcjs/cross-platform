import 'package:flutter/material.dart';
import 'package:time_flies/function/report_alert.dart';
import 'package:time_flies/pages/home/home_page.dart';
import 'package:time_flies/function/photo_gallery.dart';
import 'package:time_flies/public/public.dart';

// ignore: must_be_immutable
class DynamicBaseCell extends StatefulWidget {
  Map dynamic;
  DynamicBaseCell({
    Key key,
    @required this.dynamic,
  }) : super(key: key);

  @override
  _DynamicCellState createState() => _DynamicCellState();
}

class _DynamicCellState extends State<DynamicBaseCell> {
  List _imageList = [
    "http://static.zuimeia.com/product/img/banner_locker.jpg",
  ];
  List _topicList = [
    "话题话题1",
    "话题2",
    "话题3",
  ];

  //更多
  void _moreAction(BuildContext context) {
    ReportAlert(
      itemHandle: (item) {
        Future.delayed(Duration(milliseconds: 300), () {
          if (item == "举报") {}
        });
      },
      reportItems: [
        "举报",
        "取消",
      ],
    ).show(context);
  }

  // 主页
  void _goHomePage() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return HomePage();
      }),
    );
  }

  // 图片展示
  Widget _imageGallery(BuildContext context) {
    if (_imageList.length == 0) {
      return Container();
    }

    double _imageWidth = 78;
    double _imageHeight = 78;
    if (_imageList.length == 1) {
      // w / h = 160.5 / x
      double _width = 267;
      double _height = 678;
      double _maxImageHeight = (160.5 * 4) / 3; // 4/3 = x/160.5
      _imageWidth = 160.5;
      _imageHeight = (_imageWidth * _height) / _width;
      if (_imageHeight > _maxImageHeight) {
        _imageHeight = _maxImageHeight;
      }

      return Container(
        margin: EdgeInsets.only(
          top: 9,
        ),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              FadeRoute(
                page: PhotoViewGalleryScreen(
                  images: _imageList, //传入图片list
                  index: 0, //传入当前点击的图片的index
                ),
              ),
            );
          },
          child: networkImage(
            _imageList[0],
            Size(_imageWidth, _imageHeight),
            BorderRadius.circular(0),
          ),
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(
          top: 9,
        ),
        width: _imageList.length == 4
            ? (_imageWidth * 2 + 4.5)
            : (_imageWidth * 3 + 4.5 * 2),
        child: GridView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: _imageList.length == 4 ? 2 : 3,
            crossAxisSpacing: 4.5,
            mainAxisSpacing: 4.5,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.of(context).push(
                  FadeRoute(
                    page: PhotoViewGalleryScreen(
                      images: _imageList, //传入图片list
                      index: index, //传入当前点击的图片的index
                    ),
                  ),
                );
              },
              child: networkImage(
                _imageList[index],
                Size(_imageWidth, _imageHeight),
                BorderRadius.circular(0),
              ),
            );
          },
          itemCount: _imageList.length,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 头像
                  InkWell(
                    onTap: () {
                      this._goHomePage();
                    },
                    child: networkImage(
                      "",
                      Size(45, 45),
                      BorderRadius.circular(45 / 2),
                    ),
                    borderRadius: BorderRadius.circular(45 / 2),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 用户名
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: 240,
                          ),
                          child: InkWell(
                            onTap: () {
                              this._goHomePage();
                            },
                            child: Text(
                              "优雅知性之心的人",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 18,
                                color: rgba(18, 18, 18, 1),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2.5,
                        ),
                        // 时间
                        Text(
                          "1小时前",
                          style: TextStyle(
                            fontSize: 11,
                            color: rgba(170, 170, 170, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 12,
            ),
            // 更多
            Container(
              width: 30,
              height: 30,
              child: FlatButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  this._moreAction(context);
                },
                child: Icon(
                  Icons.more_horiz,
                  size: 30,
                  color: rgba(170, 170, 170, 1),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 14.5,
        ),
        // 内容文字
        Text(
          "给生活一个微笑😊 Have a good day！",
          style: TextStyle(
            fontSize: 14,
            color: rgba(34, 34, 34, 1),
          ),
        ),
        // 内容图片
        this._imageGallery(context),
        SizedBox(
          height: 12.5,
        ),
        // 底部栏
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                height: 23.5,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Row(
                      children: _topicList.map((topic) {
                        var index = _topicList.indexOf(topic);
                        return Container(
                          margin: EdgeInsets.only(
                            right: index == _topicList.length - 1 ? 0 : 8,
                          ),
                          decoration: BoxDecoration(
                            color: rgba(234, 236, 240, 1),
                            borderRadius: BorderRadius.circular(11.75),
                          ),
                          child: FlatButton(
                            minWidth: 0,
                            padding: EdgeInsets.fromLTRB(8, 4, 7.5, 4.5),
                            onPressed: () {},
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(11.75),
                            ),
                            child: Text(
                              "#" + topic,
                              style: TextStyle(
                                fontSize: 11,
                                color: rgba(0, 0, 0, 1),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    // 话题
                    SizedBox(
                      width: 10,
                    ),
                    // 位置
                    InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          Image.asset(
                            "images/dynamic_dingwei@3x.png",
                            width: 13.5,
                            height: 15.5,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            "北京市",
                            style: TextStyle(
                              fontSize: 11,
                              color: rgba(76, 76, 76, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 16,
            ), // 点赞、评论数
            Row(
              children: [
                // 点赞
                InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      Image.asset(
                        "images/dynamic_dianzan_sel@3x.png",
                        width: 16,
                        height: 14,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "1.4万",
                        style: TextStyle(
                          fontSize: 13,
                          color: rgba(99, 99, 99, 1),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 25,
                ),
                // 评论
                InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      Image.asset(
                        "images/dynamic_comment@3x.png",
                        width: 16,
                        height: 14,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "1080",
                        style: TextStyle(
                          fontSize: 13,
                          color: rgba(99, 99, 99, 1),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
