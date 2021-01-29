import 'package:diary_mood/public/public.dart';
import 'package:diary_mood/public/widget/general_dialog.dart';
import 'package:flutter/material.dart';

typedef _kAlertFunctionBlock = void Function();

// ignore: must_be_immutable
class AlertView extends StatelessWidget {
  String title = "标题";
  TextStyle titleStyle;
  String content = "内容";
  TextStyle contentStyle;

  String cancel = "取消";
  TextStyle cancelStyle;
  String confirm = "确定";
  TextStyle confirmStyle;

  _kAlertFunctionBlock confirmHandle;

  AlertView({
    Key key,
    this.title = "标题",
    this.content = "内容",
    this.titleStyle,
    this.contentStyle,
    this.cancel = "取消",
    this.confirm = "确定",
    this.cancelStyle,
    this.confirmStyle,
    this.confirmHandle,
  }) : super(key: key);

  show(BuildContext context) {
    GeneralDialog().show(
      context,
      backgroundPadding: EdgeInsets.fromLTRB(50, 0, 50, 0),
      backgroundAlignment: Alignment.center,
      borderRadius: BorderRadius.circular(10),
      containerContent: this,
      barrierDismissible: false,
      backgroundColor: rgba(0, 0, 0, 0.5),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return SizedBox(
        width: orientation == Orientation.portrait
            ? MediaQuery.of(context).size.width
            : MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.left -
                MediaQuery.of(context).padding.right,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(20),
              child: Column(
                children: [
                  //标题
                  "$title".length > 0
                      ? Padding(
                          padding: EdgeInsets.only(bottom: 12),
                          child: Text(
                            "$title",
                            textAlign: TextAlign.center,
                            style: titleStyle == null
                                ? TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  )
                                : titleStyle,
                          ),
                        )
                      : Container(),
                  //内容
                  Text(
                    "$content",
                    textAlign: TextAlign.center,
                    style: contentStyle == null
                        ? TextStyle(
                            fontSize: 18,
                          )
                        : contentStyle,
                  ),
                ],
              ),
            ),
            // 分割线
            Divider(
              height: 1,
              color: rgba(240, 240, 240, 1),
            ),
            //功能按钮
            Row(
              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    height: 48,
                    minWidth: 0,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: EdgeInsets.zero,
                    color: Color.fromRGBO(255, 255, 255, 1),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "$cancel",
                      overflow: TextOverflow.ellipsis,
                      style: cancelStyle == null
                          ? TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.normal,
                            )
                          : cancelStyle,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: FlatButton(
                    height: 48,
                    minWidth: 0,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: EdgeInsets.zero,
                    color: Color.fromRGBO(255, 255, 255, 1),
                    onPressed: () {
                      Navigator.of(context).pop();
                      if (confirmHandle != null) {
                        confirmHandle();
                      }
                    },
                    child: Text(
                      "$confirm",
                      overflow: TextOverflow.ellipsis,
                      style: confirmStyle == null
                          ? TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 17,
                              fontWeight: FontWeight.normal,
                            )
                          : confirmStyle,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
