import 'package:flutter/material.dart';

// 实现一个AnimatedDecoratedBox，它可以在decoration属性发生变化时，从旧状态变成新状态的过程可以执行一个过渡动画
class AnimatedDecoratedBox1 extends StatefulWidget {
  final BoxDecoration decoration;
  final Widget child;
  final Duration duration;
  final Curve curve;
  final Duration reverseDuration;

  AnimatedDecoratedBox1({
    Key key,
    @required this.decoration,
    this.child,
    @required this.duration,
    this.curve = Curves.linear,
    this.reverseDuration,
  });

  @override
  State<StatefulWidget> createState() {
    return AnimatedDecoratedBox1State();
  }
}

class AnimatedDecoratedBox1State extends State<AnimatedDecoratedBox1>
    with SingleTickerProviderStateMixin {
  @required
  AnimationController get controller => _controller;
  AnimationController _controller;

  Animation<double> get animation => _animation;
  Animation<double> _animation;

  DecorationTween _tween;

  @override
  void initState() {
    super.initState();
    //初始化
    _controller = AnimationController(
      duration: widget.duration,
      reverseDuration: widget.reverseDuration ?? widget.duration,
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: widget.curve);
    _tween = DecorationTween(begin: widget.decoration); //UI更新的时候提供end
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget child) {
        return DecoratedBox(
          decoration: _tween.animate(_animation).value,
          child: child,
        );
      },
      child: widget.child,
    );
  }

  @override
  void didUpdateWidget(AnimatedDecoratedBox1 oldWidget) {
    super.didUpdateWidget(oldWidget);
    //过渡动画
    _controller.duration = widget.duration;
    _controller.reverseDuration = widget.reverseDuration ?? widget.duration;
    if (widget.curve != oldWidget.curve) {
      _animation = CurvedAnimation(parent: _controller, curve: widget.curve);
    }
    if (widget.decoration != (_tween.end ?? _tween.begin)) {
      _tween
        ..begin = _tween.evaluate(_animation)
        ..end = widget.decoration;
      _controller
        ..value = 0.0
        ..forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
