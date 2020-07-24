import 'package:flutter/material.dart';
import '../../mine/minehomepage.dart';
import '../../../public/public.dart';

class MineHeader extends StatefulWidget {
  MineHeader({Key key}) : super(key: key);

  @override
  _MineHeaderState createState() => _MineHeaderState();
}

class _MineHeaderState extends State<MineHeader> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Image.asset(
          "images/Oval 7@3x.png",
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width * 285 / 375, //375/285
          fit: BoxFit.cover,
        ),
        Container(
          width: 250,
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 33.5 + MediaQuery.of(context).padding.top,
              ),
              Stack(
                children: <Widget>[
                  ClipRRect(
                    child: Image.asset(
                      "images/f6156644b385.jpg.png",
                      width: 102,
                      height: 102,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(102 / 2),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 10,
                    child: Image.asset(
                      "images/renzheng_icon@3x.png",
                      width: 16,
                      height: 16,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 18.5,
              ),
              Text(
                "Saya Tillman",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 19,
                  color: rgba(51, 51, 51, 1),
                ),
              ),
              SizedBox(
                height: 7,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return MineHomePage(
                        isSelf: true,
                      );
                    }),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "查看个人资料",
                      style: TextStyle(
                        fontSize: 14,
                        color: rgba(144, 144, 144, 1),
                      ),
                    ),
                    SizedBox(
                      width: 5.5,
                    ),
                    Image.asset(
                      "images/Shape@3x.png",
                      width: 8,
                      height: 12,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 57.5,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
