import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

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

///toast
void showToast(String message, BuildContext context,
    {int gravity = 1, int duration = 2}) {
  Future.delayed(
    Duration(milliseconds: 300),
    () {
      Toast.show(message, context, gravity: gravity, duration: duration);
    },
  );
}

///自定义AppBar
AppBar customAppBar({
  String title,
  Widget titleView,
  double fontSize = 18,
  List<Widget> leftItems,
  List<Widget> rightItems,
  Brightness brightness = Brightness.light,
  Color backgroundColor = Colors.white,
  Color color = Colors.black,
  double elevation = 0.0,
  bool defaultBack,
}) {
  if (leftItems == null) {
    leftItems = [];
  }

  if (rightItems == null) {
    rightItems = [];
  }

  if (defaultBack == null) {
    defaultBack = false;
  }

  if (defaultBack == true) {
    return AppBar(
      title: title != null
          ? Text(
              title,
              style: TextStyle(
                fontSize: fontSize,
                color: color,
                fontWeight: FontWeight.normal,
              ),
            )
          : titleView != null ? titleView : Container(),
      actions: rightItems,
      brightness: brightness,
      backgroundColor: backgroundColor,
      iconTheme: IconThemeData(color: color),
      elevation: elevation,
    );
  }

  return AppBar(
    automaticallyImplyLeading: false,
    titleSpacing: 0,
    title: Container(
      height: AppBar().preferredSize.height,
      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            constraints: (leftItems.length > 0 || rightItems.length > 0)
                ? BoxConstraints(
                    maxWidth: 200,
                  )
                : BoxConstraints(),
            child: title != null
                ? Text(
                    title,
                    style: TextStyle(
                      fontSize: fontSize,
                      color: color,
                      fontWeight: FontWeight.normal,
                    ),
                  )
                : titleView != null ? titleView : Container(),
          ),
          Positioned(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: leftItems,
                ),
                Row(
                  children: rightItems,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
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
