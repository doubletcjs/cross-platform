import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../mine/minehomepage.dart';
import '../../../public/public.dart';
import '../../account/api/accountapi.dart';

class MineHeader extends StatefulWidget {
  MineHeader({Key key}) : super(key: key);

  @override
  _MineHeaderState createState() => _MineHeaderState();
}

class _MineHeaderState extends State<MineHeader> {
  Map _account = {};
  //获取用户信息
  void _refreshAccount() {
    AccountApi.profile((data, msg) {
      if (data != null) {
        setState(() {
          _account = Map.from(data);
        });
      } else {
        showToast(msg, context);
      }
    });
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 10), () {
      this._refreshAccount();
    });
  }

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
                  //头像
                  ClipRRect(
                    child: CachedNetworkImage(
                      placeholder: (context, url) {
                        return Image.asset(
                          "images/placeholder_mini@3x.png",
                          width: 102,
                          height: 102,
                          fit: BoxFit.cover,
                        );
                      },
                      imageUrl:
                          _account["avatar"] != null ? _account["avatar"] : "",
                      width: 102,
                      height: 102,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(102 / 2),
                  ),
                  //认证
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
              //昵称
              Text(
                _account["nickname"] != null ? _account["nickname"] : "用户名",
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
              //个人资料
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
