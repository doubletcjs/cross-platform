import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomeWrap extends StatefulWidget {
  List dataList;
  HomeWrap({Key key, this.dataList}) : super(key: key);

  @override
  _HomeWrapState createState() => _HomeWrapState();
}

class _HomeWrapState extends State<HomeWrap> {
  @override
  Widget build(BuildContext context) {
    return (this.widget.dataList == null || this.widget.dataList.length == 0)
        ? Container(
            margin: EdgeInsets.fromLTRB(16, 40.5, 16, 58.5),
            child: Column(
              children: [
                Text(
                  "你还未加入角落，赶快去加入吧~",
                  style: TextStyle(
                    color: rgba(153, 153, 153, 1),
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 23.5,
                ),
                Container(
                  height: 36,
                  decoration: BoxDecoration(
                    color: rgba(235, 102, 91, 1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: FlatButton(
                    padding: EdgeInsets.fromLTRB(39.5, 0, 39.5, 0),
                    onPressed: () {},
                    child: Text(
                      "去发现角落",
                      style: TextStyle(
                        color: rgba(255, 255, 255, 1),
                        fontSize: 16,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                )
              ],
            ),
          )
        : Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 60),
            height: 320,
            child: PageView.builder(
              itemBuilder: (context, index) {
                var _length = index * 2 + 2;
                if (_length > this.widget.dataList.length) {
                  _length = this.widget.dataList.length;
                }

                List _list = this.widget.dataList.sublist(index * 2, _length);
                return Container(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Wrap(
                    spacing: 8,
                    alignment: _list.length == 2
                        ? WrapAlignment.center
                        : WrapAlignment.start,
                    direction: Axis.horizontal,
                    children: _list.map((item) {
                      var idx = _list.indexOf(item);
                      var trueIndex = index * 2 + idx;
                      return HomeWrapCell(
                        index: trueIndex,
                      );
                    }).toList(),
                  ),
                );
              },
              itemCount: this.widget.dataList.length % 2 == 0
                  ? (this.widget.dataList.length ~/ 2)
                  : ((this.widget.dataList.length ~/ 2) + 1),
            ),
          );
  }
}

// ignore: must_be_immutable
class HomeWrapCell extends StatefulWidget {
  int index = 0;
  HomeWrapCell({
    Key key,
    this.index = 0,
  }) : super(key: key);

  @override
  _HomeWrapCellState createState() => _HomeWrapCellState();
}

class _HomeWrapCellState extends State<HomeWrapCell> {
  @override
  Widget build(BuildContext context) {
    double _maxWidth = (MediaQuery.of(context).size.width - 16 * 2 - 8) / 2;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        networkImage(
          "",
          Size(_maxWidth, 224),
          BorderRadius.circular(8),
        ),
        SizedBox(
          height: 12,
        ),
        Container(
          width: _maxWidth,
          padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: Text(
            "探寻探寻探寻探寻探寻探寻",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: rgba(50, 50, 50, 1),
              fontSize: 18,
            ),
          ),
        ),
        Container(
          width: _maxWidth,
          padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: Text(
            "落主：羡闲",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: rgba(153, 153, 153, 1),
              fontSize: 13,
            ),
          ),
        ),
        SizedBox(
          height: 2,
        ),
        Container(
          width: _maxWidth,
          padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: Text(
            "每一个制造和享用美食的人无不经历江湖夜雨，期待期待期待期待期待期待",
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(
              color: rgba(1, 152, 117, 1),
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }
}
