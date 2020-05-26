import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hksy_flutter/pages/calculate/calculatemain.dart';
import 'package:hksy_flutter/pages/coin/mycoin.dart';
import 'package:hksy_flutter/pages/invitation/invitationpage.dart';
import 'package:hksy_flutter/public/public.dart';

class HomeHeader extends StatelessWidget {
  List<Map> banners = [];

  HomeHeader({Key key, this.banners}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

    void _itemFunctionAction(BuildContext context, index) {
      if (index == 2) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return CalculateMain();
            },
          ),
        );
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
      }
    }

    return Container(
      color: kMainBackgroundColor,
      height: (216 + 117.5) - 17,
      child: Stack(
        children: <Widget>[
          Container(
              height: 216,
              child: Swiper.children(
                children: <Widget>[
                  Image.network(
                    "https://ipfshksy.oss-cn-hongkong.aliyuncs.com/user/sys/20200403/1585905589602.png?Expires=1901265589&OSSAccessKeyId=LTAIYBtrLBpckLPj&Signature=0%2FElTkOQ4uorg3FP3NNpoRPrVQw%3D",
                    fit: BoxFit.fitWidth,
                  ),
                  Image.network(
                    "https://ipfshksy.oss-cn-hongkong.aliyuncs.com/user/sys/20200403/1585905595586.png?Expires=1901265595&OSSAccessKeyId=LTAIYBtrLBpckLPj&Signature=ZebW1cVFj5Nuzmqni7BHUrYXpmU%3D",
                    fit: BoxFit.fitWidth,
                  ),
                  Image.network(
                    "https://ipfshksy.oss-cn-hongkong.aliyuncs.com/user/sys/20200403/1585905589602.png?Expires=1901265589&OSSAccessKeyId=LTAIYBtrLBpckLPj&Signature=0%2FElTkOQ4uorg3FP3NNpoRPrVQw%3D",
                    fit: BoxFit.fitWidth,
                  ),
                ],
                autoplay: true,
                autoplayDelay: 4000,
              )

              // BannerView(
              //   // banners.map(
              //   //   (banner) {
              //   //     return Image.network(
              //   //       "https://ipfshksy.oss-cn-hongkong.aliyuncs.com/user/sys/20200403/1585905589602.png?Expires=1901265589&OSSAccessKeyId=LTAIYBtrLBpckLPj&Signature=0%2FElTkOQ4uorg3FP3NNpoRPrVQw%3D",
              //   //       fit: BoxFit.fitWidth,
              //   //     );
              //   //   },
              //   // ).toList(),
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
