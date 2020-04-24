import 'package:flutter/material.dart';
import 'package:ideaclass/pages/course/views/catalog/coursecatalogcell.dart';

class CourseCatalogPage extends StatefulWidget {
  List courseCatalogs;
  CourseCatalogPage({this.courseCatalogs});

  @override
  _CourseCatalogPageState createState() => _CourseCatalogPageState();
}

class _CourseCatalogPageState extends State<CourseCatalogPage> {
  @override
  void initState() {
    super.initState();
/*
    var videoUrl = "";
    if (_dataList.length > 0 && _dataList[0]["videoUrl"] != null) {
      videoUrl = _dataList[0]["videoUrl"];
      if (isStringEmpty(videoUrl) == false) {
        _videoPlayerController = VideoPlayerController.network("$videoUrl")
          ..initialize().then(
            (_) {
              setState(() {});
            },
          );
      }
    }
    */
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return CourseCatalogCell(
          catalog: this.widget.courseCatalogs[index],
          index: index,
        );
      },
      itemCount: this.widget.courseCatalogs.length,
    );
  }
}
