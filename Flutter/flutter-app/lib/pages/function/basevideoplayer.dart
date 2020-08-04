import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../public/public.dart';

class BaseVideoPlayer extends StatefulWidget {
  String videoPath = "";
  BaseVideoPlayer({
    Key key,
    this.videoPath = "",
  }) : super(key: key);

  @override
  _BaseVideoPlayerState createState() => _BaseVideoPlayerState();
}

class _BaseVideoPlayerState extends State<BaseVideoPlayer> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(this.widget.videoPath))
      ..initialize().then((_) {
        setState(() {});
      });
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
      body: Center(
        child: _controller.value.initialized
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
      ),
      floatingActionButton: FloatingActionButton(
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
    );
  }
}
