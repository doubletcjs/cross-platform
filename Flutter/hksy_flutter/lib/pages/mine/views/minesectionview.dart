import 'package:flutter/material.dart';
import 'package:hksy_flutter/public/public.dart';

class MineSectionView extends StatefulWidget {
  List<Map<String, String>> dataSources = [];
  MineSectionView({Key key, this.dataSources}) : super(key: key);

  @override
  _MineSectionViewState createState() => _MineSectionViewState();
}

class _MineSectionViewState extends State<MineSectionView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(12, 20, 10, 0),
      decoration: BoxDecoration(
        color: rgba(28, 35, 63, 1),
        borderRadius: BorderRadius.circular(7.5),
      ),
      child: Column(
        children: this.widget.dataSources.map(
          (data) {
            String name = data["name"];
            String icon = data["icon"];
            String additional = data["additional"];
            int index = this.widget.dataSources.indexOf(data);
            return Container(
              padding: EdgeInsets.fromLTRB(20, 18.5, 20, 0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Image.asset(
                        icon,
                        width: 23,
                        fit: BoxFit.fitWidth,
                      ),
                      SizedBox(
                        width: 13.5,
                      ),
                      Text(
                        name,
                        style: TextStyle(
                          color: rgba(255, 255, 255, 1),
                          fontSize: 15,
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Row(
                        children: <Widget>[
                          additional == null
                              ? Container()
                              : Text(
                                  additional,
                                  style: TextStyle(
                                    color: rgba(145, 152, 173, 1),
                                    fontSize: 13,
                                  ),
                                ),
                          SizedBox(
                            width: additional == null ? 0 : 8,
                          ),
                          Image.asset(
                            "images/right_arrow@3x.png",
                            width: 20,
                            fit: BoxFit.fitWidth,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 18.5, 0, 0),
                    height:
                        index < this.widget.dataSources.length - 1 ? 0.8 : 0,
                    color: rgba(21, 25, 54, 1),
                  )
                ],
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
