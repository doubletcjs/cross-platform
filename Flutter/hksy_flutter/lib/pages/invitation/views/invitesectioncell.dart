import 'package:flutter/material.dart';
import 'package:hksy_flutter/public/public.dart';

class InvitationSection extends StatelessWidget {
  List<Widget> cells = [];
  String title = "";
  String emptyPlaceholder = "";
  InvitationSection(
      {Key key, this.cells, this.title = "", this.emptyPlaceholder = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 35, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              color: rgba(255, 255, 255, 1),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          cells.length > 0
              ? Column(
                  children: cells,
                )
              : Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(0, 40, 0, 90),
                  child: Text(
                    emptyPlaceholder,
                    style: TextStyle(
                      fontSize: 15,
                      color: rgba(145, 152, 173, 1),
                    ),
                  ),
                ),
        ],
      ),
      decoration: BoxDecoration(
        color: rgba(28, 35, 63, 1),
        borderRadius: BorderRadius.circular(7.5),
      ),
    );
  }
}

class InvitationCell extends StatelessWidget {
  bool showLine = true;
  String name = "";
  String value = "";
  String content = "";
  String subcontent = "";
  InvitationCell({
    Key key,
    this.showLine = true,
    this.name = "",
    this.value = "",
    this.content = "",
    this.subcontent = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 25, 0, 21.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                name,
                style: TextStyle(
                  fontSize: 15,
                  color: rgba(255, 255, 255, 1),
                ),
              ),
              SizedBox(
                height: 9,
              ),
              Row(
                children: <Widget>[
                  Text(
                    content,
                    style: TextStyle(
                      fontSize: 11,
                      color: rgba(145, 152, 173, 1),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    subcontent,
                    style: TextStyle(
                      fontSize: 11,
                      color: rgba(145, 152, 173, 1),
                    ),
                  ),
                ],
              )
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 15,
              color: rgba(255, 255, 255, 1),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        border: showLine == true
            ? Border(
                bottom: BorderSide(
                  color: rgba(255, 255, 255, 0.2),
                  width: 1,
                ),
              )
            : Border(),
      ),
    );
  }
}