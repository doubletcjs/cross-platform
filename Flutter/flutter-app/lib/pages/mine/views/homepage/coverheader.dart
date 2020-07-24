import 'package:flutter/material.dart';
import '../../../../public/public.dart';

class CoverHeader extends StatefulWidget {
  CoverHeader({Key key}) : super(key: key);

  @override
  _CoverHeaderState createState() => _CoverHeaderState();
}

class _CoverHeaderState extends State<CoverHeader> {
  int _currentIndex = 0; //当前封面index

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        //当前封面
        Image.asset(
          "images/placeholder@3x.png",
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
          height: 375,
        ),
        //封面列表
        Positioned(
          left: 0,
          right: 0,
          bottom: 16,
          height: 37,
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
                        ? Colors.black26
                        : rgba(0, 0, 0, 0),
                  ),
                ),
                child: FlatButton(
                  onPressed: () {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  child: Container(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Container(
                width: 5.5,
                height: 37,
              );
            },
            itemCount: 3,
          ),
        ),
      ],
    );
  }
}
