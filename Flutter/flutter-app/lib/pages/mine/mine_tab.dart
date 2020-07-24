import 'package:flutter/material.dart';
import 'views/minecell.dart';
import 'views/mineheader.dart';
import '../../public/public.dart';
import 'certification.dart';
import '../wallet/walletpage.dart';
import '../setting/settingpage.dart';

class MinePage extends StatefulWidget {
  MinePage({Key key}) : super(key: key);

  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rgba(248, 248, 248, 1),
      body: Stack(
        children: <Widget>[
          transparentAppBar(
            brightness: Brightness.light,
          ),
          Column(
            children: <Widget>[
              MineHeader(),
              Container(
                margin: EdgeInsets.fromLTRB(14, 10, 14, 0),
                child: ClipRRect(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      MineCell(
                        icon: "images/vip@3x.png",
                        text: "会员",
                        tapHandle: () {},
                      ),
                      MineCell(
                        icon: "images/jinbi@3x.png",
                        text: "钱包",
                        tapHandle: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) {
                              return WalletPage();
                            }),
                          );
                        },
                      ),
                      MineCell(
                        icon: "images/renzheng@3x.png",
                        text: "认证",
                        tapHandle: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) {
                              return CertificationPage();
                            }),
                          );
                        },
                      ),
                      MineCell(
                        icon: "images/shezhi@3x.png",
                        text: "设置",
                        showLine: false,
                        tapHandle: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) {
                              return SettingPage();
                            }),
                          );
                        },
                      ),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: rgba(0, 0, 0, 0.06),
                        offset: Offset(0, 5), //阴影xy轴偏移量
                        blurRadius: 20.0, //阴影模糊程度
                        spreadRadius: 1 //阴影扩散程度
                        ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
