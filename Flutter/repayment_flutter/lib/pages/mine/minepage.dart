import 'package:flutter/material.dart';
import 'package:repayment_flutter/pages/bill/billrecord.dart';
import 'package:repayment_flutter/pages/mine/feedbackpage.dart';
import 'package:repayment_flutter/pages/mine/setttingpage.dart';
import 'package:repayment_flutter/pages/mine/views/mineheader.dart';
import 'package:repayment_flutter/public/public.dart';

class MinePage extends StatefulWidget {
  MinePage({Key key}) : super(key: key);

  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  List<String> _mineList = ["还款提醒", "账单目录", "意见反馈", "推荐给好友", "设置"];
  int _notifications = -1;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        transparentAppBar(brightness: Brightness.light),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            MineHeader(),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                itemBuilder: (context, index) {
                  return buttonWidget(
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 12, 0),
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: 44,
                            child: index == 0
                                ? Image.asset(
                                    "images/icon_me_news.png",
                                    width: 21,
                                    height: 20,
                                  )
                                : index == 1
                                    ? Image.asset(
                                        "images/icon_loan_record.png",
                                        width: 21,
                                        height: 21,
                                      )
                                    : index == 2
                                        ? Image.asset(
                                            "images/icon_feedback.png",
                                            width: 21,
                                            height: 21,
                                          )
                                        : index == 3
                                            ? Image.asset(
                                                "images/icon_invite.png",
                                                width: 21,
                                                height: 21,
                                              )
                                            : index == 4
                                                ? Image.asset(
                                                    "images/icon_setting.png",
                                                    width: 21,
                                                    height: 21,
                                                  )
                                                : Container(),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  _mineList[index],
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      index == 0
                                          ? Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 5, 0),
                                              child: Text(_notifications == -1
                                                  ? "登录后开启"
                                                  : _notifications == 1
                                                      ? "开启"
                                                      : "关闭"),
                                            )
                                          : Container(),
                                      index == 0
                                          ? Switch(
                                              value: _notifications == -1
                                                  ? false
                                                  : _notifications == 1
                                                      ? true
                                                      : false,
                                              onChanged: _notifications == -1
                                                  ? null
                                                  : (isOn) {
                                                      setState(() {
                                                        if (_notifications ==
                                                            1) {
                                                          _notifications = 0;
                                                        } else {
                                                          _notifications = 1;
                                                        }
                                                      });
                                                    },
                                            )
                                          : Image.asset(
                                              "images/icon_arrow_right.png",
                                              fit: BoxFit.fitWidth,
                                              width: 8,
                                            ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    context,
                    loginIntercept: index == 1 ? true : false,
                    onTap: index == 0
                        ? null
                        : () {
                            if (index == 1) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return BillRecordPage();
                                  },
                                ),
                              );
                            } else if (index == 2) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return FeedbackPage();
                                  },
                                ),
                              );
                            } else if (index == 3) {
                            } else if (index == 4) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return SettingPage();
                                  },
                                ),
                              );
                            }
                          },
                    color: Colors.white,
                  );
                },
                separatorBuilder: (context, index) {
                  return Container(
                    height: index == 1 ? 10 : 1,
                    child: index == 1
                        ? Container()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 44,
                                color: Colors.white,
                              ),
                              Expanded(
                                child: Container(),
                              ),
                            ],
                          ),
                  );
                },
                itemCount: _mineList.length,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
