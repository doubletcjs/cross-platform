import 'package:flutter/material.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';
import 'public.dart' show loadingGifPath;

final double width = 72;
final double height = 72;

class Loading {
  static BuildContext _context;
  static int _count = 0;

  static setContext (BuildContext context) => _context = context;

  static show () {
    if (_count == 0 && _context != null) {
      showDialog(context: _context, child: _LoadingDialog());
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

class _LoadingDialog extends Dialog {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: _LoadingImage(),
    );
  }
}

class _LoadingImage extends StatefulWidget {
  @override
  _LoadingImageState createState() => _LoadingImageState();
}

class _LoadingImageState extends State<_LoadingImage> with TickerProviderStateMixin {
  GifController _gifController;

  @override
  void initState() {
    _gifController = GifController(
      vsync: this,
      value: 0,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _gifController.repeat(min: 0, max: 98, period: Duration(milliseconds: 4000));
    });
    super.initState();
  }

  @override
  void dispose() {
    _gifController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width,
        height: height,
        child: GifImage(
          image: AssetImage(loadingGifPath),
          controller: _gifController,
          height: 36,
          width: 36,
        ),
      ),
    );
  }
}