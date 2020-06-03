import 'package:flutter/material.dart';
import 'package:hksy_flutter/function/generaldialog.dart';
import 'package:hksy_flutter/public/public.dart';

class PaycodeInput extends StatefulWidget {
  kObjectFunctionBlock inputHandle;
  PaycodeInput({Key key, this.inputHandle}) : super(key: key);

  @override
  _PaycodeInputState createState() => _PaycodeInputState();

  show(BuildContext context) {
    GeneralDialog().show(
      context,
      containerContent: this,
      backgroundAlignment: Alignment.bottomCenter,
      borderRadius: BorderRadius.circular(8),
    );
  }
}

class _PaycodeInputState extends State<PaycodeInput> {
  TextEditingController _editingController = TextEditingController();
  int _currentIndex = 0;
  int _maxLength = 6;

  List<Widget> _inputFrame() {
    List<Widget> _list = [];
    for (var i = 0; i < _maxLength; i++) {
      _list.add(
        Container(
          width: 42,
          height: 42,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              color: _currentIndex == i
                  ? rgba(23, 96, 255, 1)
                  : rgba(21, 25, 54, 1),
              width: 0.5,
            ),
          ),
          child: _currentIndex > i
              ? Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12 / 2),
                  ),
                )
              : Container(),
        ),
      );
    }

    return _list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.fromLTRB(
          0,
          0,
          0,
          MediaQuery.of(context).viewInsets.bottom == 0
              ? 291
              : MediaQuery.of(context).viewInsets.bottom),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 19,
              ),
              Text(
                "请输入支付密码",
                style: TextStyle(
                  fontSize: 16,
                  color: rgba(68, 73, 88, 1),
                ),
              ),
              SizedBox(
                height: 39,
              ),
              Container(
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 0,
                      right: 0,
                      child: TextField(
                        autofocus: true,
                        controller: _editingController,
                        textAlign: TextAlign.center,
                        maxLength: 6,
                        keyboardType: TextInputType.number,
                        onChanged: (text) {
                          this.setState(() {
                            _currentIndex = text.length;
                            if (_currentIndex == _maxLength) {
                              Navigator.of(context).pop();
                              if (this.widget.inputHandle != null) {
                                var password = text;
                                Future.delayed(Duration(milliseconds: 600), () {
                                  this.widget.inputHandle(password);
                                  kLog("密码：" + password);
                                });
                              }
                            }
                          });
                        },
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: Wrap(
                        spacing: 8.5,
                        children: _inputFrame(),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 61,
              ),
            ],
          ),
          Positioned(
            top: 19,
            right: 15,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Image.asset(
                "images/close@3x.png",
                width: 21,
                height: 21,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
