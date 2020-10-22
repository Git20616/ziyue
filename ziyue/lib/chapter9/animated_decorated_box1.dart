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

class AnimatedDecoratedBox1State extends State<AnimatedDecoratedBox1> with SingleTickerProviderStateMixin{
  @required
  AnimationController get controller => _controller;
  AnimationController _controller;

  Animation<double> get animation => _animation;
  Animation<double> _animation;

  DecorationTween _tween;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      reverseDuration: widget.reverseDuration ?? widget.duration,
      vsync: this,
    );
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
}
