import 'package:flutter/material.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';
import '../../public/public.dart';
import 'views/homepage/coverheader.dart';
import 'views/homepage/infocontent.dart';
import 'views/homepage/infoheader.dart';
import 'views/homepage/memberalert.dart';
import 'views/homepage/reportalert.dart';
import 'mineinfopage.dart';
import '../account/api/accountapi.dart';

class MineHomePage extends StatefulWidget {
  bool isSelf = false; //是否查看本人主页
  MineHomePage({
    Key key,
    this.isSelf = false,
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
    XsProgressHud.show(context);
    AccountApi.profile((data, msg) {
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

    Future.delayed(Duration(milliseconds: 100), () {
      if (this.widget.isSelf) {
        this._refreshAccount();
      }
    });
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
                this.widget.isSelf
                    ? 0
                    : (94 + MediaQuery.of(context).padding.bottom)),
            children: <Widget>[
              //封面
              _account == null
                  ? Container()
                  : CoverHeader(
                      isSelf: this.widget.isSelf,
                      account: _account,
                    ),
              //账户信息
              _account == null
                  ? Container()
                  : InfoHeader(
                      isSelf: this.widget.isSelf,
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
          this.widget.isSelf
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

          // Positioned(
          //     right: 4,
          //     top: 8 + MediaQuery.of(context).padding.top,
          //     width: 44,
          //     height: 44,
          //     child: FlatButton(
          //       padding: EdgeInsets.zero,
          //       child: Image.asset(
          //         "images/Combined Shape@3x.png",
          //         width: 20.5,
          //         height: 5,
          //       ),
          //       onPressed: () {
          //         this._reportUser();
          //       },
          //     ),
          //   ),
          this.widget.isSelf
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
                      //��天
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
