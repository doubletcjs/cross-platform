import 'package:flutter/material.dart';

class HeartBeatWidget extends StatefulWidget {
  double radius = 25.0;
  double minRadius = 20.5;

  HeartBeatWidget({
    Key key,
    this.radius = 25.0,
    this.minRadius = 20.5,
  }) : super(key: key);

  @override
  _HeartBeatWidgetState createState() => _HeartBeatWidgetState();
}

class _HeartBeatWidgetState extends State<HeartBeatWidget>
    with TickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(microseconds: 800),
    )..forward();
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear);

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(Duration(milliseconds: 400), () {
          if (_animationController != null) {
            _animationController.reset();
          }
        });
      } else if (status == AnimationStatus.dismissed) {
        _animationController.forward();
      }
    });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.stop();
    _animationController.dispose();
    _animationController = null;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBeatUp(
      animation: _animation,
      radius: this.widget.radius,
      minRadius: this.widget.minRadius,
    );
  }
}

class AnimatedBeatUp extends AnimatedWidget {
  double radius = 25.0;
  double minRadius = 20.5;
  final Tween<double> _opacityTween = Tween(begin: 1, end: 0.8);

  AnimatedBeatUp({
    Key key,
    Animation<double> animation,
    this.radius = 25.0,
    this.minRadius = 20.5,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    final Tween<double> _sizeTween = Tween(begin: radius, end: minRadius);

    return Container(
      padding: EdgeInsets.all(4),
      width: radius + 4.0,
      height: radius + 4.0,
      child: Center(
        child: Opacity(
          opacity: _opacityTween.evaluate(animation),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(255, 196, 224, 1),
                  Color.fromRGBO(255, 124, 193, 1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(radius / 2),
            ),
            width: _sizeTween.evaluate(animation),
            height: _sizeTween.evaluate(animation),
          ),
        ),
      ),
    );
  }
}
