import 'package:flutter/material.dart';
import 'package:ideaclass/public/public.dart';

class HomeBottomSheet extends StatefulWidget {
  kVoidFunctionBlock closeHandle;
  kObjectFunctionBlock selectHandle;

  HomeBottomSheet({this.closeHandle, this.selectHandle});

  @override
  _HomeBottomSheetState createState() => _HomeBottomSheetState();

  void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: rgba(0, 0, 0, 0),
      builder: (context) {
        return this;
      },
    );
  }
}

class _HomeBottomSheetState extends State<HomeBottomSheet> {
  List<String> _list = [
    "抽奖",
    "抢红包",
    "签到",
    "二维码",
  ];
  List<String> _iconList = [
    "icon-choujiang",
    "icon-qianghongbao",
    "icon-qiandao",
    "icon-erweima",
  ];

  void _closeBottomSheet() {
    Navigator.of(context).pop();
    Future.delayed(
      Duration(milliseconds: 400),
      () {
        if (this.widget.closeHandle != null) {
          this.widget.closeHandle();
        }
      },
    );
  }

  void _bottomSheetSelect(index) {
    Navigator.of(context).pop();
    Future.delayed(
      Duration(milliseconds: 400),
      () {
        if (this.widget.selectHandle != null) {
          this.widget.selectHandle("${_list[index]}");
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        color: rgba(0, 0, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
                padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: _list.length,
                  padding: EdgeInsets.zero,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  itemBuilder: (content, index) {
                    return Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: buttonWidget(
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "images/${_iconList[index]}@3x.png",
                              width: 37,
                              height: 37,
                            ),
                            SizedBox(
                              height: 11,
                            ),
                            Text(
                              "${_list[index]}",
                              style: TextStyle(
                                fontSize: 11,
                                color: rgba(23, 23, 23, 1),
                              ),
                            ),
                          ],
                        ),
                        context,
                        onTap: () {
                          this._bottomSheetSelect(index);
                        },
                      ),
                    );
                  },
                ),
              ),
              onTap: () {},
            ),
            SizedBox(
              height: 13,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(
                  12, 0, 12, 12 + MediaQuery.of(context).padding.bottom),
              height: 49,
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "取消",
                        style: TextStyle(
                          color: rgba(24, 159, 251, 1),
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    this._closeBottomSheet();
                  },
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        this._closeBottomSheet();
      },
    );
  }
}
