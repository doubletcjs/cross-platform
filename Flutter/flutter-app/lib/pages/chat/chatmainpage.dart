import 'package:flutter/material.dart';
import '../../public/public.dart';
import '../mine/minehomepage.dart';
import 'views/chatinput.dart';
import 'views/chartmessagecell.dart';

class ChatMainPage extends StatefulWidget {
  ChatMainPage({Key key}) : super(key: key);

  @override
  _ChatMainPageState createState() => _ChatMainPageState();
}

class _ChatMainPageState extends State<ChatMainPage> {
  ScrollController _scrollController = ScrollController();
  ChatInput _chatInput = ChatInput(
    inputHandle: (text) {
      kLog(text);
    },
  );

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      int offset = _scrollController.position.pixels.toInt();
      if (offset != 0) {
        _chatInput.closeChatInput();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
                    15, MediaQuery.of(context).padding.top, 0, 0),
                color: rgba(243, 243, 243, 1),
                height: AppBar().preferredSize.height,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    //返回、未读消息数
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        height: AppBar().preferredSize.height - 6 * 2,
                        child: Row(
                          children: <Widget>[
                            //返回按钮
                            Image.asset(
                              "images/Arrow right@3x.png",
                              width: 10,
                              height: 18,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            //未读消息数
                            Container(
                              padding: EdgeInsets.fromLTRB(7, 2.5, 7, 2.5),
                              child: Text(
                                "9",
                                style: TextStyle(
                                  color: rgba(255, 255, 255, 1),
                                  fontSize: 11,
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: rgba(255, 73, 54, 1),
                                borderRadius: BorderRadius.circular(20 / 2),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          //用户名
                          Text(
                            "Andlina",
                            style: TextStyle(
                              color: rgba(0, 0, 0, 1),
                              fontSize: 18,
                            ),
                          ),
                          //在线状态，距离
                          Text(
                            "30天前    2.70km",
                            style: TextStyle(
                              color: rgba(204, 204, 204, 1),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 8,
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
                  controller: _scrollController,
                  reverse: true,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return ChartMessageCell(
                      type: index % 2 == 0 ? 1 : index % 3 == 0 ? 2 : 0,
                    );
                  },
                  itemCount: 100,
                ),
              ),
              //输入框
              _chatInput,
              SizedBox(
                height: MediaQuery.of(context).padding.bottom,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
