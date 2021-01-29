import 'dart:ui';

import 'package:diary_mood/pages/mine/feedback_page.dart';
import 'package:diary_mood/pages/mine/login_register.dart';
import 'package:diary_mood/public/public.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class MineTabPage extends StatefulWidget {
  MineTabPage({Key key}) : super(key: key);

  @override
  _MineTabPageState createState() => _MineTabPageState();
}

class _MineTabPageState extends State<MineTabPage> {
  List<String> _dataList = ["意见反馈", "用户协议", "隐私政策", ""];

// 登录、注册
  void _loginRegister() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return LoginRegisterPage();
      }),
    );
  }

  // 意见反馈
  void _feedback() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return FeedBackPage();
      }),
    );
  }

  @override
  void initState() {
    super.initState();

    PackageInfo.fromPlatform().then((PackageInfo info) {
      _dataList[3] = "v" + info.version + " build " + info.buildNumber;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          expandedHeight: 250.0,
          flexibleSpace: FlexibleSpaceBar(
            title: Text("登录"),
            background: InkWell(
              onTap: () {
                this._loginRegister();
              },
              child: Stack(
                children: [
                  //约束性盒子
                  ConstrainedBox(
                    constraints: BoxConstraints.expand(),
                    child: extendedNetworkImage(
                      "",
                      null,
                      BorderRadius.zero,
                    ),
                  ),
                  // 磨砂玻璃
                  Center(
                    //可裁切的矩形
                    child: ClipRect(
                      //背景过滤器
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                        child: Opacity(
                          opacity: 0.3,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: extendedNetworkImage(
                      "",
                      Size(100, 100),
                      BorderRadius.circular(100 / 2),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        //List
        SliverFixedExtentList(
          itemExtent: 54,
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return ListTile(
                title: Text(
                  _dataList[index],
                  textAlign: index == _dataList.length - 1
                      ? TextAlign.center
                      : TextAlign.left,
                ),
                onTap: () {
                  if (_dataList[index] == "意见反馈") {
                    this._feedback();
                  }
                },
                trailing: index == _dataList.length - 1
                    ? null
                    : Icon(Icons.chevron_right),
              );
            },
            childCount: _dataList.length,
          ),
        ),
      ],
    );
  }
}
