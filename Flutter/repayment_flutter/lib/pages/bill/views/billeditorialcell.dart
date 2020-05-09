import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repayment_flutter/pages/bill/bankselection.dart';
import 'package:repayment_flutter/public/public.dart';

class BillEditorialCell extends StatefulWidget {
  String item = "";
  String value = "";
  kObjectFunctionBlock editorialHandle;

  BillEditorialCell(
      {Key key, this.item = "", this.value = "", this.editorialHandle})
      : super(key: key);

  @override
  _BillEditorialCellState createState() => _BillEditorialCellState();
}

class _BillEditorialCellState extends State<BillEditorialCell> {
  TextEditingController _remarkEditingController;
  String _bankName = "";
  String _bankIcon = "";

  String _selectionString() {
    //   [
    //   "账单名称",
    //   "首次还款日",
    //   "还款期限",
    //   "还款周期",
    //   "备忘：不超过20字（选填）"
    // ]
    var valueString = "请选择";
    if (this.widget.value != null && this.widget.value.length > 0) {
      if (this.widget.item == "账单名称") {
      } else if (this.widget.item == "首次还款日") {
        DateTime _seletedDate = DateTime.parse(this.widget.value);
        valueString = _seletedDate.toString().split(" ").first;
      } else if (this.widget.item == "还款期限") {
        int _position = int.parse(this.widget.value);
        valueString = "${_position + 1}" + "期";
      } else if (this.widget.item == "还款周期") {
        List array = this.widget.value.split("|");
        List<String> _units = ["月", "天"];
        int _cyclePosition = 0;
        int _unitPosition = 0;
        if (array.length == 2) {
          _cyclePosition = int.parse(array[0]);
          _unitPosition = int.parse(array[1]);
        }

        valueString =
            "每" + "${_cyclePosition + 1}" + _units[_unitPosition] + "一期";
      } else if (this.widget.item.contains("备忘")) {
        _remarkEditingController =
            TextEditingController(text: this.widget.value);
      }
    }

    return valueString;
  }

  void _selectDate(BuildContext context) async {
    DateTime _seletedDate = DateTime.now();
    if (this.widget.value != null && this.widget.value.length > 0) {
      _seletedDate = DateTime.parse(this.widget.value);
    }

    DateTime _date = await showDatePicker(
      context: context,
      initialDate: _seletedDate == null ? DateTime.now() : _seletedDate,
      firstDate: DateTime.utc(1900),
      lastDate: DateTime.utc(DateTime.now().year + 1),
    );

    if (_date != null) {
      Future.delayed(
        Duration(milliseconds: 400),
        () {
          setState(() {
            _seletedDate = _date;
            this.widget.value = _seletedDate.toString().split(" ").first;
            if (this.widget.editorialHandle != null) {
              this.widget.editorialHandle(this.widget.value);
            }
          });
        },
      );
    }
  }

  void _selectLimit(BuildContext context) {
    List<String> _list = [];
    for (var i = 0; i < 500; i++) {
      _list.add("${i + 1}" + "期");
    }

    int _position = 0;
    if (this.widget.value != null && this.widget.value.length > 0) {
      _position = int.parse(this.widget.value);
    }
    FixedExtentScrollController _scrollController =
        FixedExtentScrollController(initialItem: _position);

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Colors.white,
          height: 44 + 200 + MediaQuery.of(context).padding.bottom,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                height: 44,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    buttonWidget(
                      Text(
                        "取消",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      context,
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    buttonWidget(
                      Text(
                        "确定",
                        style: TextStyle(
                          color: kMainColor,
                        ),
                      ),
                      context,
                      onTap: () {
                        Navigator.of(context).pop();

                        setState(() {
                          this.widget.value = "$_position";
                        });

                        if (this.widget.editorialHandle != null) {
                          this.widget.editorialHandle(this.widget.value);
                        }
                      },
                    ),
                  ],
                ),
              ),
              Container(
                height: 200,
                child: CupertinoPicker(
                  scrollController: _scrollController,
                  backgroundColor: Colors.white,
                  itemExtent: 36,
                  useMagnifier: true,
                  onSelectedItemChanged: (position) {
                    _position = position;
                  },
                  children: _list.map(
                    (value) {
                      return Container(
                        alignment: Alignment.center,
                        child: Text(
                          value,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _selectCycle(BuildContext context) {
    List<String> _list = [];
    for (var i = 0; i < 100; i++) {
      _list.add("每" + "${i + 1}");
    }
    List<String> _units = ["月", "天"];

    int _cyclePosition = 0;
    int _unitPosition = 0;
    if (this.widget.value != null && this.widget.value.length > 0) {
      List array = this.widget.value.split("|");
      if (array.length == 2) {
        _cyclePosition = int.parse(array[0]);
        _unitPosition = int.parse(array[1]);
      }
    }
    FixedExtentScrollController _cycleController =
        FixedExtentScrollController(initialItem: _cyclePosition);
    FixedExtentScrollController _unitController =
        FixedExtentScrollController(initialItem: _unitPosition);

    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Colors.white,
            height: 44 + 200 + MediaQuery.of(context).padding.bottom,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                  height: 44,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      buttonWidget(
                        Text(
                          "取消",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        context,
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      buttonWidget(
                        Text(
                          "确定",
                          style: TextStyle(
                            color: kMainColor,
                          ),
                        ),
                        context,
                        onTap: () {
                          Navigator.of(context).pop();

                          setState(() {
                            this.widget.value =
                                "$_cyclePosition" + "|" + "$_unitPosition";
                          });

                          if (this.widget.editorialHandle != null) {
                            this.widget.editorialHandle(this.widget.value);
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: CupertinoPicker(
                          scrollController: _cycleController,
                          itemExtent: 36,
                          useMagnifier: true,
                          backgroundColor: Colors.white,
                          onSelectedItemChanged: (position) {
                            _cyclePosition = position;
                          },
                          children: _list.map(
                            (value) {
                              return Container(
                                alignment: Alignment.center,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: CupertinoPicker(
                          scrollController: _unitController,
                          itemExtent: 36,
                          useMagnifier: true,
                          backgroundColor: Colors.white,
                          onSelectedItemChanged: (position) {
                            _unitPosition = position;
                          },
                          children: _units.map(
                            (value) {
                              return Container(
                                alignment: Alignment.center,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return this.widget.item.contains("备忘") == true
        ? Container(
            height: 60,
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            alignment: Alignment.center,
            color: Colors.white,
            child: TextField(
              controller: _remarkEditingController,
              onChanged: (text) {
                setState(() {
                  this.widget.value = text;
                  if (this.widget.editorialHandle != null) {
                    this.widget.editorialHandle(this.widget.value);
                  }
                });
              },
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
              decoration: InputDecoration(
                hintText: this.widget.item,
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
                hasFloatingPlaceholder: false,
                border: InputBorder.none,
              ),
            ),
          )
        : buttonWidget(
            Container(
              height: 60,
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  (this.widget.item == "账单名称" && _bankName.length > 0)
                      ? Row(
                          children: <Widget>[
                            Image.asset(
                              _bankIcon,
                              width: 26,
                              height: 26,
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Text(
                              _bankName,
                            ),
                          ],
                        )
                      : Text(
                          this.widget.item,
                        ),
                  Row(
                    children: <Widget>[
                      this.widget.item == "账单名称"
                          ? Text(
                              (_bankName != null && _bankName.length > 0)
                                  ? ""
                                  : "请选择",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            )
                          : Text(
                              _selectionString(),
                              style: TextStyle(
                                color: _selectionString() == "请选择"
                                    ? Colors.grey
                                    : Colors.black,
                              ),
                            ),
                      SizedBox(
                        width: 8,
                      ),
                      Image.asset(
                        "images/icon_arrow_right.png",
                        width: 8,
                        fit: BoxFit.fitWidth,
                        color: Colors.black45,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            context,
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());

              if (this.widget.item == "首次还款日") {
                this._selectDate(context);
              } else if (this.widget.item == "还款期限") {
                this._selectLimit(context);
              } else if (this.widget.item == "还款周期") {
                this._selectCycle(context);
              } else if (this.widget.item == "账单名称") {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return BankSelectionPage(
                        selectionHandle: (bankName, bankIcon) {
                          setState(() {
                            if (isStringEmpty(bankName) == false &&
                                isStringEmpty(bankIcon) == false) {
                              _bankName = bankName;
                              _bankIcon = bankIcon;

                              if (this.widget.editorialHandle != null) {
                                this.widget.editorialHandle(
                                    _bankName + "|" + _bankIcon);
                              }
                            }
                          });
                        },
                      );
                    },
                  ),
                );
              }
            },
            color: Colors.white,
          );
  }
}
