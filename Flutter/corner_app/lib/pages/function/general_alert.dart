import 'package:corner_app/pages/function/general_dialog.dart';
import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GeneralAlert extends StatelessWidget {
  String content;
  String cancel;
  String confirm;
  Color contentColor;
  Color cancelColor;
  Color confirmColor;
  kVoidFunctionBlock onConfirm;
  kVoidFunctionBlock onCancel;
  GeneralAlert({
    Key key,
    this.content,
    this.cancel,
    this.confirm,
    this.contentColor,
    this.cancelColor,
    this.confirmColor,
    this.onConfirm,
    this.onCancel,
  }) : super(key: key);

  show(BuildContext context) {
    if (content == null) {
      content = "";
    }

    if (cancel == null) {
      cancel = "取消";
    }

    if (confirm == null) {
      confirm = "确定";
    }

    if (contentColor == null) {
      contentColor = rgba(50, 50, 50, 1);
    }

    if (cancelColor == null) {
      cancelColor = rgba(50, 50, 50, 1);
    }

    if (confirmColor == null) {
      confirmColor = rgba(50, 50, 50, 1);
    }

    GeneralDialog().show(
      context,
      backgroundPadding: EdgeInsets.only(
        left: 27.5,
        right: 27.5,
      ),
      backgroundAlignment: Alignment.center,
      containerContent: this,
      barrierDismissible: false,
      backgroundColor: rgba(0, 0, 0, 0.4),
      borderRadius: BorderRadius.circular(8),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: rgba(255, 255, 255, 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(49.5, 52.5, 49.5, 45),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Text(
              "$content",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: contentColor,
              ),
            ),
          ),
          Container(
            color: rgba(0, 0, 0, 0.1),
            height: 0.5,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 59.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                    ),
                  ),
                  child: FlatButton(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();

                      Future.delayed(Duration(milliseconds: 400), () {
                        if (onCancel != null) {
                          onCancel();
                        }
                      });
                    },
                    child: Text(
                      "$cancel",
                      style: TextStyle(
                        fontSize: 16,
                        color: cancelColor,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 59.5,
                width: 0.5,
                color: rgba(0, 0, 0, 0.1),
              ),
              Expanded(
                child: Container(
                  height: 59.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: FlatButton(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();

                      Future.delayed(Duration(milliseconds: 400), () {
                        if (onConfirm != null) {
                          onConfirm();
                        }
                      });
                    },
                    child: Text(
                      "$confirm",
                      style: TextStyle(
                        fontSize: 16,
                        color: confirmColor,
                        fontWeight: FontWeight.normal,
                      ),
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
