import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hksy_flutter/pages/home/bulletinboard.dart';
import 'package:hksy_flutter/public/public.dart';
import 'package:hksy_flutter/pages/home/api/homeapi.dart';

class HomeNotice extends StatefulWidget {
  HomeNotice({Key key}) : super(key: key);

  @override
  _HomeNoticeState createState() => _HomeNoticeState();
}

class _HomeNoticeState extends State<HomeNotice> {
  List _dataList = [];

  @override
  void initState() {
    super.initState();

    HomeApi.getNotice((data, msg) {
      if (data != null) {
        setState(() {
          _dataList = data;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _dataList.length == 0
        ? Container(
            height: 37.5,
          )
        : Container(
            padding: EdgeInsets.fromLTRB(12, 27.5, 12, 35),
            child: Container(
              height: 37.5,
              padding: EdgeInsets.fromLTRB(17, 2, 9, 2),
              decoration: BoxDecoration(
                color: rgba(28, 35, 63, 1),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "images/ico_home_notice@3x.png",
                    fit: BoxFit.fitHeight,
                  ),
                  SizedBox(
                    width: 8.5,
                  ),
                  Expanded(
                    child: Swiper.children(
                      children: _dataList.map(
                        (notice) {
                          return Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              notice["dicId"] == "11"
                                  ? notice["content"]
                                  : "恭喜${notice["content"]}的用户认购${notice["clickNum"]}T！！！",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 13,
                                color: rgba(255, 255, 255, 1),
                              ),
                            ),
                          );
                        },
                      ).toList(),
                      scrollDirection: Axis.vertical,
                      autoplay: true,
                      onTap: (index) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return BulletinBoard();
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
