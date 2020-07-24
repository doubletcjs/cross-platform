import 'package:flutter/material.dart';
import '../../public/public.dart';
import '../mine/minehomepage.dart';

class ChatMainPage extends StatefulWidget {
  ChatMainPage({Key key}) : super(key: key);

  @override
  _ChatMainPageState createState() => _ChatMainPageState();
}

class _ChatMainPageState extends State<ChatMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rgba(243, 243, 243, 1),
      body: Stack(
        children: <Widget>[
          transparentAppBar(
            brightness: Brightness.light,
          ),
          Column(
            children: <Widget>[
              //自定义导航栏
              Container(
                margin: EdgeInsets.fromLTRB(
                    0, MediaQuery.of(context).padding.top, 0, 0),
                color: rgba(243, 243, 243, 1),
                height: AppBar().preferredSize.height,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    //返回按钮
                    Container(
                      width: AppBar().preferredSize.height,
                      height: AppBar().preferredSize.height,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            AppBar().preferredSize.height / 2),
                      ),
                      child: FlatButton(
                        padding: EdgeInsets.zero,
                        child: Image.asset(
                          "images/Arrow right@3x.png",
                          width: 10,
                          height: 18,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              AppBar().preferredSize.height / 2),
                        ),
                      ),
                    ),
                    //主页按钮
                    Container(
                      width: AppBar().preferredSize.height,
                      height: AppBar().preferredSize.height,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            AppBar().preferredSize.height / 2),
                      ),
                      child: FlatButton(
                        padding: EdgeInsets.zero,
                        child: Image.asset(
                          "images/gerenzhongxin@3x.png",
                          width: 21,
                          height: 21,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) {
                              return MineHomePage();
                            }),
                          );
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              AppBar().preferredSize.height / 2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //聊天内容
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.fromLTRB(0, 0, 0,
                      41 + 16.5 + MediaQuery.of(context).padding.bottom),
                  itemBuilder: (context, index) {
                    return Container(
                      height: 66,
                      decoration: BoxDecoration(
                        color: Colors.amberAccent,
                        border: Border(
                          bottom: BorderSide(
                            width: 1,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      child: Text(
                        "$index",
                      ),
                    );
                  },
                  itemCount: 100,
                ),
              ),
            ],
          ),
          //输入框
          Positioned(
            left: 0,
            bottom: 0,
            right: 0,
            child: Container(
              height: 41 + 16.5 + MediaQuery.of(context).padding.bottom,
              color: Colors.yellow,
            ),
          ),
        ],
      ),
    );
  }
}
