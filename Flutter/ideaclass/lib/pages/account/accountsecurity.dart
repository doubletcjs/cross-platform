import 'package:flutter/material.dart';
import 'package:ideaclass/pages/account/accountcertification.dart';
import 'package:ideaclass/pages/account/api/accountapi.dart';
import 'package:ideaclass/pages/account/bindmobile.dart';
import 'package:ideaclass/public/public.dart';

class AccountSecurityPage extends StatefulWidget {
  AccountSecurityPage({Key key}) : super(key: key);

  @override
  _AccountSecurityPageState createState() => _AccountSecurityPageState();
}

class _AccountSecurityPageState extends State<AccountSecurityPage> {
  Map _account = {};
  void _refreshAccount() {
    AccountApi().loadLocalAccount(
      (user) {
        setState(() {
          _account = user;
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();

    this._refreshAccount();
  }

  @override
  void didUpdateWidget(AccountSecurityPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    this._refreshAccount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "账户安全",
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 7,
          ),
          Container(
            height: 58,
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "手机号",
                      style: TextStyle(
                        fontSize: 14,
                        color: rgba(23, 23, 23, 1),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "已绑定",
                          style: TextStyle(
                            fontSize: 9,
                            color: rgba(136, 136, 136, 1),
                          ),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          _account["mobilePhone"] == null
                              ? ""
                              : "${_account["mobilePhone"].replaceRange(3, 7, "****")}",
                          style: TextStyle(
                            fontSize: 9,
                            color: kMainColor,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                buttonWidget(
                  Container(
                    width: 55,
                    height: 20,
                    alignment: Alignment.center,
                    child: Text(
                      "更改号码",
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  context,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return BindMobilePage();
                        },
                      ),
                    );
                  },
                  color: kMainColor,
                  radius: BorderRadius.circular(20 / 2),
                ),
              ],
            ),
          ),
          Container(
            height: 1,
          ),
          buttonWidget(
            Container(
              height: 37,
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "实名认证",
                    style: TextStyle(
                      fontSize: 14,
                      color: rgba(23, 23, 23, 1),
                    ),
                  ),
                  Image.asset(
                    "images/jiantou@3x.png",
                    fit: BoxFit.fitWidth,
                    width: 6,
                  ),
                ],
              ),
            ),
            context,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return CertificationPage();
                  },
                ),
              );
            },
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
