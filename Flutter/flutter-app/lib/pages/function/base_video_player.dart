import 'dart:io';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';
import '../../public/public.dart';
import '../mine/api/member_api.dart';

class BaseVideoPlayer extends StatefulWidget {
  String videoPath = "";
  Map account;
  BaseVideoPlayer({
    Key key,
    this.videoPath = "",
    this.account,
  }) : super(key: key);

  @override
  _BaseVideoPlayerState createState() => _BaseVideoPlayerState();

  void animatedPush(BuildContext context) {
    Navigator.of(context).push(
      FadeRoute(
        page: this,
      ),
    );
  }
}

class _BaseVideoPlayerState extends State<BaseVideoPlayer> {
  VideoPlayerController _controller;
  int _loadingStatus = 0; // 0 加载中 1 成功 2 失败

  //获取联系方式
  void _getContact() {
    XsProgressHud.show(context);
    MemberApi.getVideo(this.widget.account["id"], (data, msg) {
      if (data != null) {
        setState(() {
          this.widget.videoPath =
              data["videoUrl"] != null ? data["videoUrl"] : "";
          this._initPlayerController(this.widget.videoPath);
        });
        Future.delayed(Duration(milliseconds: 600), () {
          XsProgressHud.hide();
        });
      } else {
        XsProgressHud.hide();
        showToast(msg, context);
      }
    });
  }

  //初始化播放器
  void _initPlayerController(path) {
    void _didLoadVideo() {
      setState(() {
        _controller.play();
        _loadingStatus = 1;
      });
    }

    if (_controller != null) {
      _controller.removeListener(() {});
      _controller.dispose();
      _controller = null;

      setState(() {
        _loadingStatus = 0;
      });
    }

    if (path.contains("http")) {
      _controller = VideoPlayerController.network(path)
        ..initialize().then((_) {
          _didLoadVideo();
        }).catchError((error) {
          showToast("$error", context);
          setState(() {
            _loadingStatus = 2;
          });
        });
    } else {
      _controller = VideoPlayerController.file(File(path))
        ..initialize().then((_) {
          _didLoadVideo();
        }).catchError((error) {
          showToast("$error", context);
          setState(() {
            _loadingStatus = 2;
          });
        });
    }

    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();

    if (this.widget.account != null) {
      Future.delayed(Duration(milliseconds: 300), () {
        this._getContact();
      });
    } else {
      if (ObjectUtil.isEmptyString(this.widget.videoPath) == false) {
        this._initPlayerController(this.widget.videoPath);
      } else {
        this._initPlayerController("");
      }
    }
  }

  @override
  void dispose() {
    _controller.removeListener(() {});
    _controller.dispose();
    _controller = null;

    super.dispose();
    kLog("dispose");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.black,
              child: (_controller != null && _controller.value.initialized)
                  ? Container(
                      margin: EdgeInsets.fromLTRB(
                          0,
                          MediaQuery.of(context).padding.top,
                          0,
                          MediaQuery.of(context).padding.bottom),
                      child: AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      ),
                    )
                  : Container(),
            ),
          ),
          // 关闭
          Positioned(
            top: MediaQuery.of(context).padding.top,
            right: 0,
            width: 66,
            height: 66,
            child: FlatButton(
              color: Colors.black12,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.close,
                color: Colors.white,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(66 / 2),
              ),
            ),
          ),
          //加载中
          _loadingStatus == 0
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : _loadingStatus == 2
                  ? Center(
                      child: Text(
                        "视频加载失败！",
                      ),
                    )
                  : Positioned(
                      bottom: MediaQuery.of(context).padding.bottom,
                      left: 0,
                      right: 0,
                      child: Container(
                        color: Colors.black26,
                        height: 44,
                        padding: EdgeInsets.fromLTRB(12, 0, 24, 0),
                        child: Row(
                          children: [
                            //暂停、播放
                            IconButton(
                              icon: Icon(
                                _controller.value.isPlaying
                                    ? Icons.pause_circle_outline
                                    : Icons.play_circle_outline,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                if (_controller.value.isPlaying) {
                                  _controller.pause();
                                } else {
                                  _controller.seekTo(Duration(milliseconds: 0));
                                  _controller.play();
                                }
                              },
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            //进度条
                            Expanded(
                              child: LinearProgressIndicator(
                                value: _controller
                                        .value.position.inMilliseconds /
                                    _controller.value.duration.inMilliseconds,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
        ],
      ),
    );
  }
}
