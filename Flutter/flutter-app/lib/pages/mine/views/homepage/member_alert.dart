import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import '../../certification.dart';
import '../../../../public/public.dart';
import '../../../function/general_dialog.dart';
import 'upgrade_alert.dart';

class MemberAlert extends StatelessWidget {
  bool manCustom = false; //男性用户提示样式
  String customContent = "";
  MemberAlert({
    Key key,
    this.manCustom = false,
    this.customContent = "",
  }) : super(key: key);

  show(BuildContext context) {
    GeneralDialog().show(
      context,
      backgroundPadding: EdgeInsets.fromLTRB(37, 0, 37, 0),
      backgroundAlignment: Alignment.center,
      borderRadius: BorderRadius.circular(7),
      containerContent: this,
      barrierDismissible: false,
      backgroundColor: rgba(1, 1, 1, 0.5),
    );
  }

  //去认证
  void _goCertification(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return CertificationPage();
      }),
    );
  }

  //开通会员
  void _goUpgrade(BuildContext context) {
    Navigator.of(context).pop();
    UpgradeAlert().show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(20.5, 19, 20.5, 15.5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          //标题
          Text(
            "提示",
            style: TextStyle(
              color: rgba(0, 0, 0, 1),
              fontSize: 17,
            ),
          ),
          SizedBox(
            height: 39.5,
          ),
          //内容
          Text(
            manCustom == true
                ? ObjectUtil.isEmptyString(customContent) == true
                    ? "开通会员特权，无限畅聊"
                    : customContent
                : "视频认证后即可免费聊天\n如果不想认证，开通会员特权，无限畅聊。",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: rgba(51, 51, 51, 1),
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 42,
          ),
          manCustom == true
              ? Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: 44,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              rgba(255, 114, 81, 1),
                              rgba(255, 44, 96, 1),
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(44 / 2),
                        ),
                        child: FlatButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            this._goUpgrade(context);
                          },
                          child: Text(
                            "开通会员",
                            style: TextStyle(
                              color: rgba(255, 255, 255, 1),
                              fontSize: 17,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(44 / 2),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Row(
                  children: <Widget>[
                    //开通会员
                    Expanded(
                      child: Container(
                        height: 44,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              rgba(255, 114, 81, 1),
                              rgba(255, 44, 96, 1),
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(44 / 2),
                        ),
                        child: FlatButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            this._goUpgrade(context);
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "开通会员",
                                style: TextStyle(
                                  color: rgba(255, 255, 255, 1),
                                  fontSize: 17,
                                ),
                              ),
                              Text(
                                "免认证",
                                style: TextStyle(
                                  color: rgba(255, 255, 255, 1),
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(44 / 2),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 17.5,
                    ),
                    //认证
                    Expanded(
                      child: Container(
                        height: 44,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: rgba(255, 45, 85, 1),
                          ),
                          borderRadius: BorderRadius.circular(44 / 2),
                        ),
                        child: FlatButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            this._goCertification(context);
                          },
                          child: Text(
                            "去认证",
                            style: TextStyle(
                              color: rgba(255, 45, 85, 1),
                              fontSize: 17,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(44 / 2),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
          SizedBox(
            height: manCustom == true ? 18 : 39.5,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "再想想",
              style: TextStyle(
                color: rgba(153, 153, 153, 1),
                fontSize: 17,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
