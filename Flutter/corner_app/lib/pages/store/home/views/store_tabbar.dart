import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StoreTabBar extends StatefulWidget {
  List<String> tabList;
  double height = 44;
  int tabIndex = 0;
  kObjectFunctionBlock tabSwitchHandle;
  StoreTabBar({
    Key key,
    this.tabList,
    this.height = 44,
    this.tabIndex = 0,
    this.tabSwitchHandle,
  }) : super(key: key);

  @override
  _StoreTabBarState createState() => _StoreTabBarState();
}

class _StoreTabBarState extends State<StoreTabBar>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      height: this.widget.height,
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
      ),
      decoration: BoxDecoration(
        color: rgba(255, 255, 255, 1),
        border: Border(
          top: BorderSide(
            width: 0.5,
            color: rgba(0, 0, 0, 0.1),
          ),
        ),
      ),
      child: this.widget.tabList != null
          ? Container(
              height: this.widget.height,
              width: MediaQuery.of(context).size.width,
              child: ListView.separated(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Center(
                    child: Container(
                      height: 20,
                      width: 50.5,
                      decoration: BoxDecoration(
                        color: this.widget.tabIndex == index
                            ? rgba(247, 246, 245, 1)
                            : rgba(255, 255, 255, 1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: FlatButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          setState(() {
                            this.widget.tabIndex = index;
                            if (this.widget.tabSwitchHandle != null) {
                              this.widget.tabSwitchHandle(index);
                            }
                          });
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          this.widget.tabList[index],
                          style: TextStyle(
                            fontSize: 13,
                            color: this.widget.tabIndex == index
                                ? rgba(50, 50, 50, 1)
                                : rgba(153, 153, 153, 1),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    width: 8,
                  );
                },
                itemCount: this.widget.tabList.length,
              ),
            )
          : Container(),
    );
  }
}
