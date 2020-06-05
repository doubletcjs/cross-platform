import 'package:flutter/material.dart';
import 'package:hksy_flutter/function/generaldialog.dart';
import 'package:hksy_flutter/public/public.dart';

typedef kActionSheetBlock = void Function(bool isCancel, int index);

class ActionSheet extends StatefulWidget {
  String cancel = "";
  List<String> titles;
  TextStyle cancelStyle;
  TextStyle baseStyle;
  bool barrierDismissible = true;
  kActionSheetBlock handle;

  ActionSheet({
    Key key,
    this.cancel = "",
    this.titles,
    this.cancelStyle,
    this.baseStyle,
    this.barrierDismissible = true,
    this.handle,
  }) : super(key: key);

  @override
  _ActionSheetState createState() => _ActionSheetState();

  show(BuildContext context) {
    GeneralDialog().show(
      context,
      containerContent: this,
      backgroundAlignment: Alignment.bottomCenter,
      contentBackgroundColor: rgba(0, 0, 0, 0),
    );
  }
}

class _ActionSheetState extends State<ActionSheet> {
  int _maxRow = 6;

  Widget _cellWidget(BuildContext context, String text,
      {bool isCancel = false, int index = -1}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 49,
      margin: EdgeInsets.fromLTRB(12, isCancel == true ? 20 : 0, 12, 0),
      child: FlatButton(
        onPressed: () {
          Navigator.of(context).pop();

          Future.delayed(Duration(milliseconds: 400), () {
            if (this.widget.handle != null) {
              this.widget.handle(
                  isCancel,
                  isCancel == true
                      ? -1
                      : this.widget.titles.length - 1 - index);
            }
          });
        },
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: isCancel == true
              ? this.widget.baseStyle
              : this.widget.cancelStyle,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.5),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.5),
        color: Colors.white,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (this.widget.baseStyle == null) {
      this.widget.baseStyle = TextStyle(
        fontSize: 15,
        color: rgba(51, 51, 51, 1),
      );
    }

    if (this.widget.cancelStyle == null) {
      this.widget.cancelStyle = TextStyle(
        fontSize: 15,
        color: rgba(51, 51, 51, 1),
      );
    }

    setState(() {
      List<String> tempTitles = [];
      for (var title in this.widget.titles) {
        tempTitles.insert(0, title);
      }

      this.widget.titles = tempTitles;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: this.widget.titles.length < _maxRow
              ? (49.0 * this.widget.titles.length +
                  10 * (this.widget.titles.length - 1))
              : (49.0 * _maxRow + 10 * (_maxRow - 1)),
          child: ListView.separated(
            itemBuilder: (context, index) {
              return _cellWidget(
                context,
                this.widget.titles[index],
                index: index,
              );
            },
            separatorBuilder: (context, index) {
              return Container(
                height: 10,
              );
            },
            itemCount: this.widget.titles.length,
            reverse: true,
            padding: EdgeInsets.zero,
            physics: this.widget.titles.length > 4
                ? AlwaysScrollableScrollPhysics()
                : NeverScrollableScrollPhysics(),
          ),
        ),
        isStringEmpty(this.widget.cancel) == false
            ? _cellWidget(
                context,
                this.widget.cancel,
                isCancel: true,
              )
            : Container(),
        SizedBox(
          height: MediaQuery.of(context).padding.bottom,
        ),
      ],
    );
  }
}
