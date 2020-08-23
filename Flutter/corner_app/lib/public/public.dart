import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//无值返回block回调
typedef kVoidFunctionBlock = void Function();
//带值返回block回调
typedef kObjectFunctionBlock = void Function(Object object);

///打印日志
void kLog(Object any) {
  if (kDebug() == true) {
    print('$any');
  }
}

///开发、发布
bool kDebug() {
  return kReleaseMode == true ? false : true;
}

///rgb颜色
Color rgba(int r, int g, int b, double opacity) {
  return Color.fromRGBO(r, g, b, opacity);
}

///自定义AppBar
AppBar customAppBar({
  String title,
  Widget titleView,
  double fontSize = 18,
  Widget leftItem,
  List<Widget> rightItems,
  Brightness brightness = Brightness.light,
  Color backgroundColor = Colors.white,
  Color color = Colors.black,
  double elevation = 0.0,
}) {
  return AppBar(
    title: title != null
        ? Text(
            title,
            style: TextStyle(fontSize: fontSize, color: color),
          )
        : titleView != null ? titleView : Container(),
    leading: leftItem != null
        ? Builder(builder: (context) {
            return leftItem;
          })
        : null,
    actions: rightItems,
    brightness: brightness,
    backgroundColor: backgroundColor,
    elevation: elevation,
    iconTheme: IconThemeData(color: color),
  );
}

Widget transparentAppBar({Brightness brightness = Brightness.dark}) {
  return customAppBar(
    backgroundColor: Colors.transparent,
    brightness: brightness,
    leftItem: Container(),
  );
}

///带占位图网络图片
Widget networkImage(
  String imageUrl,
  Size size,
  BorderRadius borderRadius, {
  String placeholder,
}) {
  return ClipRRect(
    child: (imageUrl != null &&
            imageUrl.length > 0 &&
            imageUrl.contains("http"))
        ? CachedNetworkImage(
            placeholder: (context, url) {
              return Image.asset(
                placeholder != null ? placeholder : "images/placeholder@3x.png",
                width: size.width,
                height: size.height,
                fit: BoxFit.cover,
              );
            },
            imageUrl: imageUrl,
            width: size.width,
            height: size.height,
            fit: BoxFit.cover,
          )
        : Image.asset(
            placeholder != null ? placeholder : "images/placeholder@3x.png",
            width: size.width,
            height: size.height,
            fit: BoxFit.cover,
          ),
    borderRadius: borderRadius,
  );
}
