import 'package:flutter/material.dart';
import 'package:repayment_flutter/public/public.dart';

class BillEditorialKeyboard extends StatefulWidget {
  String editorialNumber = "";
  kObjectFunctionBlock inputHandle;
  kVoidFunctionBlock saveHandle;
  kVoidFunctionBlock saveAndCreateHandle;
  BillEditorialKeyboard(
      {Key key,
      this.editorialNumber = "",
      this.inputHandle,
      this.saveHandle,
      this.saveAndCreateHandle})
      : super(key: key);

  @override
  _BillEditorialKeyboardState createState() => _BillEditorialKeyboardState();
}

class _BillEditorialKeyboardState extends State<BillEditorialKeyboard> {
  int _maxLenght = 10;

  void _selectNumber(String number) {
    String currentNumber = this.widget.editorialNumber;
    if (number == "*") {
      if (currentNumber.length >= 1) {
        setState(() {
          this.widget.editorialNumber = this
              .widget
              .editorialNumber
              .substring(0, currentNumber.length - 1);

          _maxLenght = 10;
        });
      }
    } else {
      if (currentNumber.contains(".")) {
        if (number == ".") {
          number = "";
        }

        if (_maxLenght == 10) {
          setState(() {
            _maxLenght =
                currentNumber.length + 2 > 10 ? 10 : currentNumber.length + 2;
          });
        }
      }

      if (this.widget.editorialNumber.length < _maxLenght) {
        setState(() {
          this.widget.editorialNumber = this.widget.editorialNumber + number;
        });
      }
    }

    if (this.widget.inputHandle != null) {
      this.widget.inputHandle(this.widget.editorialNumber);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding:
          EdgeInsets.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Container(
              color: rgba(249, 249, 249, 1),
              child: Wrap(
                spacing: 1, //主轴上子控件的间距
                runSpacing: 1,
                children: [
                  "1",
                  "2",
                  "3",
                  "4",
                  "5",
                  "6",
                  "7",
                  "8",
                  "9",
                  ".",
                  "0",
                  "*"
                ].map(
                  (number) {
                    return buttonWidget(
                      Container(
                        width:
                            (MediaQuery.of(context).size.width - 84 - 1 * 3) /
                                3.0,
                        height: (88 * 2 - 1 * 3) / 4.0,
                        alignment: Alignment.center,
                        child: number == "*"
                            ? Image.asset(
                                "images/keyboard_delete.png",
                                fit: BoxFit.fitHeight,
                                height: 18,
                              )
                            : Text(
                                number,
                                style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                      ),
                      context,
                      onTap: () {
                        this._selectNumber(number);
                      },
                      color: Colors.white,
                    );
                  },
                ).toList(),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              buttonWidget(
                Container(
                  width: 84,
                  height: 88,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "保存",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "再记",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                context,
                onTap: () {
                  if (this.widget.saveHandle != null) {
                    this.widget.saveHandle();
                  }
                },
                color: Colors.white,
              ),
              buttonWidget(
                Container(
                  width: 84,
                  height: 88,
                  alignment: Alignment.center,
                  child: Text(
                    "保存",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
                context,
                onTap: () {
                  if (this.widget.saveAndCreateHandle != null) {
                    this.widget.saveAndCreateHandle();
                  }
                },
                color: Colors.yellow,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
