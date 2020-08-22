import 'package:flutter/material.dart';
import './general_dialog.dart';

class ProgressHud extends StatefulWidget {
  ProgressHud({Key key}) : super(key: key);

  @override
  _ProgressHudState createState() => _ProgressHudState();

  String message;
  Color progressColor = Colors.grey;
  Color progressBackgroundColor = Colors.white;
  Color coverColor = Color.fromRGBO(0, 0, 0, 0.4);
  Duration delayed = Duration(milliseconds: 2000);
  TextStyle loadingTextStyle = TextStyle(
      fontSize: 13.0,
      color: Colors.black87,
      fontWeight: FontWeight.normal,
      decoration: TextDecoration.none);

  static ProgressHud _currentHud;
  static BuildContext _context;
  static hide() {
    Navigator.of(_context).pop();
    _currentHud = null;
    _context = null;
  }

  static show(BuildContext context) {
    try {
      if (_currentHud != null) {
        ProgressHud.hide();
      }

      ProgressHud hud = ProgressHud();
      _currentHud = hud;
      _context = context;

      GeneralDialog().show(
        context,
        backgroundPadding: EdgeInsets.zero,
        backgroundAlignment: Alignment.center,
        borderRadius: BorderRadius.circular(7),
        containerContent: _currentHud,
        barrierDismissible: false,
        backgroundColor: Color.fromRGBO(1, 1, 1, 0.5),
        contentBackgroundColor: Color.fromRGBO(0, 0, 0, 0),
      );
    } catch (e) {
      _currentHud = null;
      _context = null;
    }
  }
}

class _ProgressHudState extends State<ProgressHud> {
  String loadingMessage = 'loading ...';
  String message;
  Color progressColor = Colors.grey;
  Color progressBackgroundColor = Colors.white;
  Color coverColor = Color.fromRGBO(0, 0, 0, 0.4);
  Duration delayed = Duration(milliseconds: 2000);
  TextStyle loadingTextStyle = TextStyle(
      fontSize: 13.0,
      color: Colors.black87,
      fontWeight: FontWeight.normal,
      decoration: TextDecoration.none);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: <Widget>[
          Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(progressColor),
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 70.0),
              child: Text(loadingMessage, style: loadingTextStyle),
            ),
          )
        ],
      ),
    );
  }
}
