import 'package:flutter/material.dart';

class AvatarHeader extends StatefulWidget {
  AvatarHeader({Key key}) : super(key: key);

  @override
  _AvatarHeaderState createState() => _AvatarHeaderState();
}

class _AvatarHeaderState extends State<AvatarHeader> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        //当前头像
        Image.asset(
          "images/placeholder@3x.png",
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
          height: 375,
        ),
        //历史头像列表
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
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(4),
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
