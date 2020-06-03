import 'package:flutter/material.dart';
import 'package:hksy_flutter/function/generaldialog.dart';
import 'package:hksy_flutter/public/public.dart';

class PaycodeInput extends StatefulWidget {
  PaycodeInput({Key key}) : super(key: key);

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

  List<Widget> _inputFrame() {
    List<Widget> _list = [];
    for (var i = 0; i < 6; i++) {
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
      padding:
          EdgeInsets.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
      margin: EdgeInsets.fromLTRB(
          0, 0, 0, MediaQuery.of(context).viewInsets.bottom),
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
                      ),
                    ),
                    Wrap(
                      spacing: 8.5,
                      children: _inputFrame(),
                    ),
                  ],
                ),
              ),
              // Stack(
              //   alignment: Alignment.center,
              //   children: <Widget>[
              //     TextField(
              //       autofocus: true,
              //       controller: _editingController,
              //     ),
              //   ],
              // ),
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
