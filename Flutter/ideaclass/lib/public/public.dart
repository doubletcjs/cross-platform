import 'dart:convert';
import 'dart:io';

import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ideaclass/pages/account/loginpage.dart';
import 'package:ovprogresshud/progresshud.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

final Color kMainColor = rgba(21, 159, 251, 1);
final Color kBaseSeparatorColor = rgba(136, 136, 136, 1);
final String kForceLogoutNotification = "ForceLogoutNotification";
final String kRefreshAccountNotification = "RefreshAccountNotification";
Map _accountInfo = {};

final RegExp kPhoneRegExp = RegExp(
    r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');

typedef kVoidFunctionBlock = void Function();
typedef kObjectFunctionBlock = void Function(Object object);

/// 退出登录
void logoutAcctount() {
  Future<SharedPreferences> future = SharedPreferences.getInstance();
  future.then(
    (preferences) {
      preferences.clear();
      _accountInfo = {};
    },
  );
}

/// 保存用户信息
void recordUserInfo(Map info) async {
  if (info != null && info.length > 0 && info["userId"] != null) {
    kLog("更新用户信息");
    _accountInfo = info;
    DartNotificationCenter.post(
        channel: kRefreshAccountNotification, options: null);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(
      "account",
      jsonEncode(info),
    );
  }
}

/// 读取用户信息
String fetchUserID() {
  final userInfo = _accountInfo;
  return "${userInfo["userId"] == null ? "" : userInfo["userId"]}";
}

String fetchToken() {
  final userInfo = _accountInfo;
  return "${userInfo["token"] == null ? "" : userInfo["token"]}";
}

Map fetchUser() {
  if (_accountInfo == null || _accountInfo.length == 0) {
    Future<SharedPreferences> future = SharedPreferences.getInstance();
    future.then(
      (preferences) {
        final mapString = preferences.get("account");
        if (isStringEmpty(mapString) == false) {
          Map userInfo = jsonDecode(mapString);
          _accountInfo = userInfo == null ? {} : userInfo;

          return _accountInfo;
        } else {
          return {};
        }
      },
    );

    return {};
  } else {
    return _accountInfo;
  }
}

/// 登录状态
bool accountLogin() {
  final userId = fetchUserID();
  if (isStringEmpty("$userId") == true) {
    return false;
  } else {
    return true;
  }
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

///可点击控件
Widget buttonWidget(Widget child, BuildContext context,
    {GestureTapCallback onTap,
    BorderRadius radius,
    Color color,
    bool loginIntercept = true}) {
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

                if (accountLogin() == true) {
                  onTap();
                } else {
                  _goLogin();
                }
              } else {
                onTap();
              }
            },
      borderRadius: radius,
    ),
    borderRadius: radius,
  );
}

///圆角网络图片
Widget radiusNetworkImage(String url, double width, double height,
    {String placeholder = "images/placeholder@3x.png", BorderRadius radius}) {
  return ClipRRect(
    child: FadeInImage.assetNetwork(
      placeholder: placeholder == null ? url : placeholder,
      image: url,
      width: width,
      height: height,
      fit: BoxFit.cover,
    ),
    borderRadius: radius == null ? BorderRadius.circular(0) : radius,
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

PreferredSize searchNavigationBar(
  BuildContext context, {
  Widget leading,
  String placeholder = "",
  TextEditingController controller,
  ValueChanged<String> onChanged,
  VoidCallback onEditingComplete,
  ValueChanged<String> onSubmitted,
}) {
  return PreferredSize(
    child: Stack(
      children: <Widget>[
        transparentAppBar(brightness: Brightness.light),
        Positioned(
          top: MediaQuery.of(context).padding.top,
          left: 0,
          right: 0,
          height: AppBar().preferredSize.height,
          child: Container(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 31,
                    decoration: BoxDecoration(
                      color: rgba(236, 236, 236, 1),
                      borderRadius: BorderRadius.circular(31 / 2),
                    ),
                    child: Row(
                      children: <Widget>[
                        leading == null
                            ? Image.asset(
                                "images/nav@3x.png",
                                width: 39,
                                height: 15,
                              )
                            : leading,
                        Expanded(
                          child: TextField(
                            controller: controller,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              labelText: placeholder,
                              contentPadding: EdgeInsets.fromLTRB(0, -30, 0, 0),
                              labelStyle: TextStyle(
                                fontSize: 14,
                                color: rgba(209, 210, 211, 1),
                              ),
                              hasFloatingPlaceholder: false,
                              border: InputBorder.none,
                            ),
                            onChanged: onChanged,
                            onEditingComplete: onEditingComplete,
                            onSubmitted: onSubmitted,
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                buttonWidget(
                  Text(
                    "取消",
                    style: TextStyle(
                      fontSize: 15,
                      color: rgba(23, 23, 23, 1),
                    ),
                  ),
                  context,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    ),
    preferredSize: AppBar().preferredSize,
  );
}

/// SVProgressHUD
showHUD({int milliseconds = 0, String message = "", bool maskBlock = false}) {
  if (isStringEmpty(message) == false) {
    Progresshud.showWithStatus(message);
  } else {
    Progresshud.show();
  }

  if (maskBlock == false) {
    Progresshud.setDefaultMaskTypeNone();
  }

  if (milliseconds > 0) {
    Future.delayed(
      Duration(milliseconds: milliseconds),
      () {
        Progresshud.dismiss();
      },
    );
  }
}

hideHUD() {
  Progresshud.dismiss();
}

void showToast(String message, BuildContext context,
    {int gravity = 1, int duration = 2}) {
  Future.delayed(
    Duration(milliseconds: 300),
    () {
      Toast.show(message, context, gravity: gravity, duration: duration);
    },
  );
}

/// 正则匹配
bool regularMatch(String text, RegExp regExp) {
  if (isStringEmpty(text) == true) {
    return false;
  }

  return regExp.hasMatch(text);
}

///加载缓存
Future<String> loadAppCache() async {
  ///格式化文件大小
  _renderSize(double value) {
    if (null == value) {
      return 0;
    }
    List<String> unitArr = List()..add('B')..add('K')..add('M')..add('G');
    int index = 0;
    while (value > 1024) {
      index++;
      value = value / 1024;
    }
    String size = value.toStringAsFixed(2);
    return size + unitArr[index];
  }

  /// 递归方式 计算文件的大小
  Future<double> _getTotalSizeOfFilesInDir(final FileSystemEntity file) async {
    try {
      if (file is File) {
        int length = await file.length();
        return double.parse(length.toString());
      }
      if (file is Directory) {
        final List<FileSystemEntity> children = file.listSync();
        double total = 0;
        if (children != null)
          for (final FileSystemEntity child in children)
            total += await _getTotalSizeOfFilesInDir(child);
        return total;
      }
      return 0;
    } catch (e) {
      print(e);
      return 0;
    }
  }

  try {
    Directory tempDir = await getTemporaryDirectory();
    double value = await _getTotalSizeOfFilesInDir(tempDir);
    /*tempDir.list(followLinks: false,recursive: true).listen((file){
          //打印每个缓存文件的路径
        print(file.path);
      });*/
    // print('临时目录大小: ' + value.toString());
    return _renderSize(value);
  } catch (err) {
    print(err);
    return "";
  }
}
