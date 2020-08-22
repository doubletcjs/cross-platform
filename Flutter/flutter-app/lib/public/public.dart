import 'package:common_utils/common_utils.dart';
import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'gif_refresh_header.dart';

// 用户登录状态变化 type 0 登录 1 请求账号信息刷新 2 登出 3 请求账号信息结束，刷新本地记录用户信息
final String kAccountHandleNotification = "AccountHandleNotification";
// 用户资料完善情况
final String kAccountProfileNotification = "AccountProfileNotification";
// 切换tab
final String kTabSwitchNotification = "TabSwitchNotification";

// 默认背景颜色
final Color kMainBackgroundColor = rgba(255, 255, 255, 1);

///tab默认颜色
final Color kTabSelectedColor = rgba(249, 88, 98, 1);
final Color kTabUnselectedColor = rgba(51, 51, 51, 1);

// 当前登录用户信息
Map currentAccount = {};

// 友盟的配置信息
// ignore: non_constant_identifier_names
final Map<String, String> UMENG_CONFIG = {
  "androidKey": "5f2bb55cd30932215475860c",
  "iosKey": "5f2bb576b4b08b653e91ca95"
};

// 高德地图的配置信息
// ignore: non_constant_identifier_names
final Map<String, String> AMAP_CONFIG = {
  "androidKey": "d541c84d2f90faa0b4b2e7971d130d1c",
  "iosKey": "feb57d4f2537ca2f1206efdb2c674db0"
};

// 腾讯im配置信息
// ignore: non_constant_identifier_names
final TENCENTIM_APPID = (kDebug() == true) ? "1400398568" : "1400409186";
// ignore: non_constant_identifier_names
final TENCENTIM_BUSSID = (kDebug() == true) ? 21456 : 21455; //开发 //正式
// ignore: non_constant_identifier_names
// final TENCENTIM_SECRETKEY =
//     "f5e763808b3bad873c79809d319208fcc9950b9c1842b4a01946fbd5e7ebe648";

// 用于接口加密认证
final String privateKey = "yuemei";

final String loadingGifPath = "images/loading.gif";

///打印日志
void kLog(Object any) {
  if (kDebug() == true) {
    print('$any');
  }
}

//无值返回block回调
typedef kVoidFunctionBlock = void Function();
//带值返回block回调
typedef kObjectFunctionBlock = void Function(Object object);

//数据存储
final Future<SharedPreferences> _preferencesFuture =
    SharedPreferences.getInstance();

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

///用户id，存储、读取。userID
void userID(kObjectFunctionBlock complete) {
  _preferencesFuture.then((preferences) {
    if (complete != null) {
      if (ObjectUtil.isEmpty(preferences.getString("userId"))) {
        complete("");
      } else {
        complete("${preferences.getString('userId')}");
      }
    }
  }).catchError((error) {
    kLog("error:$error");
    //用户id为空，强制退出
    DartNotificationCenter.post(
      channel: kAccountHandleNotification,
      options: {
        "type": 2,
      },
    );
    if (complete != null) {
      complete("");
    }
  });
}

void recordUserID(userId) {
  _preferencesFuture.then((preferences) {
    preferences.setString(
      "userId",
      "$userId",
    );
    kLog("recordUserID");
  }).catchError((error) {
    kLog("error:$error");
  });
}

///请求token，存储、读取。token
void token(kObjectFunctionBlock complete) {
  _preferencesFuture.then((preferences) {
    String _token = preferences.getString("token");
    if (complete != null) {
      if (ObjectUtil.isEmptyString(_token) == true) {
        complete("");
      } else {
        complete("$_token");
      }
    }
  }).catchError((error) {
    kLog("error:$error");
    //token为空，强制退出
    DartNotificationCenter.post(
      channel: kAccountHandleNotification,
      options: {
        "type": 2,
      },
    );
    if (complete != null) {
      complete("");
    }
  });
}

void recordToken(token) {
  _preferencesFuture.then((preferences) {
    preferences.setString(
      "token",
      "$token",
    );
    kLog("recordToken");
  }).catchError((error) {
    kLog("error:$error");
  });
}

///请求userSig，存储、读取userSig
Future<String> readUserSig() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String _userSig = preferences.getString("userSig");

  if (ObjectUtil.isEmpty(_userSig)) {
    return "";
  } else {
    return _userSig;
  }
}

void recordUserSig(userSig) {
  _preferencesFuture.then((preferences) {
    preferences.setString(
      "userSig",
      "$userSig",
    );
    kLog("recordUserSig");
  }).catchError((error) {
    kLog("error:$error");
  });
}

///存储、读取deviceToken
Future<String> readDeviceToken() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String _deviceToken = preferences.getString("deviceToken");

  if (ObjectUtil.isEmpty(_deviceToken) || _deviceToken == "无法获取deviceToken") {
    return "";
  } else {
    return _deviceToken;
  }
}

void recordDeviceToken(deviceToken) {
  _preferencesFuture.then((preferences) {
    preferences.setString(
      "deviceToken",
      "$deviceToken",
    );

    kLog("deviceToken");
  }).catchError((error) {
    kLog("error:$error");
  });
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
            color: Colors.white,
          ),
        );
      } else if (mode == LoadStatus.loading) {
        body = CupertinoActivityIndicator();
      } else if (mode == LoadStatus.failed) {
        body = Text(
          "加载失败！点击重试！",
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        );
      } else if (mode == LoadStatus.canLoading) {
        body = Text(
          "松手,加载更多!",
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        );
      } else {
        body = Text(
          "没有更多了!",
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
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
  var header,
}) {
//WaterDropMaterialHeader()
  return slivers == null
      ? SmartRefresher(
          controller: controller,
          enablePullDown: enableRefresh,
          enablePullUp: enableLoadMore,
          header: header == null ? GifHeader() : header,
          footer: functionFooter(enable: enableLoadMore),
          onRefresh: onRefresh,
          onLoading: onLoadMore,
          child: child)
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

//渐隐动画
class FadeRoute extends PageRouteBuilder {
  final Widget page;
  FadeRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
