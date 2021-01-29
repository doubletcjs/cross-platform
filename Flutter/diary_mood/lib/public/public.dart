import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:extended_image/extended_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:one_context/one_context.dart';
import 'package:toast/toast.dart';

Color kMainColor = rgba(255, 45, 85, 1);

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
void showToast(String message,
    {int gravity = 1, int duration = 2, BuildContext context}) {
  Future.delayed(
    Duration(milliseconds: 300),
    () {
      Toast.show(message, context == null ? OneContext().context : context,
          gravity: gravity, duration: duration);
    },
  );
}

///透明导航栏
Widget transparentAppBar({Brightness brightness = Brightness.dark}) {
  return AppBar(
    titleSpacing: 0,
    elevation: 0,
    backgroundColor: Colors.transparent,
    brightness: brightness,
    leading: Container(),
  );
}

///带占位图网络图片
Widget extendedNetworkImage(
  String path,
  Size size,
  BorderRadius borderRadius, {
  String placeholder,
  BoxFit fit: BoxFit.cover,
}) {
  String _imageName(String name) {
    return (ObjectUtil.isEmptyString(name) == false &&
            name.endsWith(".mp4") == false)
        ? name
        : "images/placeholder_mini@3x.png";
  }

  return ClipRRect(
    child: (path.contains("http") && path.endsWith(".mp4") == false)
        ? ExtendedImage.network(
            "$path",
            cache: true,
            clearMemoryCacheWhenDispose: true,
            enableMemoryCache: false,
            borderRadius: borderRadius,
            fit: fit,
            width: size == null ? double.infinity : size.width,
            height: size == null ? double.infinity : size.height,
            loadStateChanged: (state) {
              if (state.extendedImageLoadState == LoadState.loading ||
                  state.extendedImageLoadState == LoadState.failed) {
                return Image.asset(
                  "images/placeholder_mini@3x.png",
                  fit: fit,
                  width: size == null ? double.infinity : size.width,
                  height: size == null ? double.infinity : size.height,
                );
              }

              return null;
            },
          )
        : Image.asset(
            _imageName(path),
            fit: fit,
            width: size == null ? double.infinity : size.width,
            height: size == null ? double.infinity : size.height,
          ),
    borderRadius: borderRadius,
  );
}
