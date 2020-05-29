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
final String kSwitchTabNotification = "SwitchTabNotification";

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
  double fontSize = 23,
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

///默认actionSheet弹框
void functionActionSheet(BuildContext rootContext,
    {String cancel = "",
    List<String> titles,
    TextStyle cancelStyle,
    TextStyle baseStyle}) {
  if (cancelStyle == null) {
    baseStyle = TextStyle(
      fontSize: 15,
      color: rgba(51, 51, 51, 1),
    );
  }

  if (baseStyle == null) {
    baseStyle = TextStyle(
      fontSize: 15,
      color: rgba(51, 51, 51, 1),
    );
  }

  if (titles == null) {
    titles = [];
  }

  Widget _cellWidget(String text, {bool isCancel}) {
    return Container(
      margin: EdgeInsets.fromLTRB(12, isCancel == true ? 20 : 0, 12, 0),
      child: ListTile(
        title: Text(
          text,
          textAlign: TextAlign.center,
          style: isCancel == true ? baseStyle : cancelStyle,
        ),
        onTap: () {
          kLog("any");
        },
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.5),
        color: Colors.white,
      ),
    );
  }

  showModalBottomSheet(
    context: rootContext,
    enableDrag: false,
    backgroundColor: rgba(0, 0, 0, 0),
    builder: (context) {
      return Container(
        margin:
            EdgeInsets.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return _cellWidget(
                    titles[index],
                  );
                },
                separatorBuilder: (context, index) {
                  return Container(
                    height: 10,
                  );
                },
                itemCount: titles.length,
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                reverse: true,
                physics: NeverScrollableScrollPhysics(),
              ),
            ),
            isStringEmpty(cancel) == false
                ? _cellWidget(
                    cancel,
                    isCancel: true,
                  )
                : Container(),
          ],
        ),
      );
    },
  );
}

///默认alertview弹框
void functionAlertView(
  BuildContext rootContext, {
  String title = "标题",
  String content = "内容",
  EdgeInsets titlePadding,
  EdgeInsets contentPadding,
  TextStyle titleTextStyle,
  TextStyle contentTextStyle,
  String cancel,
  String confirm,
  TextStyle cancelTextStyle,
  TextStyle confirmTextStyle,
  kVoidFunctionBlock cancelHandle,
  kVoidFunctionBlock confirmHandle,
}) {
  if (titlePadding == null) {
    titlePadding = EdgeInsets.fromLTRB(21, 16.5, 21, 0);
  }

  if (contentPadding == null) {
    contentPadding = EdgeInsets.fromLTRB(21, 10, 21, 14);
  }

  if (titleTextStyle == null) {
    titleTextStyle = TextStyle(
      fontSize: 15,
      color: rgba(51, 51, 51, 1),
    );
  }

  if (contentTextStyle == null) {
    contentTextStyle = TextStyle(
      fontSize: 13,
      color: rgba(51, 51, 51, 1),
      height: 1.8,
    );
  }

  if (cancelTextStyle == null) {
    cancelTextStyle = TextStyle(
      fontSize: 15,
      color: rgba(51, 51, 51, 1),
    );
  }

  if (confirmTextStyle == null) {
    confirmTextStyle = TextStyle(
      fontSize: 15,
      color: rgba(23, 96, 255, 1),
    );
  }

  showDialog(
    context: rootContext,
    builder: (context) {
      bool _fullAction = false;
      if (isStringEmpty(cancel) == false && isStringEmpty(confirm) == false) {
        _fullAction = true;
      }

      Widget _confirmButton() {
        return Container(
          height: 48.5,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                width: 0.5,
                color: rgba(145, 152, 173, 1),
              ),
            ),
          ),
          child: FlatButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Navigator.of(context).pop();
              if (confirmHandle != null) {
                confirmHandle();
              }
            },
            child: Text(
              confirm,
              style: confirmTextStyle,
            ),
          ),
        );
      }

      Widget _cancelButton() {
        return Container(
          height: 48.5,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                width: 0.5,
                color: rgba(145, 152, 173, 1),
              ),
              right: _fullAction == true
                  ? BorderSide(
                      width: 0.5,
                      color: rgba(145, 152, 173, 1),
                    )
                  : BorderSide.none,
            ),
          ),
          child: FlatButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Navigator.of(context).pop();
              if (cancelHandle != null) {
                cancelHandle();
              }
            },
            child: Text(
              cancel,
              style: cancelTextStyle,
            ),
          ),
        );
      }

      List<Widget> _items = [];
      if (isStringEmpty(cancel) == false) {
        _items.add(
          Expanded(
            child: _cancelButton(),
          ),
        );
      }
      if (isStringEmpty(confirm) == false) {
        _items.add(
          Expanded(
            child: _confirmButton(),
          ),
        );
      }

      return AlertDialog(
        buttonPadding: EdgeInsets.zero,
        actionsPadding: EdgeInsets.zero,
        titlePadding: titlePadding,
        contentPadding: contentPadding,
        title: Text(
          title,
          textAlign: TextAlign.center,
        ),
        titleTextStyle: titleTextStyle,
        content: Text(
          content,
        ),
        contentTextStyle: contentTextStyle,
        actions: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 48.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _items,
            ),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.5),
        ),
      );
    },
  );
}

///实名认证弹框
void certificationAlert(BuildContext context) {
  functionAlertView(
    context,
    title: "提示",
    content: "您还没有实名认证，请实名认证后进行操作。",
    confirm: "实名认证",
    cancel: "取消",
    cancelTextStyle: TextStyle(
      color: rgba(145, 152, 173, 1),
      fontSize: 15,
      fontWeight: FontWeight.w300,
    ),
    confirmTextStyle: TextStyle(
      color: rgba(23, 96, 255, 1),
      fontSize: 15,
      fontWeight: FontWeight.w300,
    ),
    contentPadding: EdgeInsets.fromLTRB(20, 25.5, 20, 37),
    confirmHandle: () {},
  );
}

///钱包提醒
void walletAlert(BuildContext context) {
  functionAlertView(
    context,
    title: "温馨提示",
    content: "由于飞码通支付通道华夏银行进行升级，请使用现金充值和现金提现。",
    confirm: "知道了",
    confirmTextStyle: TextStyle(
      color: rgba(23, 96, 255, 1),
      fontSize: 15,
      fontWeight: FontWeight.w300,
    ),
    contentPadding: EdgeInsets.fromLTRB(21, 27, 21, 31.5),
    contentTextStyle: TextStyle(
      color: rgba(51, 51, 51, 1),
      fontSize: 13,
      height: 1.8,
    ),
    confirmHandle: () {},
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
