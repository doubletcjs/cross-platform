import 'package:flutter/material.dart';
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
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      transitionDuration: Duration(milliseconds: 200),
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return this;
      },
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
          if (this.widget.handle != null) {
            this.widget.handle(isCancel, isCancel == true ? -1 : index);
          }

          Navigator.of(context).pop();
        },
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: isCancel == true
              ? this.widget.baseStyle
              : this.widget.cancelStyle,
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
    return GestureDetector(
      onTap: () {
        if (this.widget.barrierDismissible == true) {
          if (this.widget.handle != null) {
            this.widget.handle(true, -1);
          }

          Navigator.of(context).pop();
        }
      },
      child: Material(
        color: rgba(0, 0, 0, 0.2),
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 0,
              bottom: MediaQuery.of(context).padding.bottom,
              right: 0,
              height: isStringEmpty(this.widget.cancel) == false
                  ? (49.0 * (_maxRow + 1) + 10 * (_maxRow - 1) + 20)
                  : (49.0 * _maxRow + 10 * (_maxRow - 1)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Expanded(
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
