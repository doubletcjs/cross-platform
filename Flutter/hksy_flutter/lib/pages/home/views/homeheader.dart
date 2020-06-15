import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hksy_flutter/pages/coin/mycoin.dart';
import 'package:hksy_flutter/pages/home/api/homeapi.dart';
import 'package:hksy_flutter/pages/invitation/invitationpage.dart';
import 'package:hksy_flutter/public/public.dart';

class HomeHeader extends StatefulWidget {
  HomeHeader({Key key}) : super(key: key);

  @override
  _HomeHeaderState createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  List<String> _itemList = [
    "邀请",
    "钱包",
    "算力",
    "金币",
  ];
  List<String> _itemImageList = [
    "images/ico_home_invitation@3x.png",
    "images/ico_home_wallet@3x.png",
    "images/ico_home_calculation@3x.png",
    "images/ico_home_gold@3x.png",
  ];

  List _banners = [];

  void _itemFunctionAction(BuildContext context, index) {
    if (index == 2) {
      Navigator.of(context).pushNamed("/calculate");
    } else if (index == 3) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return MyCoinPage();
          },
        ),
      );
    } else if (index == 0) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return InvitationPage(
              isHome: true,
            );
          },
        ),
      );
    } else if (index == 1) {
      // certificationAlert(context);
      walletAlert(context);
    }
  }

  @override
  void initState() {
    super.initState();

    HomeApi.getBanners((data, msg) {
      if (data != null) {
        setState(() {
          _banners = data;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _banners.length == 0
        ? Container(
            height: MediaQuery.of(context).padding.top,
          )
        : Container(
            color: kMainBackgroundColor,
            height: (216 + 117.5) - 17,
            child: Stack(
              children: <Widget>[
                Container(
                  height: 216,
                  child: Swiper.children(
                    children: _banners.map(
                      (banner) {
                        return Image.network(
                          "${banner["imagePath"]}",
                          fit: BoxFit.fitWidth,
                        );
                      },
                    ).toList(),
                    autoplay: true,
                    autoplayDelay: 4000,
                  ),
                ),
                Positioned(
                  left: 12,
                  right: 12,
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(17, 20, 17, 25),
                    height: 117.5,
                    child: Wrap(
                      spacing: (MediaQuery.of(context).size.width -
                              12 * 2 -
                              17 * 2 -
                              53 * 4) /
                          3,
                      children: _itemList.map(
                        (item) {
                          int index = _itemList.indexOf(item);
                          return InkWell(
                            onTap: () {
                              _itemFunctionAction(context, index);
                            },
                            child: Column(
                              children: <Widget>[
                                Image.asset(
                                  _itemImageList[index],
                                  width: 53,
                                  height: 53,
                                ),
                                Text(
                                  item,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: rgba(255, 255, 255, 1),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ).toList(),
                    ),
                    decoration: BoxDecoration(
                      color: rgba(28, 35, 63, 1),
                      borderRadius: BorderRadius.circular(7.5),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
