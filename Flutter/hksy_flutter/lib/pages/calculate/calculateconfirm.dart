import 'package:flutter/material.dart';
import 'package:hksy_flutter/function/generaldialog.dart';
import 'package:hksy_flutter/public/public.dart';

class CalculateConfirm extends StatefulWidget {
  kVoidFunctionBlock confirmHandle;
  CalculateConfirm({Key key, this.confirmHandle}) : super(key: key);

  @override
  _CalculateConfirmState createState() => _CalculateConfirmState();

  show(BuildContext context) {
    GeneralDialog().show(
      context,
      containerContent: this,
      backgroundAlignment: Alignment.bottomCenter,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
    );
  }
}

class _CalculateConfirmState extends State<CalculateConfirm> {
  List<String> _itemList = [
    "可兑换存储器T数",
    "抵扣HKC",
    "当前可用HKC",
  ];

  List<String> _menuItems = [
    "华科闪云存储器2T",
    "华科闪云存储器6T",
    "华科闪云存储器12T",
  ];

  String _currentMenuItem = "2";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 34.5,
          ),
          Text(
            "确认兑换",
            style: TextStyle(
              fontSize: 18,
              color: rgba(51, 51, 51, 1),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
            child: Column(
              children: _itemList.map(
                (item) {
                  var index = _itemList.indexOf(item);
                  return Container(
                    height: 61,
                    decoration: BoxDecoration(
                      border: index < _itemList.length - 1
                          ? Border(
                              bottom: BorderSide(
                                color: rgba(145, 152, 173, 1),
                                width: 0.5,
                              ),
                            )
                          : Border(),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          item,
                          style: TextStyle(
                            fontSize: 15,
                            color: rgba(51, 51, 51, 1),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        index == 0
                            ? Row(
                                children: <Widget>[
                                  Text(
                                    "华科闪云存储器$_currentMenuItem" + "T",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: rgba(51, 51, 51, 1),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  PopupMenuButton(
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (context) {
                                      return _menuItems.map((item) {
                                        int index = _menuItems.indexOf(item);
                                        return PopupMenuItem(
                                          value: index == 0
                                              ? "2"
                                              : index == 1 ? "6" : "12",
                                          child: Text(
                                            item,
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: rgba(51, 51, 51, 1),
                                            ),
                                          ),
                                        );
                                      }).toList();
                                    },
                                    onSelected: (value) {
                                      setState(() {
                                        _currentMenuItem = value;
                                      });
                                    },
                                  )
                                ],
                              )
                            : Text(
                                item,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: rgba(51, 51, 51, 1),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ],
                    ),
                  );
                },
              ).toList(),
            ),
          ),
          SizedBox(
            height: 86.5,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(21, 0, 21, 0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 49,
                    decoration: BoxDecoration(
                      color: rgba(235, 237, 240, 1),
                      borderRadius: BorderRadius.circular(7.5),
                    ),
                    child: FlatButton(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.5),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "取消",
                        style: TextStyle(
                          fontSize: 15,
                          color: rgba(145, 152, 173, 1),
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 12.5,
                ),
                Expanded(
                  child: Container(
                    height: 49,
                    decoration: BoxDecoration(
                      color: rgba(23, 96, 255, 1),
                      borderRadius: BorderRadius.circular(7.5),
                    ),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Future.delayed(Duration(milliseconds: 400), () {
                          if (this.widget.confirmHandle != null) {
                            this.widget.confirmHandle();
                          }
                        });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.5),
                      ),
                      child: Text(
                        "购买",
                        style: TextStyle(
                          fontSize: 15,
                          color: rgba(255, 255, 255, 1),
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 34.5,
          ),
        ],
      ),
    );
  }
}
