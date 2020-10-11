import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TickFlipCell extends StatefulWidget {
  double tickFlipWidth = 150;
  DateTime dateTime;
  int tickType = 0; //0 秒 1 分 2 时

  TickFlipCell({
    Key key,
    @required this.dateTime,
    // ignore: invalid_required_named_param
    @required this.tickType = 0,
    this.tickFlipWidth = 150,
  }) : super(key: key);

  @override
  _TickFlipCellState createState() => _TickFlipCellState();
}

class _TickFlipCellState extends State<TickFlipCell>
    with SingleTickerProviderStateMixin {
  bool _isReversePhase = false;
  AnimationController _controller;
  Animation _animation;
  Timer _timerPeriodic;

  bool _filpTick = false;

  Widget _clipRectText(int value, Alignment alignment) {
    var _tempValue = value;
    if (this.widget.tickType == 2) {
      if (_tempValue > 23) {
        _tempValue = 0;
      }
    } else {
      if (_tempValue > 59) {
        _tempValue = 0;
      }
    }

    return ClipRect(
      child: Align(
        alignment: alignment,
        heightFactor: 0.5,
        child: Container(
          width: this.widget.tickFlipWidth,
          height: this.widget.tickFlipWidth,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color.fromRGBO(21, 21, 21, 1),
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          child: Text(
            "${_tempValue < 10 ? ('0' + '$_tempValue') : _tempValue}",
            style: TextStyle(
              fontSize: 93,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
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

          if (status == AnimationStatus.forward) {
            if (this.widget.tickType == 1 && this.widget.dateTime.second > 58) {
              _filpTick = true;
            }

            if (this.widget.tickType == 2 &&
                this.widget.dateTime.second > 58 &&
                this.widget.dateTime.minute >= 59) {
              _filpTick = true;
            }
          }

          //动画反向执行，反向执行结束后一次动画翻转周期结束。当前数字更新到最新的
          if (status == AnimationStatus.dismissed) {
            _isReversePhase = false;

            this.widget.dateTime =
                this.widget.dateTime.add(Duration(seconds: 1));

            if (this.widget.tickType == 1 && _filpTick == true) {
              _filpTick = false;
            }

            if (this.widget.tickType == 2 && _filpTick == true) {
              _filpTick = false;
            }
          }
        })
        ..addListener(() {
          setState(() {});
        });
    }
  }

  int _getValue() {
    switch (this.widget.tickType) {
      case 0:
        return this.widget.dateTime.second;
        break;
      case 1:
        return this.widget.dateTime.minute;
        break;
      case 2:
        return this.widget.dateTime.hour;
        break;
      default:
        return 0;
        break;
    }
  }

  @override
  void initState() {
    this._initAnimationController();
    //动画数值使用0度角到90度角
    _animation = Tween(begin: 0.0, end: pi / 2).animate(_controller);

    super.initState();

    if (this.widget.tickType == 0) {
      setState(() {
        _filpTick = true;
      });
      _controller.forward();
    }

    _timerPeriodic = Timer.periodic(Duration(seconds: 1), (timer) {
      //1s 回调一次
      _controller.forward();
    });
  }

  @override
  void didUpdateWidget(covariant TickFlipCell oldWidget) {
    super.didUpdateWidget(oldWidget);

    print("didUpdateWidget");
    setState(() {});
  }

  @override
  void dispose() {
    _timerPeriodic.cancel();
    _timerPeriodic = null;
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.widget.tickFlipWidth,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: <Widget>[
              //下一个数字的上部分
              this._clipRectText(
                _filpTick == true ? (this._getValue() + 1) : this._getValue(),
                Alignment.topCenter,
              ),
              //当前数字的上部分，当_isReversePhase为true时和平面呈90度角相当于隐藏
              _filpTick == true
                  ? Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.003)
                        ..rotateX(_isReversePhase ? pi / 2 : _animation.value),
                      alignment: Alignment.bottomCenter,
                      child: this._clipRectText(
                        this._getValue(),
                        Alignment.topCenter,
                      ),
                    )
                  : Container(),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 1.5),
          ),
          Stack(
            children: <Widget>[
              //当前数字的下部分
              this._clipRectText(
                this._getValue(),
                Alignment.bottomCenter,
              ),
              //下个数字的下部分，当_isReversePhase为true时才执行翻转动画否则一直和平面呈90度
              _filpTick == true
                  ? Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.003)
                        ..rotateX(
                            _isReversePhase ? (-_animation.value) : pi / 2),
                      alignment: Alignment.topCenter,
                      child: this._clipRectText(
                        this._getValue() + 1,
                        Alignment.bottomCenter,
                      ),
                    )
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }
}
