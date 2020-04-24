import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:ideaclass/pages/course/api/courseapi.dart';
import 'package:ideaclass/pages/course/coursecatalog.dart';
import 'package:ideaclass/pages/course/coursecorrelation.dart';
import 'package:ideaclass/pages/course/courseinfo.dart';
import 'package:ideaclass/public/public.dart';
import 'package:video_player/video_player.dart';

class CourseDetailPage extends StatefulWidget {
  String detailID;
  CourseDetailPage({this.detailID = ""});

  @override
  _CourseDetailPageState createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  CourseInfoPage _infoPage = CourseInfoPage();
  CourseCatalogPage _catalogPage = CourseCatalogPage();
  CourseCorrelationPage _correlationPage = CourseCorrelationPage();
  VideoPlayerController _videoPlayerController;
  Future _videoPlayerFuture;

  Map _course;
  List<String> _tabs = ["详情", "目录", "相关"];
  int _currentIndex = 0;
  List<Widget> _tabList() {
    return _tabs.map(
      (tab) {
        int index = _tabs.indexOf(tab);
        return buttonWidget(
          Container(
            width: MediaQuery.of(context).size.width / _tabs.length,
            height: 50,
            alignment: Alignment.center,
            color: Colors.white,
            child: Container(
              height: 50,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Text(
                    tab,
                    style: TextStyle(
                      fontSize: 15,
                      color: index == _currentIndex
                          ? kMainColor
                          : rgba(121, 121, 121, 1),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: 2,
                      color: index == _currentIndex
                          ? kMainColor
                          : rgba(0, 0, 0, 0),
                    ),
                  ),
                ],
              ),
            ),
          ),
          context,
          onTap: () {
            setState(
              () {
                this._currentIndex = index;
              },
            );
          },
        );
      },
    ).toList();
  }

  Widget _bannerSwiper() {
    List _banners = [];
    if (_course["picUrls"] != null) {
      _banners = _course["picUrls"];
    }

    return Swiper(
      itemCount: _banners.length,
      autoplay: true,
      pagination: SwiperPagination(
        builder: DotSwiperPaginationBuilder(
          size: 6,
          activeSize: 6,
          color: Colors.white38,
          activeColor: Colors.white,
          space: 4,
        ),
      ),
      itemBuilder: (context, index) {
        return buttonWidget(
          Image.network(
            _banners[index],
            fit: BoxFit.cover,
          ),
          context,
          onTap: () {},
        );
      },
    );
  }

  Widget _videoView() {
    return Stack(
      children: <Widget>[
        Positioned(
          left: 0,
          top: 0,
          right: 0,
          bottom: 0,
          child: _videoPlayerController == null
              ? Image.network(
                  _course["coverUrl"] == null
                      ? "images/placeholder@3x.png"
                      : _course["coverUrl"],
                  fit: BoxFit.cover,
                )
              : FutureBuilder(
                  future: _videoPlayerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) print(snapshot.error);
                    if (snapshot.connectionState == ConnectionState.done) {
                      return _videoPlayerController.value.isPlaying == false
                          ? Image.network(
                              _course["coverUrl"] == null
                                  ? "images/placeholder@3x.png"
                                  : _course["coverUrl"],
                              fit: BoxFit.cover,
                            )
                          : AspectRatio(
                              aspectRatio:
                                  _videoPlayerController.value.aspectRatio,
                              child: VideoPlayer(_videoPlayerController),
                            );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
        ),
        Center(
          child: buttonWidget(
            Container(
              width: 54,
              height: 54,
              child: Icon(
                _videoPlayerController != null
                    ? (_videoPlayerController.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow)
                    : Icons.play_arrow,
                color: Colors.white,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(54 / 2),
              ),
            ),
            context,
            onTap: () {
              if (_videoPlayerController != null) {
                setState(() {
                  _videoPlayerController.value.isPlaying
                      ? _videoPlayerController.pause()
                      : _videoPlayerController.play();
                });
              }
            },
            color: Colors.black12,
            radius: BorderRadius.circular(54 / 2),
          ),
        )
      ],
    );
  }

  Widget _bottomButton() {
    // 0 不显示 1 可购买(加入购物车|立即抢购) 2 立即学习 3 不可购买
    bool vipFree = (_course["isMember"] != null && _course["isMember"] == 1) &&
        (_course["vipPrice"] != null && _course["vipPrice"] == 0.0);
    int _status = 0;
    if ((_course["isBuy"] != null && _course["isBuy"] == 1) ||
        (_course["isFree"] != null && _course["isFree"] == 1) ||
        vipFree == true) {
      _status = 2;
    } else {
      _status = 1;
    }

    return _status == 0
        ? Container()
        : Container(
            height: 50 + MediaQuery.of(context).padding.bottom,
            alignment: Alignment.topCenter,
            child: _status == 1
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: buttonWidget(
                          Container(
                            height: 50,
                            alignment: Alignment.center,
                            child: Text(
                              "加入购物车",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          context,
                          onTap: () {},
                          color: rgba(89, 186, 245, 1),
                        ),
                      ),
                      Expanded(
                        child: buttonWidget(
                          Container(
                            alignment: Alignment.center,
                            height: 50,
                            child: Text(
                              "立即抢购",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          context,
                          onTap: () {},
                          color: kMainColor,
                        ),
                      ),
                    ],
                  )
                : buttonWidget(
                    Container(
                      height: 50,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              _status == 2
                                  ? "立即学习"
                                  : _status == 3 ? "不可购买" : "",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: _status == 3
                                    ? rgba(136, 136, 136, 1)
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    context,
                    onTap: _status == 3 ? null : () {},
                    color: _status == 2
                        ? kMainColor
                        : _status == 3 ? rgba(181, 181, 181, 1) : Colors.white,
                  ),
          );
  }

  void _refreshCoureData({bool loadHUD = false}) {
    if (loadHUD == true) {
      showHUD();
    }

    CourseApi().getCourseDetail(
      this.widget.detailID,
      (data, msg) {
        hideHUD();
        if (data != null) {
          Future.delayed(
            Duration(milliseconds: 600),
            () {
              setState(
                () {
                  _course = data;
                  _infoPage = CourseInfoPage(
                    course: _course,
                  );
                  _catalogPage = CourseCatalogPage(
                    courseCatalogs: _course["courseCatalogs"],
                  );
                  _correlationPage = CourseCorrelationPage(
                    course: _course,
                  );

                  List _dataList = _course["courseCatalogs"];
                  var videoUrl = "";
                  if (_dataList.length > 0 &&
                      _dataList[0]["videoUrl"] != null) {
                    videoUrl = _dataList[0]["videoUrl"];
                    if (isStringEmpty(videoUrl) == false) {
                      kLog("videoUrl:$videoUrl");
                      _videoPlayerController =
                          VideoPlayerController.network("$videoUrl");
                      _videoPlayerFuture = _videoPlayerController.initialize();
                    }
                  }
                },
              );
            },
          );
        } else {
          showToast(msg, context);
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();

    if (isStringEmpty(this.widget.detailID) == false) {
      this._refreshCoureData(loadHUD: true);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          transparentAppBar(),
          (_course == null || _course.length == 0)
              ? Container()
              : Container(
                  padding: EdgeInsets.fromLTRB(
                    0,
                    0,
                    0,
                    50 + MediaQuery.of(context).padding.bottom,
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        color: kBaseSeparatorColor.withOpacity(0.1),
                        height: 185 + MediaQuery.of(context).padding.top,
                        child: _currentIndex == 0 || _currentIndex == 2
                            ? this._bannerSwiper()
                            : this._videoView(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: this._tabList(),
                      ),
                      Expanded(
                        child: Container(
                          child: _currentIndex == 0
                              ? _infoPage
                              : _currentIndex == 1
                                  ? _catalogPage
                                  : _currentIndex == 2
                                      ? _correlationPage
                                      : Container(),
                        ),
                      ),
                    ],
                  ),
                ),
          Positioned(
            left: 0,
            bottom: 0,
            right: 0,
            child: (_course == null || _course.length == 0)
                ? Container()
                : this._bottomButton(),
          ),
          Positioned(
            left: 7,
            top: MediaQuery.of(context).padding.top,
            width: 44,
            height: 44,
            child: buttonWidget(
              Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              context,
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          Positioned(
            right: 7,
            top: MediaQuery.of(context).padding.top,
            width: 44,
            height: 44,
            child: buttonWidget(
              Icon(
                Icons.share,
                color: Colors.white,
              ),
              context,
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
