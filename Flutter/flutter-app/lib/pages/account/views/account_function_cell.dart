import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import '../../mine/mine_homepage.dart';
import '../../../public/public.dart';

class AccountFunctionCell extends StatefulWidget {
  Map account = {}; //账号信息 头像、用户名、性别、年龄、会员状态、个性签名。距离、在线状态（上次在线时间）、联系方式
  String custom; //自定义文字，为空显示个性签名
  kVoidFunctionBlock tapHandle;

  AccountFunctionCell({
    Key key,
    this.account,
    this.custom,
    this.tapHandle,
  }) : super(key: key);

  @override
  _AccountFunctionCellState createState() => _AccountFunctionCellState();
}

class _AccountFunctionCellState extends State<AccountFunctionCell> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: rgba(255, 255, 255, 1),
      child: InkWell(
        onTap: this.widget.tapHandle == null
            ? () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    return MineHomePage(
                      userId: "${this.widget.account['id']}",
                    );
                  }),
                );
              }
            : () {
                this.widget.tapHandle();
              },
        child: Container(
          padding: EdgeInsets.fromLTRB(13.5, 10, 14.5, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  //头像
                  ClipRRect(
                    child: CachedNetworkImage(
                      placeholder: (context, url) {
                        return Image.asset(
                          "images/placeholder_mini@3x.png",
                          width: 67,
                          height: 67,
                          fit: BoxFit.cover,
                        );
                      },
                      imageUrl: (this.widget.account != null &&
                              this.widget.account["avatar"] != null)
                          ? this.widget.account["avatar"]
                          : "",
                      width: 67,
                      height: 67,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(67 / 2),
                  ),
                  //认证标志
                  (this.widget.account != null &&
                          this.widget.account["audit_status"] == 3)
                      ? Positioned(
                          bottom: 0,
                          right: 0,
                          child: Image.asset(
                            "images/renzheng_icon@3x.png",
                            width: 16,
                            height: 16,
                          ),
                        )
                      : Container(),
                ],
              ),
              SizedBox(
                width: 11,
              ),
              Expanded(
                child: Container(
                  height: 70,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          SizedBox(
                            height: 3,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              //用户名
                              Expanded(
                                child: Text(
                                  (this.widget.account != null &&
                                          this.widget.account["nickname"] !=
                                              null)
                                      ? this.widget.account["nickname"]
                                      : "",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: rgba(18, 18, 18, 1),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              //公里数+上线天数或在线
                              Row(
                                children: <Widget>[
                                  Text(
                                    (this.widget.account != null &&
                                            this.widget.account["distance"] !=
                                                null)
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
                                                    BorderRadius.circular(
                                                        5 / 2),
                                              ),
                                            ),
                                          ],
                                        )
                                      : //最近活跃时间
                                      (this.widget.account != null &&
                                              this.widget.account[
                                                      "human_active_at"] !=
                                                  null)
                                          ? Text(
                                              ObjectUtil.isEmptyString(this
                                                              .widget
                                                              .account[
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
                            ],
                          ),
                          SizedBox(
                            height: 2.5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  //性别 男 rgba(0, 199, 245, 1) 女 rgba(255, 95, 125, 1)
                                  Container(
                                    padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
                                    decoration: BoxDecoration(
                                      color: this.widget.account != null &&
                                              this.widget.account["sex"] == 1
                                          ? rgba(0, 199, 245, 1)
                                          : rgba(255, 95, 125, 1),
                                      borderRadius:
                                          BorderRadius.circular(14 / 2),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        //性别图标
                                        Image.asset(
                                          this.widget.account != null &&
                                                  this.widget.account["sex"] ==
                                                      1
                                              ? "images/man@3x.png"
                                              : "images/woman@3x.png",
                                          width: 5,
                                          height: 7.5,
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Text(
                                          (this.widget.account != null &&
                                                  this.widget.account["age"] !=
                                                      null)
                                              ? "${this.widget.account["age"]}"
                                              : "0",
                                          style: TextStyle(
                                            fontSize: 9,
                                            color: rgba(255, 255, 255, 1),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  //是否会员
                                  this.widget.account != null &&
                                          this.widget.account["vip_type"] == 1
                                      ? Image.asset(
                                          "images/member@3x.png",
                                          width: 16,
                                          height: 16,
                                        )
                                      : Container(),
                                ],
                              ),
                              //绑定平台
                              Row(
                                children: <Widget>[
                                  this.widget.account != null &&
                                          this.widget.account["has_tel"] == true
                                      ? Container(
                                          padding:
                                              EdgeInsets.fromLTRB(5, 0, 0, 0),
                                          child: Image.asset(
                                            "images/contact_mobile@3x.png",
                                            width: 14,
                                            height: 14,
                                          ),
                                        )
                                      : Container(),
                                  this.widget.account != null &&
                                          this.widget.account["has_wechat"] ==
                                              true
                                      ? Container(
                                          padding:
                                              EdgeInsets.fromLTRB(5, 0, 0, 0),
                                          child: Image.asset(
                                            "images/WECHAT@3x.png",
                                            width: 14,
                                            height: 14,
                                          ),
                                        )
                                      : Container(),
                                  this.widget.account != null &&
                                          this.widget.account["has_qq"] == true
                                      ? Container(
                                          padding:
                                              EdgeInsets.fromLTRB(5, 0, 0, 0),
                                          child: Image.asset(
                                            "images/QQ@3x.png",
                                            width: 14,
                                            height: 14,
                                          ),
                                        )
                                      : Container(),
                                  this.widget.account != null &&
                                          this.widget.account["has_douyin"] ==
                                              true
                                      ? Container(
                                          padding:
                                              EdgeInsets.fromLTRB(5, 0, 0, 0),
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
                        ],
                      ),
                      Container(
                        height: 19,
                        child: Text(
                          ObjectUtil.isEmptyString(this.widget.custom) == true
                              ? (this.widget.account != null &&
                                      this.widget.account["signature"] != null)
                                  ? this.widget.account["signature"]
                                  : ""
                              : this.widget.custom,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
                            color: rgba(144, 144, 144, 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
