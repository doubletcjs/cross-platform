import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoViewGalleryScreen extends StatefulWidget {
  List images = [];
  int index = 0;
  String heroTag;
  PageController controller;

  PhotoViewGalleryScreen({
    Key key,
    @required this.images,
    this.index,
    this.controller,
    this.heroTag,
  }) : super(key: key) {
    controller = PageController(initialPage: index);
  }

  @override
  _PhotoViewGalleryScreenState createState() => _PhotoViewGalleryScreenState();
}

class _PhotoViewGalleryScreenState extends State<PhotoViewGalleryScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = this.widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            right: 0,
            child: Container(
              color: Colors.black,
              child: PhotoViewGallery.builder(
                scrollPhysics: const AlwaysScrollableScrollPhysics(),
                builder: (BuildContext context, int index) {
                  return PhotoViewGalleryPageOptions(
                    imageProvider: CachedNetworkImageProvider(
                      this.widget.images[index],
                    ),
                    heroAttributes: (this.widget.heroTag != null &&
                            this.widget.heroTag.isNotEmpty)
                        ? PhotoViewHeroAttributes(tag: this.widget.heroTag)
                        : null,
                  );
                },
                itemCount: this.widget.images.length,
                pageController: this.widget.controller,
                enableRotation: true,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
          ),
          Positioned(
            //图片index显示
            top: MediaQuery.of(context).padding.top + 15,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Text(
                "${_currentIndex + 1}/${this.widget.images.length}",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
          Positioned(
            //右上角关闭按钮
            right: 10,
            top: MediaQuery.of(context).padding.top,
            child: IconButton(
              icon: Icon(
                Icons.close,
                size: 30,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
