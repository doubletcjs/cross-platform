import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hksy_flutter/function/generaldialog.dart';
import 'package:hksy_flutter/public/public.dart';

class HomeVersion extends StatelessWidget {
  const HomeVersion({Key key}) : super(key: key);

  show(BuildContext context) {
    GeneralDialog().show(
      context,
      backgroundPadding: EdgeInsets.fromLTRB(67.5, 0, 67.5, 0),
      backgroundAlignment: Alignment.center,
      borderRadius: BorderRadius.circular(7.5),
      containerContent: this,
      barrierDismissible: false,
    );
  }

  void _closeAlert(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Stack(
          children: <Widget>[
            Image.asset(
              "images/app_update@3x.png",
            ),
            Positioned(
              top: 7.5,
              right: 7.5,
              child: InkWell(
                child: Image.asset(
                  "images/ico_version_close@3x.png",
                  width: 20,
                  height: 20,
                ),
                onTap: () {
                  this._closeAlert(context);
                },
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.fromLTRB(21.5, 0, 21.5, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 2,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "2.0版本系统升级",
                  style: TextStyle(
                    fontSize: 15,
                    color: rgba(21, 25, 54, 1),
                  ),
                ),
              ),
              SizedBox(
                height: 14,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: ["·2.0版本用户体验升级", "·深色UI，全新体验", "·细节优化升级"].map(
                  (item) {
                    return Text(
                      item,
                      style: TextStyle(
                        fontSize: 13,
                        color: rgba(145, 152, 173, 1),
                      ),
                    );
                  },
                ).toList(),
              ),
              SizedBox(
                height: 28,
              ),
              Container(
                height: 32,
                margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: rgba(23, 96, 255, 1),
                  borderRadius: BorderRadius.circular(7.5),
                ),
                child: Text(
                  "升级新版本",
                  style: TextStyle(
                    fontSize: 13,
                    color: rgba(255, 255, 255, 1),
                  ),
                ),
              ),
              SizedBox(
                height: 14,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
