import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MineDynamicCell extends StatefulWidget {
  Map dynamic;
  bool isDraft = false;
  MineDynamicCell({
    Key key,
    @required this.dynamic,
    this.isDraft = false,
  }) : super(key: key);

  @override
  _MineDynamicCellState createState() => _MineDynamicCellState();
}

class _MineDynamicCellState extends State<MineDynamicCell> {
  double _itemWidth = 0.0;
  double _itemHeight() {
    var height = this.widget.dynamic["object"]["height"];
    height = (167.5 * height) / _itemWidth;
    if (height > MediaQuery.of(context).size.height / 2) {
      height = MediaQuery.of(context).size.height / 2;
    }

    return height;
  }

  @override
  Widget build(BuildContext context) {
    if (_itemWidth == 0) {
      setState(() {
        _itemWidth = (MediaQuery.of(context).size.width - 16 * 2 - 8) / 2;
      });
    }

    return this.widget.dynamic == null
        ? Container()
        : Container(
            decoration: BoxDecoration(
              color: rgba(255, 255, 255, 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 封面
                Stack(
                  children: [
                    networkImage(
                      this.widget.dynamic["cover"],
                      Size(
                        _itemWidth,
                        _itemHeight(),
                      ),
                      BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                    ),
                    this.widget.dynamic["isVedio"] == true
                        ? Positioned(
                            top: 15,
                            right: 12,
                            child: Image.asset(
                              "images/icon_me_video@3x.png",
                              width: 28,
                              height: 28,
                            ),
                          )
                        : Container(),
                  ],
                ),
                // 标题
                Container(
                  padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: Text(
                    this.widget.dynamic["title"],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: rgba(50, 50, 50, 1),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // 作者
                      Expanded(
                        child: Row(
                          children: [
                            networkImage(
                              "",
                              Size(18, 18),
                              BorderRadius.circular(18 / 2),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Expanded(
                              child: Text(
                                this.widget.dynamic["account"]["name"],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: rgba(153, 153, 153, 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      // 点赞、删除
                      this.widget.isDraft == true
                          ? InkWell(
                              onTap: () {},
                              child: Image.asset(
                                "images/icon_me_draft_delete@3x.png",
                                width: 16,
                                height: 16,
                              ),
                            )
                          : InkWell(
                              onTap: () {},
                              child: Row(
                                children: [
                                  Image.asset(
                                    "images/mine_dynamic_like@3x.png",
                                    width: 16,
                                    height: 16,
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    "${this.widget.dynamic["likeCount"]}",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: rgba(153, 153, 153, 1),
                                    ),
                                  ),
                                ],
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
