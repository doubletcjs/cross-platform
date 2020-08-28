import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../public/networking.dart';
import '../../public/public.dart';
import 'login_register.dart';
import '../function/base_webview.dart';

class AccountMainPage extends StatefulWidget {
  AccountMainPage({Key key}) : super(key: key);

  @override
  _AccountMainPageState createState() => _AccountMainPageState();
}

class _AccountMainPageState extends State<AccountMainPage> {
  //web浏览器
  void _showWebView(int type) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return BaseWebView(
            url: "${kServerURL + "/page/" + "$type"}",
            title: type == 1 ? "隐私政策" : "用户协议",
          );
        },
      ),
    );
  }

  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    // 视频播放不支持模拟器
    _controller = VideoPlayerController.asset("assets/video-yingyue.mp4")
      ..initialize().then((_) {
        setState(() {
          _controller.setLooping(true);
          _controller.setVolume(0);
          _controller.play();
        });
      }).catchError((error) {
        // showToast("$error", context);
      });
  }

  @override
  void dispose() {
    super.dispose();

    if (_controller != null) {
      _controller.removeListener(() {});
      _controller.dispose();
      _controller = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          transparentAppBar(),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(30, MediaQuery.of(context).padding.top,
                30, (64 + MediaQuery.of(context).padding.bottom)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(
                      // height: 80 - MediaQuery.of(context).padding.top,
                      height: 210 - MediaQuery.of(context).padding.top,
                    ),
                    Image.asset(
                      "images/login_logo@3x.png",
                      width: 110,
                      height: 89,
                    ),
                    // Text(
                    //   "尓蒙",
                    //   style: TextStyle(
                    //     fontSize: 54,
                    //     color: rgba(255, 255, 255, 1),
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "释放你的荷尔蒙",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        color: rgba(255, 255, 255, 1),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    // //注册
                    // Container(
                    //   height: 44,
                    //   width: MediaQuery.of(context).size.width,
                    //   child: FlatButton(
                    //     onPressed: () {
                    //       Navigator.of(context).push(
                    //         MaterialPageRoute(
                    //           builder: (context) {
                    //             return LoginRegisterPage(
                    //               isRegister: true,
                    //             );
                    //           },
                    //         ),
                    //       );
                    //     },
                    //     child: Text(
                    //       "注册",
                    //       style: TextStyle(
                    //         fontSize: 16,
                    //         color: rgba(255, 45, 85, 1),
                    //       ),
                    //     ),
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(44 / 2),
                    //     ),
                    //   ),
                    //   decoration: BoxDecoration(
                    //     color: rgba(255, 255, 255, 1),
                    //     borderRadius: BorderRadius.circular(44 / 2),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    //登录
                    Container(
                      height: 44,
                      width: MediaQuery.of(context).size.width,
                      child: FlatButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return LoginRegisterPage();
                              },
                            ),
                          );
                        },
                        child: Text(
                          "登录",
                          style: TextStyle(
                            fontSize: 16,
                            color: rgba(255, 255, 255, 1),
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(44 / 2),
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(44 / 2),
                        gradient: LinearGradient(
                          colors: [
                            rgba(255, 44, 96, 1),
                            rgba(255, 114, 81, 1),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 47.5,
                    ),
                    //隐私政策
                    Material(
                      color: rgba(0, 0, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "已同意",
                            style: TextStyle(
                              fontSize: 13,
                              color: rgba(204, 204, 204, 1),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              this._showWebView(6);
                            },
                            child: Text(
                              "用户协议",
                              style: TextStyle(
                                fontSize: 13,
                                color: rgba(204, 204, 204, 1),
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          Text(
                            "和",
                            style: TextStyle(
                              fontSize: 13,
                              color: rgba(204, 204, 204, 1),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              this._showWebView(1);
                            },
                            child: Text(
                              "隐私政策",
                              style: TextStyle(
                                fontSize: 13,
                                color: rgba(204, 204, 204, 1),
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            rgba(255, 132, 96, 1),
            rgba(193, 50, 148, 1),
            rgba(59, 48, 220, 1),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}
