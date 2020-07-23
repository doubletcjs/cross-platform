import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../public/public.dart';

class NearCell extends StatefulWidget {
  NearCell({Key key}) : super(key: key);

  @override
  _NearCellState createState() => _NearCellState();
}

class _NearCellState extends State<NearCell> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(13.5, 20, 14.5, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: <Widget>[
              //头像
              ClipRRect(
                child: CachedNetworkImage(
                  imageUrl:
                      "https://upload.jianshu.io/users/upload_avatars/14072228/980d845b-ffda-4a82-8d4e-67ffe82ad13b?imageMogr2/auto-orient/strip|imageView2/1/w/96/h/96",
                  width: 67,
                  height: 67,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(67 / 2),
              ),
              //认证标志
              Positioned(
                bottom: 0,
                right: 0,
                child: Image.asset(
                  "images/renzheng_icon@3x.png",
                  width: 16,
                  height: 16,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 11,
          ),
          Expanded(
            child: Container(
              height: 70,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          //用户名
                          Expanded(
                            child: Text(
                              "用户名",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 15,
                                color: rgba(18, 18, 18, 1),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          //公里数+上线天数或在线
                          Row(
                            children: <Widget>[
                              Text(
                                "21.45km" + " . " + "在线",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: rgba(170, 170, 170, 1),
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              //是否在线
                              Container(
                                width: 5,
                                height: 5,
                                decoration: BoxDecoration(
                                  color: rgba(29, 211, 110, 1),
                                  borderRadius: BorderRadius.circular(5 / 2),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              //性别 男 rgba(0, 199, 245, 1) 女 rgba(255, 95, 125, 1)
                              Container(
                                padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
                                decoration: BoxDecoration(
                                  color: rgba(255, 95, 125, 1),
                                  borderRadius: BorderRadius.circular(14 / 2),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    //性别图标
                                    Image.asset(
                                      "images/woman@3x.png",
                                      width: 5,
                                      height: 7.5,
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      "30",
                                      style: TextStyle(
                                        fontSize: 9,
                                        color: rgba(255, 255, 255, 1),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              //是否会员
                              Image.asset(
                                "images/member@3x.png",
                                width: 16,
                                height: 16,
                              ),
                            ],
                          ),
                          //绑定平台
                          Row(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                child: Image.asset(
                                  "images/WECHAT@3x.png",
                                  width: 14,
                                  height: 14,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                child: Image.asset(
                                  "images/QQ@3x.png",
                                  width: 14,
                                  height: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    "个性签名",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      color: rgba(144, 144, 144, 1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
