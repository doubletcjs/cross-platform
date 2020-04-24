import 'package:flutter/material.dart';
import 'package:ideaclass/public/public.dart';

class CourseCatalogCell extends StatefulWidget {
  Map catalog;
  int index = 0;
  CourseCatalogCell({this.catalog, this.index});

  @override
  _CourseCatalogCellState createState() => _CourseCatalogCellState();
}

class _CourseCatalogCellState extends State<CourseCatalogCell> {
  @override
  Widget build(BuildContext context) {
    return this.widget.catalog == null
        ? Container()
        : Container(
            margin:
                EdgeInsets.fromLTRB(0, this.widget.index == 0 ? 8 : 1, 0, 0),
            color: Colors.white,
            child: buttonWidget(
              Container(
                padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 14,
                    ),
                    Image.asset(
                      "images/mulu-shipin@3x.png",
                      width: 16,
                      height: 14,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "第" +
                                "${this.widget.index + 1}" +
                                "课：" +
                                "${this.widget.catalog["title"]}",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              color: rgba(23, 23, 23, 1),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "${this.widget.catalog["duration"]}" + "分钟时长",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 11,
                              color: rgba(181, 181, 181, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 14,
                    ),
                  ],
                ),
              ),
              context,
              onTap: () {},
              color: Colors.white,
            ),
          );
  }
}
