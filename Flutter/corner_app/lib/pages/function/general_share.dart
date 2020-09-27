import 'package:corner_app/pages/function/general_dialog.dart';
import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GeneralShare extends StatelessWidget {
  kObjectFunctionBlock shareHandle;
  GeneralShare({
    Key key,
    this.shareHandle,
  }) : super(key: key);

  List _baseList = [
    {
      "icon": "images/share_wechat_icon@3x.png",
      "title": "分享给\n微信好友",
      "mark": "wechat",
    },
    {
      "icon": "images/share_wechatzone_icon@3x.png",
      "title": "分享到\n朋友圈",
      "mark": "wechazone",
    },
    {
      "icon": "images/share_weibo_icon@3x.png",
      "title": "分享到\n微博",
      "mark": "weibo",
    },
    {
      "icon": "images/share_qq_icon@3x.png",
      "title": "分享给\nQQ好友",
      "mark": "qq",
    },
    {
      "icon": "images/copy_link_icon@3x.png",
      "title": "分享链接",
      "mark": "sharelink",
    },
  ];

  List _otherList = [
    {
      "icon": "images/report_icon@3x.png",
      "title": "投诉",
      "mark": "report",
    },
  ];

  double _itemWidth = 65.0;
  int _maxRow = 5;

  show(
    BuildContext context, {
    List baseList,
    List otherList,
    int maxRow,
  }) {
    if (baseList != null) {
      _baseList = baseList;
    }

    if (otherList != null) {
      _otherList = otherList;
    }

    if (maxRow != null) {
      _maxRow = maxRow;
    }

    GeneralDialog().show(
      context,
      backgroundPadding: EdgeInsets.zero,
      backgroundAlignment: Alignment.bottomCenter,
      containerContent: this,
      barrierDismissible: true,
      backgroundColor: Color.fromRGBO(0, 0, 0, 0.4),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(6),
        topRight: Radius.circular(6),
      ),
    );
  }

  void _shareItemTap(item, context) {
    Navigator.of(context).pop();

    Future.delayed(Duration(milliseconds: 400), () {
      if (shareHandle != null) {
        shareHandle(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(
        top: 32,
        bottom: MediaQuery.of(context).padding.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 分享
          Container(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
            ),
            child: Text(
              "分享",
              style: TextStyle(
                fontSize: 20,
                color: rgba(50, 50, 50, 1),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: 28,
              bottom: 23,
            ),
            height: 157,
            child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
              ),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    this._shareItemTap(_baseList[index]["mark"], context);
                  },
                  child: Container(
                    width: _itemWidth,
                    child: Column(
                      children: [
                        Image.asset(
                          _baseList[index]["icon"],
                          width: 50.5,
                          height: 50.5,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          _baseList[index]["title"],
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            color: rgba(50, 50, 50, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Container(
                  width: (MediaQuery.of(context).size.width -
                          16 * 2 -
                          _itemWidth * _maxRow) /
                      (_maxRow - 1),
                );
              },
              itemCount: _baseList.length,
            ),
          ),
          _otherList.length > 0
              ? Container(
                  margin: EdgeInsets.only(
                    left: 16,
                    right: 16,
                  ),
                  color: rgba(0, 0, 0, 0.1),
                  height: 0.5,
                )
              : Container(),
          _otherList.length > 0
              ? Container(
                  padding: EdgeInsets.only(
                    top: 28,
                    bottom: 23,
                  ),
                  height: 154,
                  child: ListView.separated(
                    padding: EdgeInsets.only(
                      left: 16,
                      right: 16,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          this._shareItemTap(
                              _otherList[index]["mark"], context);
                        },
                        child: Container(
                          width: _itemWidth,
                          child: Column(
                            children: [
                              Image.asset(
                                _otherList[index]["icon"],
                                width: 50.5,
                                height: 50.5,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                _otherList[index]["title"],
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: rgba(50, 50, 50, 1),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Container(
                        width: (MediaQuery.of(context).size.width -
                                16 * 2 -
                                _itemWidth * _maxRow) /
                            (_maxRow - 1),
                      );
                    },
                    itemCount: _otherList.length,
                  ),
                )
              : Container(),
          // 取消
          Container(
            height: 48,
            color: rgba(247, 246, 245, 0.96),
            width: MediaQuery.of(context).size.width,
            child: FlatButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.of(context).pop();
              },
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
