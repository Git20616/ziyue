import 'package:flutter/material.dart';

class AnimatedDecoratedBox extends ImplicitlyAnimatedWidget {
  final BoxDecoration decoration;
  final Widget child;

  AnimatedDecoratedBox({
    Key key,
    @required this.decoration,
    this.child,
    Curve curve = Curves.linear,
    @required Duration duration,
    Duration reverseDuration,
  }) : super(key: key, curve: curve, duration: duration);

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() {
    return AnimatedDecoratedBoxState();
  }
}

//该类继承自ImplicitlyAnimatedWidgetState类
class AnimatedDecoratedBoxState
    extends AnimatedWidgetBaseState<AnimatedDecoratedBox> {
  DecorationTween _decorationTween;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: _decorationTween.evaluate(animation),
      child: widget.child,
    );
  }

  @override
  void forEachTween(visitor) {
    // 在需要更新Tween时，基类会调用此方法
    // 这里只需要更新初始状态值，最终状态的值为用户传的值
    _decorationTween = visitor(_decorationTween, widget.decoration,
        (value) => DecorationTween(begin: value));
  }
}
