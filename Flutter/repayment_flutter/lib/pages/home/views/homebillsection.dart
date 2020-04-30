import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:repayment_flutter/pages/home/views/homebillcell.dart';
import 'package:repayment_flutter/public/public.dart';

class HomeBillSection extends StatefulWidget {
  HomeBillSection({Key key}) : super(key: key);

  @override
  _HomeBillSectionState createState() => _HomeBillSectionState();
}

class _HomeBillSectionState extends State<HomeBillSection> {
  bool _unfold = false;
  void _unfoldCell() {
    setState(() {
      _unfold = !_unfold;
    });
  }

  List<Widget> _cellList() {
    List<Widget> _list = [];
    for (var i = 0; i < 3 + Random().nextInt(6); i++) {
      _list.add(
        functionSlidableCell(
          HomeBillCell(
            onClose: (ctx) {
              Slidable.of(ctx).close();
            },
          ),
          actionExtentRatio: 80 / MediaQuery.of(context).size.width,
          rightActions: [
            SlideAction(
              child: Text(
                "设为已还",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              closeOnTap: true,
              color: kMainColor,
              onTap: () {},
            ),
          ],
        ),
      );
    }

    return _list;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        buttonWidget(
          Container(
            height: 55,
            padding: EdgeInsets.fromLTRB(17, 0, 17, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Image.asset(
                      _unfold == true
                          ? "images/icon_list_down.png"
                          : "images/icon_edit_right.png",
                      width: 13,
                      height: 13,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "本月待还",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Random().nextInt(2) == 1
                    ? Row(
                        children: <Widget>[
                          Text(
                            "1201.23",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                              fontFamily: "Oswald",
                            ),
                          ),
                        ],
                      )
                    : Row(
                        children: <Widget>[
                          Image.asset(
                            "images/list_done.png",
                            width: 18,
                            height: 18,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                            "全部还清",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
          context,
          onTap: () {
            this._unfoldCell();
          },
          color: Colors.white,
        ),
        _unfold == true
            ? Column(
                children: _cellList(),
              )
            : Container(),
      ],
    );
  }
}
