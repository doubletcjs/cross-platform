import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:hksy_flutter/public/networking.dart';
import 'package:hksy_flutter/public/public.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:qr_flutter/qr_flutter.dart';

class InvitationPage extends StatefulWidget {
  bool isHome = false;
  InvitationPage({Key key, this.isHome = false}) : super(key: key);

  @override
  _InvitationPageState createState() => _InvitationPageState();
}

class _InvitationPageState extends State<InvitationPage> {
  GlobalKey _repaintKey = GlobalKey();

  void _copyLink() {
    ClipboardData data = new ClipboardData(text: "要复制的内容");
    Clipboard.setData(data);

    Future.delayed(Duration(milliseconds: 200), () {
      showToast("复制成功", context);
    });
  }

  void _saveQrcode() async {
    try {
      RenderRepaintBoundary boundary =
          _repaintKey.currentContext.findRenderObject();
      var image = await boundary.toImage(
          pixelRatio: MediaQuery.of(context).devicePixelRatio);
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pageBytes = byteData.buffer.asUint8List();

      ImageGallerySaver.saveImage(pageBytes).then((value) {
        showToast("保存成功", context);
      }).catchError((error) {
        kLog(error.toString());
        showToast("保存失败", context);
      });
    } catch (e) {
      kLog(e.toString());
      showToast("保存失败", context);
    }
  }

  Widget _baseWidget() {
    return Stack(
      children: <Widget>[
        Positioned(
          left: 0,
          bottom: 0,
          right: 0,
          child: Container(
            color: Colors.white,
            child: Stack(
              children: <Widget>[
                Image.asset(
                  "images/invite_illustrations@3x.png",
                  fit: BoxFit.cover,
                ),
                Positioned(
                  left: 0,
                  bottom: 0,
                  right: 0,
                  child: Container(
                    color: rgba(28, 35, 63, 1),
                    padding: EdgeInsets.fromLTRB(
                        12, 26, 12, 26 + MediaQuery.of(context).padding.bottom),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "邀请链接：",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: rgba(255, 255, 255, 1),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "http://www.beefil.com:808",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: rgba(145, 152, 173, 1),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Container(
                          height: 32,
                          decoration: BoxDecoration(
                            color: rgba(23, 96, 255, 1),
                            borderRadius: BorderRadius.circular(7.5),
                          ),
                          child: FlatButton(
                            padding: EdgeInsets.fromLTRB(10, 5.1, 10, 5.5),
                            onPressed: () {
                              this._copyLink();
                            },
                            child: Text(
                              "复制链接",
                              style: TextStyle(
                                fontSize: 15,
                                color: rgba(255, 255, 255, 1),
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7.5),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 0,
          top: 0,
          right: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              this.widget.isHome
                  ? SizedBox(
                      height: 87.5,
                    )
                  : SizedBox(
                      height: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? 42
                          : 0,
                    ),
              Container(
                padding: EdgeInsets.fromLTRB(40, 50, 40, 15),
                decoration: BoxDecoration(
                  color: rgba(23, 96, 255, 1),
                  borderRadius: BorderRadius.circular(7.5),
                ),
                child: Column(
                  children: <Widget>[
                    RepaintBoundary(
                      key: _repaintKey,
                      child: Container(
                        width: 180,
                        height: 180,
                        child: QrImage(
                          data: kQrcodeURL +
                              "/invite/login.html?invitation_code=" +
                              "ct8g" +
                              "&a=" +
                              "${DateTime.now().millisecondsSinceEpoch}",
                          size: 180,
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    InkWell(
                      onTap: () {
                        this._saveQrcode();
                      },
                      child: Text(
                        "保存二维码",
                        style: TextStyle(
                          fontSize: 15,
                          color: rgba(255, 255, 255, 1),
                          decorationColor: rgba(255, 255, 255, 1),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 26.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "您的专属邀请码:",
                    style: TextStyle(
                      fontSize: 15,
                      color: rgba(255, 255, 255, 1),
                    ),
                  ),
                  SizedBox(
                    width: 43.5,
                  ),
                  Text(
                    "ct8g",
                    style: TextStyle(
                      fontSize: 23,
                      color: rgba(23, 96, 255, 1),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return this.widget.isHome
        ? Scaffold(
            backgroundColor: kMainBackgroundColor,
            appBar: customAppBar(
              title: "邀请好友",
              brightness: Brightness.dark,
              backgroundColor: kMainBackgroundColor,
              color: Colors.white,
            ),
            body: _baseWidget(),
          )
        : _baseWidget();
  }
}
