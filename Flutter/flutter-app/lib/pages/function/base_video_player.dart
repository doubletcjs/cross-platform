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
}

class _BaseVideoPlayerState extends State<BaseVideoPlayer> {
  VideoPlayerController _controller;

  //获取联系方式
  void _getContact() {
    XsProgressHud.show(context);
    MemberApi.getVideo(this.widget.account["id"], (data, msg) {
      if (data != null) {
        setState(() {
          this.widget.videoPath =
              data["videoUrl"] != null ? data["videoUrl"] : "";
          _controller = VideoPlayerController.network(this.widget.videoPath)
            ..initialize().then((_) {
              setState(() {});
            });
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

  @override
  void initState() {
    super.initState();

    if (this.widget.account != null) {
      Future.delayed(Duration(milliseconds: 300), () {
        this._getContact();
      });
    } else {
      _controller = VideoPlayerController.file(File(this.widget.videoPath))
        ..initialize().then((_) {
          setState(() {});
        });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "播放视频",
      ),
      body: (_controller != null && _controller.value.initialized)
          ? Container(
              padding: EdgeInsets.fromLTRB(
                  0,
                  0,
                  0,
                  MediaQuery.of(context).padding.bottom +
                      AppBar().preferredSize.height),
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            )
          : Container(),
      floatingActionButton: ObjectUtil.isEmptyString(this.widget.videoPath)
          ? null
          : FloatingActionButton(
              onPressed: () {
                setState(() {
                  _controller.value.isPlaying
                      ? _controller.pause()
                      : _controller.play();
                });
              },
              child: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
