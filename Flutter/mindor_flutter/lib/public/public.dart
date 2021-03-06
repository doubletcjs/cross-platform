import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';

final Color kMainColor = rgba(23, 96, 255, 1);
typedef kVoidFunctionBlock = void Function();
typedef kObjectFunctionBlock = void Function(Object object);

///自定义AppBar
AppBar customAppBar({
  String title,
  Widget titleView,
  Color color = Colors.black,
  double fontSize = 17,
  Widget leftItem,
  List<Widget> rightItems,
  Brightness brightness = Brightness.light,
  Color backgroundColor = Colors.white,
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

///hud
XsProgressHud initHUD(
  BuildContext context, {
  String message,
  Duration delayed = const Duration(milliseconds: 2000),
  bool autoHide = false,
}) {
  XsProgressHud hud = XsProgressHud();
  hud.message = message;
  hud.progressColor = Colors.grey;
  hud.progressBackgroundColor = Colors.white;

  if (autoHide == true) {
    Future.delayed(delayed).then((val) {
      hud.navigator.pop();
      hud = null;
    });
  }

  Navigator.push(context, hud);
  return hud;
}

void hideHUD(XsProgressHud hud) {
  hud.navigator.pop();
  hud = null;
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

///开发、发布
bool kDebug() {
  return kReleaseMode == true ? false : true;
}

///打印日志
void kLog(Object any) {
  if (kDebug() == true) {
    print('$any');
  }
}

///rgb颜色
Color rgba(int r, int g, int b, double opacity) {
  return Color.fromRGBO(r, g, b, opacity);
}

///字符串空判断
bool isStringEmpty(text) {
  if (text == null) {
    return true;
  } else if (text == "null" || text == null || text.isEmpty) {
    return true;
  } else if (text.length == 0 || text == " " || text == "") {
    return true;
  } else {
    return false;
  }
}
