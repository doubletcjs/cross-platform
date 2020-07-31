import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../public/public.dart';
import '../../certification.dart';
import '../../../function/generalalert.dart';

class CoverHeader extends StatefulWidget {
  bool isSelf = false; //是否查看本人主页
  Map account;
  CoverHeader({
    Key key,
    this.isSelf = false,
    this.account,
  }) : super(key: key);

  @override
  _CoverHeaderState createState() => _CoverHeaderState();
}

class _CoverHeaderState extends State<CoverHeader> {
  int _currentIndex = 0; //当前封面index

  //查看视频认证
  void _showVideoCertification() {
    GeneralAlert(
      title: "查看视频需要花费5金币",
      content: "对方还没有喜欢你，查看视频要5金币\n相互喜欢的人查看不需要金币",
      confirm: "查看视频",
      cancel: "不看了",
      confirmHandle: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return CertificationPage();
          }),
        );
      },
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        //当前封面
        CachedNetworkImage(
          placeholder: (context, url) {
            return Image.asset(
              "images/placeholder_mini@3x.png",
              width: MediaQuery.of(context).size.width,
              height: 375,
              fit: BoxFit.cover,
            );
          },
          imageUrl: this.widget.account["photo"][_currentIndex],
          width: MediaQuery.of(context).size.width,
          height: 375,
          fit: BoxFit.cover,
        ),
        // Image.asset(
        //   "images/placeholder@3x.png",
        //   fit: BoxFit.cover,
        //   width: MediaQuery.of(context).size.width,
        //   height: 375,
        // ),
        //封面列表
        Positioned(
          left: 0,
          right: 0,
          bottom: 16,
          height: 37,
          child: Row(
            children: <Widget>[
              //封面列表
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 37,
                      height: 37,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          width: 1,
                          color: index == _currentIndex
                              ? rgba(255, 255, 255, 1)
                              : rgba(0, 0, 0, 0),
                        ),
                      ),
                      child: Stack(
                        children: <Widget>[
                          ClipRRect(
                            child: CachedNetworkImage(
                              placeholder: (context, url) {
                                return Image.asset(
                                  "images/placeholder_mini@3x.png",
                                  width: 37,
                                  height: 37,
                                  fit: BoxFit.cover,
                                );
                              },
                              imageUrl: this.widget.account["photo"][index],
                              width: 37,
                              height: 37,
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          FlatButton(
                            onPressed: () {
                              setState(() {
                                _currentIndex = index;
                              });
                            },
                            child: Container(),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Container(
                      width: 5.5,
                      height: 37,
                    );
                  },
                  itemCount: this.widget.account["photo"].length,
                ),
              ),
              //非本人查看视频认证
              this.widget.isSelf == false
                  ? Container(
                      margin: EdgeInsets.fromLTRB(12, 0, 8, 0),
                      width: 108,
                      height: 26,
                      child: FlatButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          this._showVideoCertification();
                        },
                        child: Image.asset("images/video_certification@3x.png"),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ],
    );
  }
}
