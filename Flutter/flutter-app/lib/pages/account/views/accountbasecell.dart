import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../public/public.dart';

class AccountBaseCell extends StatelessWidget {
  const AccountBaseCell({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: rgba(255, 255, 255, 1),
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.fromLTRB(14, 10, 14, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              //头像
              ClipRRect(
                child: CachedNetworkImage(
                  imageUrl:
                      "https://upload.jianshu.io/users/upload_avatars/14072228/980d845b-ffda-4a82-8d4e-67ffe82ad13b?imageMogr2/auto-orient/strip|imageView2/1/w/96/h/96",
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(50 / 2),
              ),
              SizedBox(
                width: 12.5,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        //用户名
                        Expanded(
                          child: Text(
                            "优雅知性之心的人",
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
                        Text(
                          "07-12 22:30",
                          style: TextStyle(
                            fontSize: 11,
                            color: rgba(170, 170, 170, 1),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    //个性签名
                    Text(
                      "无利不起早",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: rgba(144, 144, 144, 1),
                      ),
                    ),
                  ],
                ),
              ),
              // Row(
              //   children: <Widget>[],
              // ),
              // Expanded(
              //   child: Text(
              //     "",
              //     style: TextStyle(
              //       fontSize: 11,
              //       color: rgba(170, 170, 170, 1),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
