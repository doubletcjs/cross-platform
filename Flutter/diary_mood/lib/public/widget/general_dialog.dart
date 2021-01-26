import 'package:diary_mood/public/public.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GeneralDialog extends StatelessWidget {
  GeneralDialog({Key key}) : super(key: key);

  Container _content = Container();
  EdgeInsets _backgroundPadding = EdgeInsets.zero;
  Alignment _backgroundAlignment = Alignment.center;
  BorderRadius _borderRadius = BorderRadius.circular(0);
  Color _contentBackgroundColor;
  Color _backgroundColor;
  bool _barrierDismissible = true;

  show(
    BuildContext context, {
    Color backgroundColor,
    Widget containerContent,
    Color contentBackgroundColor,
    EdgeInsets backgroundPadding,
    Alignment backgroundAlignment,
    BorderRadius borderRadius,
    bool barrierDismissible = true,
  }) {
    if (backgroundColor == null) {
      backgroundColor = Color.fromRGBO(0, 0, 0, 0.2);
    }

    this._loadConfig(
      containerContent,
      contentBackgroundColor,
      backgroundColor,
      backgroundPadding,
      backgroundAlignment,
      borderRadius,
      barrierDismissible,
    );

    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: backgroundColor,
      transitionDuration: Duration(milliseconds: 100),
      // transitionBuilder: (context, animation, secondaryAnimation, child) {
      //   if (backgroundAlignment == Alignment.bottomCenter) {
      //     kLog("bottomCenter");
      //     return SlideTransition(
      //       position: Tween<Offset>(
      //         begin: Offset(0.0, 1.0),
      //         end: Offset(0.0, 0.0),
      //       ).animate(
      //         CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn),
      //       ),
      //       child: child,
      //     );
      //   }

      //   return FadeTransition(
      //     // 从0开始到1
      //     opacity: Tween(begin: 0.0, end: 1.0).animate(
      //       CurvedAnimation(
      //         // 传入设置的动画
      //         parent: animation,
      //         // 设置效果，快进漫出   这里有很多内置的效果
      //         curve: Curves.fastOutSlowIn,
      //       ),
      //     ),
      //     child: child,
      //   );
      // },
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return this;
      },
    );
  }

  void _loadConfig(
    Widget containerContent,
    Color contentBackgroundColor,
    Color backgroundColor,
    EdgeInsets backgroundPadding,
    Alignment backgroundAlignment,
    BorderRadius borderRadius,
    bool barrierDismissible,
  ) {
    _content = containerContent != null
        ? Container(
            child: containerContent,
          )
        : Container();
    _backgroundPadding =
        backgroundPadding != null ? backgroundPadding : EdgeInsets.zero;
    _backgroundAlignment =
        backgroundAlignment != null ? backgroundAlignment : Alignment.center;
    _borderRadius =
        borderRadius != null ? borderRadius : BorderRadius.circular(0);
    _contentBackgroundColor =
        contentBackgroundColor != null ? contentBackgroundColor : Colors.white;
    _backgroundColor = backgroundColor != null
        ? backgroundColor
        : Color.fromRGBO(0, 0, 0, 0.2);
    _barrierDismissible = barrierDismissible;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_barrierDismissible) {
          Navigator.of(context).pop();
        }
      },
      child: Container(
        color: _backgroundColor,
        child: AnimatedPadding(
          padding: _backgroundPadding, //定制
          duration: Duration(milliseconds: 10),
          child: Align(
            alignment: _backgroundAlignment, //定制
            child: GestureDetector(
              onTap: () {},
              child: Material(
                borderRadius: _borderRadius, //定制
                color: _contentBackgroundColor, //定制
                child: _content,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
