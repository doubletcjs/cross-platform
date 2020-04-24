import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:repayment_flutter/pages/account/loginpage.dart';

final Color kMainColor = rgba(21, 159, 251, 1);
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

///可点击控件
Widget buttonWidget(Widget child, BuildContext context,
    {GestureTapCallback onTap,
    BorderRadius radius,
    Color color,
    bool loginIntercept = false}) {
  return Material(
    color: color == null ? Color.fromRGBO(0, 0, 0, 0) : color,
    child: InkWell(
      child: child,
      onTap: onTap == null
          ? null
          : () {
              if (loginIntercept == true) {
                void _goLogin() {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginPage();
                      },
                    ),
                  );
                }

                // _goLogin();
                onTap();
                /* 
                Future<bool> future = accountLogin();
                future.then(
                  (isLogin) {
                    if (isLogin == true) {
                      onTap();
                    } else {
                      _goLogin();
                    }
                  },
                ).catchError(
                  (error) {
                    // _goLogin();
                  },
                );
              */
              } else {
                onTap();
              }
            },
      borderRadius: radius,
    ),
    borderRadius: radius,
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
