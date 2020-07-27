import 'package:flutter/material.dart';
import 'generaldialog.dart';

typedef _kAlertFunctionBlock = void Function();

class GeneralAlert extends StatelessWidget {
  String title = "标题";
  TextStyle titleStyle;
  String content = "内容";
  TextStyle contentStyle;

  String cancel = "取消";
  TextStyle cancelStyle;
  String confirm = "确定";
  TextStyle confirmStyle;

  _kAlertFunctionBlock confirmHandle;

  GeneralAlert({
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
      backgroundPadding: EdgeInsets.fromLTRB(37, 0, 37, 0),
      backgroundAlignment: Alignment.center,
      borderRadius: BorderRadius.circular(7),
      containerContent: this,
      barrierDismissible: false,
      backgroundColor: Color.fromRGBO(1, 1, 1, 0.5),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(21, 19, 21, 28.5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          //标题
          Text(
            "$title",
            textAlign: TextAlign.center,
            style: titleStyle == null
                ? TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontSize: 17,
                  )
                : titleStyle,
          ),
          SizedBox(
            height: 39.5,
          ),
          //内容
          Text(
            "$content",
            textAlign: TextAlign.center,
            style: contentStyle == null
                ? TextStyle(
                    color: Color.fromRGBO(51, 51, 51, 1),
                    fontSize: 14,
                  )
                : contentStyle,
          ),
          SizedBox(
            height: 42,
          ),
          //功能按钮
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 44,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    borderRadius: BorderRadius.circular(44 / 2),
                    border: Border.all(
                      width: 1,
                      color: Color.fromRGBO(255, 45, 85, 1),
                    ),
                  ),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "$cancel",
                      overflow: TextOverflow.ellipsis,
                      style: cancelStyle == null
                          ? TextStyle(
                              color: Color.fromRGBO(255, 45, 85, 1),
                              fontSize: 17,
                            )
                          : cancelStyle,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(44 / 2),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 16.5,
              ),
              Expanded(
                child: Container(
                  height: 44,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(255, 114, 81, 1),
                        Color.fromRGBO(255, 44, 96, 1),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(44 / 2),
                  ),
                  child: FlatButton(
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
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontSize: 17,
                            )
                          : confirmStyle,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(44 / 2),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
