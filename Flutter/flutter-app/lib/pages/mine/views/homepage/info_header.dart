import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import '../../../../public/public.dart';

class InfoHeader extends StatefulWidget {
  bool isSelf = false;
  Map account;
  kVoidFunctionBlock contactHandle;
  InfoHeader({
    Key key,
    this.isSelf = false,
    this.account,
    this.contactHandle,
  }) : super(key: key);

  @override
  _InfoHeaderState createState() => _InfoHeaderState();
}

class _InfoHeaderState extends State<InfoHeader> {
  Size _fetchNameSize(String name) {
    Size _size = getTextSize(
      name,
      TextStyle(
        fontSize: 22,
        color: rgba(0, 0, 0, 1),
      ),
    );

    if (_size.width > 255) {
      _size = Size(255, _size.height);
    }

    return _size;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
      padding: EdgeInsets.fromLTRB(0, 14, 0, this.widget.isSelf ? 33 : 16),
      decoration: BoxDecoration(
        color: kMainBackgroundColor,
        border: Border(
          bottom: BorderSide(color: rgba(237, 237, 237, 1), width: 0.5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    //用户名
                    Container(
                      width:
                          _fetchNameSize("${this.widget.account['nickname']}")
                              .width,
                      child: Text(
                        "${this.widget.account['nickname']}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 22,
                          color: rgba(0, 0, 0, 1),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: this.widget.isSelf ? 0 : 4.5,
                    ),
                    this.widget.isSelf
                        ? Container()
                        : Container(
                            padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                //是否认证 V
                                this.widget.account["audit_status"] == 3
                                    ? Image.asset(
                                        "images/renzheng_icon@3x.png",
                                        width: 16,
                                        height: 16,
                                      )
                                    : Container(),
                                SizedBox(
                                  width: 4,
                                ),
                                //是否VIP 皇冠
                                this.widget.account["vip_type"] == 1
                                    ? Image.asset(
                                        "images/member@3x.png",
                                        width: 16,
                                        height: 16,
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                  ],
                ),
                SizedBox(
                  height: this.widget.isSelf ? 0 : 0.5,
                ),
                //距离、在线状态，本人不显示
                //公里数+上线天数或在线
                this.widget.isSelf
                    ? Container()
                    : Row(
                        children: <Widget>[
                          Text(
                            (this.widget.account != null &&
                                    this.widget.account["distance"] != null)
                                ? "${double.parse('${this.widget.account['distance']}').toStringAsFixed(2)}km"
                                : "",
                            style: TextStyle(
                              fontSize: 11,
                              color: rgba(170, 170, 170, 1),
                            ),
                          ),
                          //是否在线
                          (this.widget.account != null &&
                                  this.widget.account["is_active"] == 1)
                              ? Row(
                                  children: <Widget>[
                                    Text(
                                      " . 在线",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: rgba(170, 170, 170, 1),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Container(
                                      width: 5,
                                      height: 5,
                                      decoration: BoxDecoration(
                                        color: rgba(29, 211, 110, 1),
                                        borderRadius:
                                            BorderRadius.circular(5 / 2),
                                      ),
                                    ),
                                  ],
                                )
                              : //最近活跃时间
                              (this.widget.account != null &&
                                      this.widget.account["human_active_at"] !=
                                          null)
                                  ? Text(
                                      ObjectUtil.isEmptyString(
                                                  this.widget.account[
                                                      "human_active_at"]) ==
                                              false
                                          ? " . ${this.widget.account['human_active_at']}"
                                          : "",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: rgba(170, 170, 170, 1),
                                      ),
                                    )
                                  : Container(),
                        ],
                      ),
                SizedBox(
                  height: this.widget.isSelf ? 5 : 6.5,
                ),
                //性别，年龄 男 rgba(0, 199, 245, 1) 女 rgba(255, 95, 125, 1)
                Container(
                  padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
                  decoration: BoxDecoration(
                    color: this.widget.account != null &&
                            this.widget.account["sex"] == 1
                        ? rgba(0, 199, 245, 1)
                        : rgba(255, 95, 125, 1),
                    borderRadius: BorderRadius.circular(14 / 2),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      //性别图标
                      Image.asset(
                        this.widget.account["sex"] == 1
                            ? "images/man@3x.png"
                            : "images/woman@3x.png",
                        width: 5,
                        height: 7.5,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        "${this.widget.account["age"]}",
                        style: TextStyle(
                          fontSize: 9,
                          color: rgba(255, 255, 255, 1),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: this.widget.isSelf ? 0 : 8,
          ),
          this.widget.isSelf
              ? Container()
              : (this.widget.account["has_wechat"] == true ||
                  this.widget.account["has_qq"] == true ||
                  this.widget.account["has_tel"] == true ||
                  this.widget.account["has_douyin"] == true)
                  ? InkWell(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            "查看联系信息",
                            style: TextStyle(
                              fontSize: 13,
                              color: rgba(59, 59, 59, 1),
                            ),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          //绑定平台
                          Row(
                            children: <Widget>[
                              this.widget.account["has_tel"] == true
                                  ? Container(
                                      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                      child: Image.asset(
                                        "images/contact_mobile@3x.png",
                                        width: 14,
                                        height: 14,
                                      ),
                                    )
                                  : Container(),
                              this.widget.account["has_wechat"] == true
                                  ? Container(
                                      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                      child: Image.asset(
                                        "images/WECHAT@3x.png",
                                        width: 14,
                                        height: 14,
                                      ),
                                    )
                                  : Container(),
                              this.widget.account["has_qq"] == true
                                  ? Container(
                                      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                      child: Image.asset(
                                        "images/QQ@3x.png",
                                        width: 14,
                                        height: 14,
                                      ),
                                    )
                                  : Container(),
                              this.widget.account["has_douyin"] == true
                                  ? Container(
                                      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                      child: Image.asset(
                                        "images/contact_douyin@3x.png",
                                        width: 14,
                                        height: 14,
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ],
                      ),
                      onTap: () {
                        if (this.widget.contactHandle != null) {
                          this.widget.contactHandle();
                        }
                      },
                    )
                  : Container(),
        ],
      ),
    );
  }
}
