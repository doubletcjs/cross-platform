import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:repayment_flutter/pages/account/loginpage.dart';
import 'package:toast/toast.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';

// base64库
import 'dart:convert' as convert;
// 文件相关
import 'dart:io';
import 'dart:typed_data';

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

///滑动删除
Widget functionSlidableCell(
  Widget cell, {
  double actionExtentRatio = 0.25,
  bool closeOnScroll = false,
  List<ClosableSlideAction> rightActions,
  List<ClosableSlideAction> leftActions,
}) {
  return Slidable(
    child: cell,
    actionPane: SlidableBehindActionPane(),
    closeOnScroll: closeOnScroll,
    actionExtentRatio: actionExtentRatio,
    secondaryActions: rightActions,
    actions: leftActions,
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

/*
  * Base64加密
  */
String base64Encode(String data) {
  var content = convert.utf8.encode(data);
  var digest = convert.base64Encode(content);
  return digest;
}

/*
  * Base64解密
  */
String base64Decode(String data) {
  List<int> bytes = convert.base64Decode(data);
  // 网上找的很多都是String.fromCharCodes，这个中文会乱码
  //String txt1 = String.fromCharCodes(bytes);
  String result = convert.utf8.decode(bytes);
  return result;
}

/*
  * 通过图片路径将图片转换成Base64字符串
  */
Future<String> imageToBase64(String path) async {
  File file = new File(path);
  List<int> imageBytes = await file.readAsBytes();
  return convert.base64Encode(imageBytes);
}

/*
  * 将图片文件转换成Base64字符串
  */
Future imageFileToBase64(File file) async {
  List<int> imageBytes = await file.readAsBytes();
  return convert.base64Encode(imageBytes);
}

/*
  * 将Base64字符串的图片转换成图片
  */
Future<Image> base64ToImage(String base64Txt) async {
  Uint8List decodeTxt = convert.base64.decode(base64Txt);
  return Image.memory(
    decodeTxt,
    width: 100, fit: BoxFit.fitWidth,
    gaplessPlayback: true, //防止重绘
  );
}
