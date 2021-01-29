import 'dart:ui';

import 'package:diary_mood/pages/mine/login_register.dart';
import 'package:diary_mood/public/public.dart';
import 'package:flutter/material.dart';

class MineTabPage extends StatefulWidget {
  MineTabPage({Key key}) : super(key: key);

  @override
  _MineTabPageState createState() => _MineTabPageState();
}

class _MineTabPageState extends State<MineTabPage> {
// 登录、注册
  void _loginRegister() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return LoginRegisterPage();
      }),
    );
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
                title: Text('list item $index'),
                onTap: () {},
              );
            },
            childCount: 0,
          ),
        ),
      ],
    );
  }
}
