import 'package:flutter/material.dart';
import 'package:repayment_flutter/pages/account/loginpage.dart';
import 'package:repayment_flutter/public/public.dart';

class MineHeader extends StatefulWidget {
  MineHeader({Key key}) : super(key: key);

  @override
  _MineHeaderState createState() => _MineHeaderState();
}

class _MineHeaderState extends State<MineHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kMainColor,
      height: 118,
      padding:
          EdgeInsets.fromLTRB(12, MediaQuery.of(context).padding.top, 12, 0),
      child: InkWell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ClipRRect(
              child: Image.asset(
                "images/user_head_default@3x.png",
                width: 44,
                height: 44,
              ),
              borderRadius: BorderRadius.circular(44 / 2),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                "请登录",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
            ),
          ],
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return LoginPage();
              },
            ),
          );
        },
      ),
    );
  }
}
