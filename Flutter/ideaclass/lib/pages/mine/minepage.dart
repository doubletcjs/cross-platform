import 'package:flutter/material.dart';
import 'package:ideaclass/pages/account/api/accountapi.dart';
import 'package:ideaclass/pages/mine/views/minecell.dart';
import 'package:ideaclass/pages/mine/views/mineheader.dart';
import 'package:ideaclass/public/public.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MinePage extends StatefulWidget {
  MinePage({Key key}) : super(key: key);

  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  List<String> _mineList = [
    "",
    "我要入驻",
    "我的课程",
    "我的活动",
    "我的收藏",
    "我的钱包",
    "我的银行卡",
    "我的订单",
    "我的点评",
    "我的购物车",
    "我的积分",
    "积分商城",
    "用户专享",
    "学习纪录"
  ];
  List<String> _mineIconList = [
    "jilu@3x.png",
    "jiangshi@3x.png",
    "icon_my_course@3x.png",
    "icon_my_activity@3x.png",
    "jilu@3x.png",
    "wodeqianbao@3x.png",
    "icon_my_bankcard@3x.png",
    "wodedingdan@3x.png",
    "jilu@3x.png",
    "gouwuche@3x.png",
    "jifen@3x.png",
    "jifenshangcheng@3x.png",
    "icon_mypage_exclusive@3x.png",
    "jilu@3x.png"
  ];

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();

    Future.delayed(
      Duration(milliseconds: 200),
      () {
        AccountApi().fetchNewestUser(null, context: context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        transparentAppBar(),
        functionRefresher(
          _refreshController,
          ListView.separated(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
            itemCount: _mineList.length,
            itemBuilder: (context, index) {
              return index == 0
                  ? MineHeader()
                  : MineCell(
                      icon: _mineIconList[index],
                      text: _mineList[index],
                      subText: index == 10
                          ? "看看你有多少积分吧"
                          : index == 11
                              ? "积分可以兑换礼物哦"
                              : index == 12 ? "邀请好友赠积分哦" : "");
            },
            separatorBuilder: (context, index) {
              double separatorHeight = 1;
              if (index == 0 ||
                  index == 1 ||
                  index == 4 ||
                  index == 12 ||
                  index == 13) {
                separatorHeight = 10;
              }

              return Container(
                height: separatorHeight,
              );
            },
          ),
          enableLoadMore: false,
          onRefresh: () {
            AccountApi().fetchNewestUser(
              (msg) {
                if (msg != null) {
                  showToast(msg, context);
                }

                Future.delayed(
                  Duration(milliseconds: 800),
                  () {
                    _refreshController.refreshCompleted();
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }
}
