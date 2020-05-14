import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';

final Color kMainColor = rgba(23, 96, 255, 1);
final Color kMainBackgroundColor = rgba(21, 25, 54, 1);
typedef kVoidFunctionBlock = void Function();
typedef kObjectFunctionBlock = void Function(Object object);
final String kForceLogoutNotification = "ForceLogoutNotification";
final String kRefreshAccountNotification = "RefreshAccountNotification";

final RegExp kPhoneRegExp = RegExp(
    r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');

final Future<SharedPreferences> _preferencesFuture =
    SharedPreferences.getInstance();

Map _accountInfo = {};

///userID
String userID() {
  final userInfo = _accountInfo;
  return "${userInfo["userId"] == null ? "" : userInfo["userId"]}";
}

///token
String token() {
  _preferencesFuture.then((preferences) {
    return preferences.get("token");
  }).catchError((error) {
    kLog("error:$error");
  });

  return "";
}

void recordToken(token) {
  _preferencesFuture.then((preferences) {
    preferences.setString(
      "token",
      token,
    );
  }).catchError((error) {
    kLog("error:$error");
  });
}

/// 保存用户信息
void recordUserInfo(Map info) {
  if (info != null && info.length > 0 && info["userId"] != null) {
    kLog("更新用户信息");
    _accountInfo = info;
    _preferencesFuture.then((preferences) {
      preferences.setString(
        "account",
        jsonEncode(info),
      );
    }).catchError((error) {
      kLog("error:$error");
    });
  }
}

Map fetchUser() {
  if (_accountInfo == null || _accountInfo.length == 0) {
    _preferencesFuture.then((preferences) {
      final mapString = preferences.get("account");
      if (isStringEmpty(mapString) == false) {
        Map userInfo = jsonDecode(mapString);
        _accountInfo = userInfo == null ? {} : userInfo;

        return _accountInfo;
      } else {
        return {};
      }
    }).catchError((error) {
      kLog("error:$error");
    });

    return {};
  } else {
    return _accountInfo;
  }
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

///下拉刷新上提加载更多
CustomFooter functionFooter({bool enable = true}) {
  return CustomFooter(
    builder: (BuildContext context, LoadStatus mode) {
      Widget body;
      if (mode == LoadStatus.idle) {
        body = Text(
          "上拉加载",
          style: TextStyle(
            fontSize: 15,
          ),
        );
      } else if (mode == LoadStatus.loading) {
        body = CupertinoActivityIndicator();
      } else if (mode == LoadStatus.failed) {
        body = Text(
          "加载失败！点击重试！",
          style: TextStyle(
            fontSize: 15,
          ),
        );
      } else if (mode == LoadStatus.canLoading) {
        body = Text(
          "松手,加载更多!",
          style: TextStyle(
            fontSize: 15,
          ),
        );
      } else {
        body = Text(
          "没有更多数据了!",
          style: TextStyle(
            fontSize: 15,
          ),
        );
      }
      return enable == false
          ? Container()
          : Container(
              height: 44.0,
              child: Center(child: body),
            );
    },
  );
}

Widget functionRefresher(
  RefreshController controller,
  Widget child, {
  VoidCallback onRefresh,
  VoidCallback onLoadMore,
  bool enableRefresh = true,
  bool enableLoadMore = false,
  List<Widget> slivers,
}) {
  return slivers == null
      ? SmartRefresher(
          controller: controller,
          enablePullDown: enableRefresh,
          enablePullUp: enableLoadMore,
          header: WaterDropMaterialHeader(),
          footer: functionFooter(enable: enableLoadMore),
          onRefresh: onRefresh,
          onLoading: onLoadMore,
          child: child,
        )
      : SmartRefresher.builder(
          controller: controller,
          enablePullDown: enableRefresh,
          enablePullUp: enableLoadMore,
          onRefresh: onRefresh,
          onLoading: onLoadMore,
          builder: (context, physics) {
            return CustomScrollView(
              physics: physics,
              slivers: slivers,
            );
          },
        );
}

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

/// 正则匹配
bool regularMatch(String text, RegExp regExp) {
  if (isStringEmpty(text) == true) {
    return false;
  }

  return regExp.hasMatch(text);
}
