import 'package:flutter/material.dart';
import 'package:focus_tick/pages/temp_page.dart';
import 'package:focus_tick/pages/tick_page.dart';

// ignore: must_be_immutable
class TickCell extends StatefulWidget {
  Map tick;
  TickCell({
    Key key,
    this.tick,
  }) : super(key: key);

  @override
  _TickCellState createState() => _TickCellState();
}

class _TickCellState extends State<TickCell> {
  @override
  Widget build(BuildContext context) {
    return this.widget.tick == null
        ? Container()
        : this.widget.tick["creation"] == true
            ? Stack(
                children: [
                  // 设置
                  // Positioned(
                  //   top: 6,
                  //   right: 6,
                  //   child: InkWell(
                  //     onTap: () {},
                  //     child: Icon(
                  //       Icons.settings,
                  //       size: 18,
                  //     ),
                  //   ),
                  // ),
                  InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {},
                    child: Center(
                      child: Icon(
                        Icons.add,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              )
            : InkWell(
                onLongPress: () {
                  print("object");
                },
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return TickPage();
                      },
                      fullscreenDialog: true,
                    ),
                  );
                },
                child: Stack(
                  children: [
                    // 更多操作
                    Positioned(
                      top: 0,
                      right: 6,
                      child: InkWell(
                        child: Icon(
                          Icons.more_horiz,
                          color: Colors.white,
                        ),
                        onTap: () {},
                      ),
                    ),
                    Positioned(
                      left: 4,
                      top: 4,
                      right: 4,
                      bottom: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // icon
                          Icon(
                            Icons.timer_rounded,
                            size: 24,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 14,
                          ),
                          // time
                          Text(
                            "10:11:12",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 14,
                          ),
                          // name
                          Text(
                            "们需要一个项目的列表来配合完成",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
  }
}
