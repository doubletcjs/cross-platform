import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../../../public/public.dart';
import '../../../function/photo_gallery.dart';

class CoverHeader extends StatefulWidget {
  bool isSelf = false; //是否查看本人主页
  Map account;
  kVoidFunctionBlock certificationHandle;
  CoverHeader({
    Key key,
    this.isSelf = false,
    this.account,
    this.certificationHandle,
  }) : super(key: key);

  @override
  _CoverHeaderState createState() => _CoverHeaderState();
}

class _CoverHeaderState extends State<CoverHeader> {
  int _currentIndex = 0; //当前封面index
  SwiperController _swiperController = SwiperController();

  @override
  void dispose() {
    super.dispose();

    if (_swiperController != null) {
      _swiperController.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        //当前封面
        Container(
          height: 375,
          child: Swiper.children(
            controller: _swiperController,
            children: this.widget.account != null &&
                    this.widget.account["photo"] != null
                ? List.from(this.widget.account["photo"]).map((photo) {
                    List _list = List.from(this.widget.account["photo"]);
                    int _index = _list.indexOf(photo);
                    return InkWell(
                      onTap: () {
                        //FadeRoute是自定义的切换过度动画（渐隐渐现） 如果不需要 可以使用默认的MaterialPageRoute
                        Navigator.of(context).push(
                          FadeRoute(
                            page: PhotoViewGalleryScreen(
                              images: _list, //传入图片list
                              index: _index, //传入当前点击的图片的index
                              // heroTag: img, //传入当前点击的图片的hero tag （可选）
                            ),
                          ),
                        );
                      },
                      child: CachedNetworkImage(
                        placeholder: (context, url) {
                          return Image.asset(
                            "images/placeholder_mini@3x.png",
                            width: MediaQuery.of(context).size.width,
                            height: 375,
                            fit: BoxFit.cover,
                          );
                        },
                        imageUrl: photo,
                        width: MediaQuery.of(context).size.width,
                        height: 375,
                        fit: BoxFit.cover,
                      ),
                    );
                  }).toList()
                : [],
            autoplay: true,
            autoplayDelay: 5000,
            onIndexChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        //封面列表
        Positioned(
          left: 0,
          right: 0,
          bottom: 16,
          height: 37,
          child: Row(
            children: <Widget>[
              //封面列表
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 37,
                      height: 37,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          width: 1,
                          color: index == _currentIndex
                              ? rgba(255, 255, 255, 1)
                              : rgba(0, 0, 0, 0),
                        ),
                      ),
                      child: Stack(
                        children: <Widget>[
                          ClipRRect(
                            child: CachedNetworkImage(
                              placeholder: (context, url) {
                                return Image.asset(
                                  "images/placeholder_mini_grey@3x.png",
                                  width: 37,
                                  height: 37,
                                  fit: BoxFit.cover,
                                );
                              },
                              imageUrl: this.widget.account["photo"][index],
                              width: 37,
                              height: 37,
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          FlatButton(
                            onPressed: () {
                              setState(() {
                                _currentIndex = index;
                                _swiperController.move(index, animation: false);
                              });
                            },
                            child: Container(),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Container(
                      width: 5.5,
                      height: 37,
                    );
                  },
                  itemCount: (this.widget.account != null &&
                          this.widget.account["photo"] != null)
                      ? this.widget.account["photo"].length
                      : 0,
                ),
              ),
              //非本人查看视频认证
              this.widget.isSelf == false
                  ? ((this.widget.account != null &&
                          this.widget.account["audit_status"] != null &&
                          this.widget.account["audit_status"] == 3)
                      ? Container(
                          margin: EdgeInsets.fromLTRB(12, 0, 8, 0),
                          width: 108,
                          height: 26,
                          child: FlatButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              if (this.widget.certificationHandle != null) {
                                this.widget.certificationHandle();
                              }
                            },
                            child: Image.asset(
                                "images/video_certification@3x.png"),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(26 / 2),
                            ),
                          ),
                        )
                      : Container())
                  : Container(),
            ],
          ),
        ),
      ],
    );
  }
}
