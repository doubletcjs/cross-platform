import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class TempPage extends StatefulWidget {
  TempPage({Key key}) : super(key: key);

  @override
  _TempPageState createState() => _TempPageState();
}

class _TempPageState extends State<TempPage>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin,
        WidgetsBindingObserver {
  int _stateSecond = 0;
  bool _isReversePhase = false;
  AnimationController _controller;
  Animation _animation;
  double _zeroAngle = 0;
  Timer _timerPeriodic;

  Widget _clipRectText(_value, _alignment) {
    var _tempValue = _value;
    if (_tempValue > 59) {
      _tempValue = 0;
    }

    return ClipRect(
      child: Align(
        alignment: _alignment,
        heightFactor: 0.5,
        child: Container(
          alignment: Alignment.center,
          constraints: BoxConstraints(
            minHeight: 120,
            maxWidth: 120,
          ),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
          child: Text(
            "${_tempValue < 10 ? ('0' + '$_tempValue') : _tempValue}",
            style: TextStyle(
              fontSize: 80,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  void _stopTimer() {
    if (_timerPeriodic != null && _timerPeriodic.isActive) {
      setState(() {
        _timerPeriodic.cancel();
        _timerPeriodic = null;
      });
    }

    setState(() {
      _isReversePhase = false;
      _stateSecond = DateTime.now().second;
    });
  }

  void _startTimer() {
    _stopTimer();

    setState(() {
      _stateSecond = DateTime.now().second;
      _controller.forward();

      _timerPeriodic = Timer.periodic(Duration(seconds: 1), (timer) {
        //1s 回调一次
        print("$_stateSecond");
        _controller.forward();
      });
    });
  }

  void _initAnimationController() {
    if (_controller == null) {
      _controller = AnimationController(
          duration: Duration(milliseconds: 450), vsync: this);
      _controller
        ..addStatusListener((status) {
          //动画正向执行,正向执行结束后进行反向执行
          if (status == AnimationStatus.completed) {
            _controller.reverse();
            _isReversePhase = true;
          }

          //动画反向执行，反向执行结束后一次动画翻转周期结束。当前数字更新到最新的
          if (status == AnimationStatus.dismissed) {
            _isReversePhase = false;
            if (_stateSecond >= 59) {
              _stateSecond = 0;
            } else {
              _stateSecond += 1;
            }
          }
        })
        ..addListener(() {
          setState(() {});
        });
    }
  }

  @override
  void initState() {
    this._initAnimationController();
    //动画数值使用0度角到90度角
    _animation = Tween(begin: _zeroAngle, end: pi / 2).animate(_controller);

    super.initState();

    this._startTimer();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("--" + state.toString());
    switch (state) {
      case AppLifecycleState.inactive: // 处于这种状态的应用程序应该假设它们可能在任何时候暂停。
        break;
      case AppLifecycleState.resumed: // 应用程序可见，前台
        this._startTimer();
        break;
      case AppLifecycleState.paused: // 应用程序不可见，后台
        this._stopTimer();
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: <Widget>[
                //下一个数字的上部分
                this._clipRectText(
                  _stateSecond + 1,
                  Alignment.topCenter,
                ),
                //当前数字的上部分，当_isReversePhase为true时和平面呈90度角相当于隐藏
                Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.006)
                    ..rotateX(_isReversePhase ? pi / 2 : _animation.value),
                  alignment: Alignment.bottomCenter,
                  child: this._clipRectText(
                    _stateSecond,
                    Alignment.topCenter,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 1.0),
            ),
            Stack(
              children: <Widget>[
                //当前数字的下部分
                this._clipRectText(
                  _stateSecond,
                  Alignment.bottomCenter,
                ),
                //下个数字的下部分，当_isReversePhase为true时才执行翻转动画否则一直和平面呈90度
                Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.006)
                    ..rotateX(_isReversePhase ? -_animation.value : pi / 2),
                  alignment: Alignment.topCenter,
                  child: this._clipRectText(
                    _stateSecond + 1,
                    Alignment.bottomCenter,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
