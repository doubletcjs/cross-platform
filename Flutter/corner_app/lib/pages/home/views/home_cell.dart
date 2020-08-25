import 'package:corner_app/pages/store/home/store_page.dart';
import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

class HomeCell extends StatelessWidget {
  const HomeCell({Key key}) : super(key: key);

  // 主页
  void _homePage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return StorePage();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        this._homePage(context);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(16, 6, 16, 6),
        child: Row(
          children: [
            // 封面
            Container(
              child: networkImage(
                "",
                Size(50.5, 50.5),
                BorderRadius.circular(4),
              ),
              decoration: BoxDecoration(
                color: rgba(255, 255, 255, 1),
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 4),
                    blurRadius: 6,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 标题
                  Text(
                    "手机摄影",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: rgba(50, 50, 50, 1),
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  // 简介
                  Text(
                    "上得厨房，入得厅堂上得厨房",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: rgba(153, 153, 153, 1),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
