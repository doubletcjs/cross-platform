import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
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
          : titleView != null
              ? titleView
              : Container(),
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
                : titleView != null
                    ? titleView
                    : Container(),
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
  String path,
  Size size,
  BorderRadius borderRadius, {
  String placeholder,
  BoxFit fit: BoxFit.cover,
}) {
  return ClipRRect(
    child: (path != null && path.length > 0 && path.contains("http"))
        ? CachedNetworkImage(
            fadeInDuration: Duration(seconds: 0),
            fadeOutDuration: Duration(seconds: 0),
            placeholderFadeInDuration: Duration(seconds: 0),
            placeholder: (context, url) {
              return Image.asset(
                placeholder != null
                    ? placeholder
                    : "images/placeholder_mini@3x.png",
                width: size.width,
                height: size.height,
                fit: fit,
              );
            },
            imageUrl: ObjectUtil.isEmpty(path) == false ? "$path" : "",
            width: size.width,
            height: size.height,
            fit: BoxFit.cover,
          )
        : Image.asset(
            ObjectUtil.isEmpty(path) == true
                ? "images/placeholder_mini@3x.png"
                : path,
            width: size.width,
            height: size.height,
            fit: fit,
          ),
    borderRadius: borderRadius,
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
          "没有更多了!",
          style: TextStyle(
            fontSize: 15,
          ),
        );
      }

      return enable == false
          ? Container()
          : Container(
              height: 64,
              child: Center(
                child: body,
              ),
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
  void Function(bool up, double offset) onOffsetChange,
}) {
  return RefreshConfiguration(
    hideFooterWhenNotFull: true,
    enableBallisticLoad: false,
    child: slivers == null
        ? SmartRefresher(
            controller: controller,
            enablePullDown: enableRefresh,
            enablePullUp: enableLoadMore,
            header: WaterDropMaterialHeader(),
            footer: functionFooter(enable: enableLoadMore),
            onRefresh: onRefresh,
            onLoading: onLoadMore,
            onOffsetChange: onOffsetChange,
            child: child,
          )
        : SmartRefresher.builder(
            controller: controller,
            enablePullDown: enableRefresh,
            enablePullUp: enableLoadMore,
            onRefresh: onRefresh,
            onLoading: onLoadMore,
            onOffsetChange: onOffsetChange,
            builder: (context, physics) {
              return CustomScrollView(
                physics: physics,
                slivers: slivers,
              );
            },
          ),
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
