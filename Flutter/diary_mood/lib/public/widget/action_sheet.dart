import 'package:diary_mood/public/public.dart';
import 'package:diary_mood/public/widget/general_dialog.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ActionSheet extends StatelessWidget {
  List<String> titles = [];
  List<kVoidFunctionBlock> actions = [];
  ActionSheet({
    Key key,
    this.titles,
    this.actions,
  }) : super(key: key);

  show(BuildContext context) {
    GeneralDialog().show(
      context,
      backgroundPadding: EdgeInsets.zero,
      backgroundAlignment: Alignment.bottomCenter,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      containerContent: this,
      barrierDismissible: true,
      backgroundColor: rgba(0, 0, 0, 0.5),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return Container(
          width: orientation == Orientation.portrait
              ? MediaQuery.of(context).size.width
              : MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(
              bottom: 18 + MediaQuery.of(context).padding.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: titles.map((title) {
              int index = titles.indexOf(title);
              return Container(
                height: 50,
                decoration: BoxDecoration(
                  border: index == titles.length - 1
                      ? Border(bottom: BorderSide.none)
                      : Border(
                          bottom: BorderSide(
                            color: rgba(237, 237, 237, 1),
                            width: 0.3,
                          ),
                        ),
                ),
                child: InkWell(
                  borderRadius: index == 0
                      ? BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        )
                      : BorderRadius.zero,
                  child: Center(
                    child: Text(
                      "$title",
                      style:
                          TextStyle(color: rgba(51, 51, 51, 1), fontSize: 18),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();

                    Future.delayed(Duration(milliseconds: 400), () {
                      kVoidFunctionBlock action = actions[index];
                      if (action != null) {
                        action();
                      }
                    });
                  },
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
