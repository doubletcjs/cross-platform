import 'package:flutter/material.dart';
import '../../public/public.dart';
import 'views/homepage/avatarheader.dart';
import 'views/homepage/infocontent.dart';
import 'views/homepage/infoheader.dart';
import 'views/homepage/memberalert.dart';
import 'views/homepage/reportalert.dart';
import 'mineeditpage.dart';

class MineHomePage extends StatefulWidget {
  MineHomePage({Key key}) : super(key: key);

  @override
  _MineHomePageState createState() => _MineHomePageState();
}

class _MineHomePageState extends State<MineHomePage> {
  bool _isSelf = true;

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
        return MineEditPage();
      }),
    );
  }

  //举报
  void _reportUser() {
    ReportAlert().show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      body: Stack(
        children: <Widget>[
          transparentAppBar(),
          ListView(
            padding: EdgeInsets.fromLTRB(0, 0, 0,
                _isSelf ? 0 : (94 + MediaQuery.of(context).padding.bottom)),
            children: <Widget>[
              AvatarHeader(),
              InfoHeader(),
              InfoContent(),
            ],
          ),
          //返回按钮
          Positioned(
            left: 4,
            top: 8 + MediaQuery.of(context).padding.top,
            width: 44,
            height: 44,
            child: FlatButton(
              padding: EdgeInsets.zero,
              child: Image.asset(
                "images/Arrow left@3x.png",
                width: 10,
                height: 18,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          //更多按钮（本人编辑按钮）
          _isSelf
              ? Positioned(
                  right: 15.5,
                  top: 8 + MediaQuery.of(context).padding.top,
                  width: 54,
                  height: 27,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [rgba(255, 44, 96, 1), rgba(255, 114, 81, 1)],
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
                )
              : Positioned(
                  right: 4,
                  top: 8 + MediaQuery.of(context).padding.top,
                  width: 44,
                  height: 44,
                  child: FlatButton(
                    padding: EdgeInsets.zero,
                    child: Image.asset(
                      "images/Combined Shape@3x.png",
                      width: 20.5,
                      height: 5,
                    ),
                    onPressed: () {
                      this._reportUser();
                    },
                  ),
                ),
          _isSelf
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
