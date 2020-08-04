import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';
import '../../public/public.dart';
import '../../public/public.dart';
import 'views/homepage/coverheader.dart';
import 'views/homepage/infocontent.dart';
import 'views/homepage/infoheader.dart';
import 'views/homepage/memberalert.dart';
import 'views/homepage/reportalert.dart';
import 'mineinfopage.dart';
import '../account/api/accountapi.dart';

class MineHomePage extends StatefulWidget {
  String userid = ""; //是否查看本人主页
  MineHomePage({
    Key key,
    this.userid = "",
  }) : super(key: key);

  @override
  _MineHomePageState createState() => _MineHomePageState();
}

class _MineHomePageState extends State<MineHomePage> {
  //点赞
  void _likeAction() {}

  //聊天
  void _goChart() {
    MemberAlert().show(context);
  }

  //编辑用户信息
  void _editInfo() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return MineInfoPage();
      }),
    );
  }

  //举报
  void _reportUser() {
    ReportAlert().show(context);
  }

  //获取用户信息
  Map _account;
  void _refreshAccount() {
    AccountApi.profile((data, msg) {
      if (data != null) {
        setState(() {
          _account = Map.from(data);
        });
      } else {
        showToast(msg, context);
      }
    });
  }

  void _refreshOtherAccount() {
    XsProgressHud.show(context);
    AccountApi.otherProfile(this.widget.userid, (data, msg) {
      XsProgressHud.hide();
      if (data != null) {
        setState(() {
          _account = Map.from(data);
        });
      } else {
        showToast(msg, context);
      }
    });
  }

  @override
  void initState() {
    super.initState();

    if (ObjectUtil.isEmptyString(this.widget.userid) == true) {
      setState(() {
        _account = currentAcctount;
      });

      Future.delayed(Duration(milliseconds: 400), () {
        this._refreshAccount();
      });

      kLog("当前登录用户信息");
    } else {
      Future.delayed(Duration(milliseconds: 400), () {
        this._refreshOtherAccount();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      body: Stack(
        children: <Widget>[
          transparentAppBar(),
          ListView(
            padding: EdgeInsets.fromLTRB(
                0,
                0,
                0,
                ObjectUtil.isEmptyString(this.widget.userid) == true
                    ? 0
                    : (94 + MediaQuery.of(context).padding.bottom)),
            children: <Widget>[
              //封面
              _account == null
                  ? Container()
                  : CoverHeader(
                      isSelf: ObjectUtil.isEmptyString(this.widget.userid),
                      account: _account,
                    ),
              //账户信息
              _account == null
                  ? Container()
                  : InfoHeader(
                      isSelf: ObjectUtil.isEmptyString(this.widget.userid),
                      account: _account,
                    ),
              //用户信息
              _account == null
                  ? Container()
                  : InfoContent(
                      account: _account,
                    ),
            ],
          ),
          //返回按钮
          Positioned(
            top: MediaQuery.of(context).padding.top,
            child: Container(
              width: AppBar().preferredSize.height,
              height: AppBar().preferredSize.height,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(AppBar().preferredSize.height / 2),
              ),
              child: FlatButton(
                padding: EdgeInsets.zero,
                child: Image.asset(
                  "images/home_page_back@3x.png",
                  width: 29,
                  height: 29,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(AppBar().preferredSize.height / 2),
                ),
              ),
            ),
          ),
          //更多按钮（本人编辑按钮）
          ObjectUtil.isEmptyString(this.widget.userid)
              ? Positioned(
                  top: MediaQuery.of(context).padding.top,
                  right: 15,
                  child: Container(
                    width: AppBar().preferredSize.height,
                    height: AppBar().preferredSize.height,
                    child: Center(
                      child: Container(
                        width: 54,
                        height: 27,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              rgba(255, 44, 96, 1),
                              rgba(255, 114, 81, 1)
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerLeft,
                          ),
                          borderRadius: BorderRadius.circular(27 / 2),
                        ),
                        child: FlatButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            this._editInfo();
                          },
                          child: Text(
                            "编辑",
                            style: TextStyle(
                              color: rgba(255, 255, 255, 1),
                              fontSize: 13,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(27 / 2),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : Positioned(
                  top: MediaQuery.of(context).padding.top,
                  right: 0,
                  child: Container(
                    width: AppBar().preferredSize.height,
                    height: AppBar().preferredSize.height,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          AppBar().preferredSize.height / 2),
                    ),
                    child: FlatButton(
                      padding: EdgeInsets.zero,
                      child: Image.asset(
                        "images/home_page_more@3x.png",
                        width: 29,
                        height: 29,
                      ),
                      onPressed: () {
                        this._reportUser();
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            AppBar().preferredSize.height / 2),
                      ),
                    ),
                  ),
                ),
          ObjectUtil.isEmptyString(this.widget.userid)
              ? Container()
              : Positioned(
                  left: 0,
                  right: 0,
                  bottom: MediaQuery.of(context).padding.bottom,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //喜欢 已喜欢 dianzan_sel@3x.png
                      FlatButton(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(94 / 2),
                        ),
                        child: Image.asset(
                          "images/dianzan@3x.png",
                          width: 94,
                          height: 94,
                        ),
                        onPressed: () {
                          this._likeAction();
                        },
                      ),
                      SizedBox(
                        width: 46,
                      ),
                      //聊天
                      FlatButton(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(94 / 2),
                        ),
                        child: Image.asset(
                          "images/liaotian@3x.png",
                          width: 94,
                          height: 94,
                        ),
                        onPressed: () {
                          this._goChart();
                        },
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
