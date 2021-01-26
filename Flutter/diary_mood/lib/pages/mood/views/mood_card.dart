import 'package:diary_mood/public/public.dart';
import 'package:flutter/material.dart';

class MoodBaseCard extends StatelessWidget {
  const MoodBaseCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 15, 0, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 用户信息
          _MoodCardAccount(),
          // 内容
          Padding(
            padding: EdgeInsets.only(top: 18, right: 15),
            child: Text(
              "今日下午，路透社援引两名直接知情人士的消息称，华为正在就出售其高端智能手机品牌 P 和 Mate 进行初期谈判，此举可能使该公司最终退出高端智能手机制造业务。消息人士指出，”华为与上海市政府支持的投资公司牵头的财团就出售手机品牌事宜已协商了数月时间。由于商谈保密，消息人士不愿具名。”",
              style: TextStyle(
                fontSize: 17,
                color: rgba(34, 34, 34, 1),
              ),
            ),
          ),
          // 图片
          // 话题
          Padding(
            padding: EdgeInsets.only(top: 18, right: 15),
            child: FlatButton(
              onPressed: () {},
              onLongPress: () {},
              minWidth: 0,
              height: 26,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: EdgeInsets.only(left: 8, right: 8),
              color: rgba(234, 236, 240, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(26 / 2),
              ),
              child: Text(
                "#话题#",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MoodCardAccount extends StatelessWidget {
  const _MoodCardAccount({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Row(
            children: [
              // 头像
              extendedNetworkImage(
                "",
                Size(44, 44),
                BorderRadius.circular(44 / 2),
              ),
              SizedBox(
                width: 12,
              ),
              // 用户名、发布日期
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 用户名
                    Text(
                      "用户名",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        color: rgba(18, 18, 18, 1),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    // 发布日期
                    Text(
                      "05-13 16:40",
                      style: TextStyle(
                        fontSize: 12,
                        color: rgba(170, 170, 170, 1),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 8,
        ),
        // 点赞
        FlatButton(
          onPressed: () {},
          minWidth: 0,
          height: 26,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 0.2, color: Colors.black12),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(26 / 2),
              bottomLeft: Radius.circular(26 / 2),
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 8,
              ),
              // 图标
              Icon(
                Icons.favorite_border, //favorite
                size: 18,
                color: rgba(68, 68, 68, 1), //kMainColor
              ),
              SizedBox(
                width: 4,
              ),
              // 点赞数
              Text(
                "0",
                style: TextStyle(
                  fontSize: 14,
                  color: rgba(99, 99, 99, 1),
                ),
              ),
              SizedBox(
                width: 22,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
