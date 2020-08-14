import 'package:flutter/material.dart';
import 'public.dart' show loadingGifPath;

final double width = 72;
final double height = 72;

class Loading {
  static BuildContext _context;
  static int _count = 0;

  static setContext (BuildContext context) => _context = context;

  static show () {
    if (_count == 0 && _context != null) {
      showDialog(context: _context, child: LoadingDialog(loadingGifPath, width, height));
    }

    _count++;
  }

  static hide () {
    _count -= 1;

    if (_count == 0) {
      Navigator.of(_context).pop();
    }

    // 当前 showDialog 并未执行，恢复默认值
    if (_count == -1) {
      _count = 0;
    }
  }
}

class LoadingDialog extends Dialog {
  String _imgUrl = "";
  double _width = 80;
  double _height = 80;

  LoadingDialog(this._imgUrl, this._width, this._height);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          width: _width,
          height: _height,
          child: Image.asset(_imgUrl, width: _width, height: _height,),
        ),
      ),
    );
  }
}