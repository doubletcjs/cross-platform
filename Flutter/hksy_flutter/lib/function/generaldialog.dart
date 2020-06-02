import 'package:flutter/material.dart';
import 'package:hksy_flutter/public/public.dart';

class GeneralDialog extends StatelessWidget {
  GeneralDialog({Key key}) : super(key: key);

  Container _content = Container();
  EdgeInsets _backgroundPadding = EdgeInsets.zero;
  Alignment _backgroundAlignment = Alignment.center;
  BorderRadius _borderRadius = BorderRadius.circular(0);
  Color _contentBackgroundColor;

  show(
    BuildContext context, {
    Color backgroundColor,
    containerContent,
    Color contentBackgroundColor,
    EdgeInsets backgroundPadding,
    Alignment backgroundAlignment,
    BorderRadius borderRadius,
  }) {
    if (backgroundColor == null) {
      backgroundColor = rgba(0, 0, 0, 0.2);
    }

    this._loadConfig(
      containerContent,
      contentBackgroundColor,
      backgroundPadding,
      backgroundAlignment,
      borderRadius,
    );

    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: backgroundColor,
      transitionDuration: Duration(milliseconds: 200),
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return this;
      },
    );
  }

  void _loadConfig(
    containerContent,
    Color contentBackgroundColor,
    EdgeInsets backgroundPadding,
    Alignment backgroundAlignment,
    BorderRadius borderRadius,
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
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding: _backgroundPadding, //定制
      duration: Duration(milliseconds: 200),
      child: Align(
        alignment: _backgroundAlignment, //定制
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Material(
            borderRadius: _borderRadius, //定制
            color: _contentBackgroundColor,
            child: _content,
          ),
        ),
      ),
    );
  }
}
