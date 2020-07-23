import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

// 用户登录状态变化 type 0 登录 1 账号信息刷新 2 登出
final String kAccountHandleNotification = "AccountHandleNotification";
// 切换tab
final String kTabSwitchNotification = "TabSwitchNotification";

// 默认背景颜色
final Color kMainBackgroundColor = rgba(255, 255, 255, 1);

///tab默认颜色
final Color kTabSelectedColor = rgba(249, 88, 98, 1);
final Color kTabUnselectedColor = rgba(51, 51, 51, 1);

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

//文本尺寸
Size getTextSize(String text, TextStyle textStyle, {int maxLines = 1}) {
  final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: textStyle,
      ),
      maxLines: maxLines > 0 ? maxLines : 1,
      textDirection: TextDirection.ltr)
    ..layout(minWidth: 0, maxWidth: double.infinity);
  return textPainter.size;
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
