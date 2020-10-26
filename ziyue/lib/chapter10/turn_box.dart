import 'package:flutter/material.dart';

class TurnBox extends StatefulWidget {
  final double turns; // 旋转的圈数
  final Duration duration;
  final Widget child;

  const TurnBox({
    Key key,
    this.turns,
    this.duration,
    this.child,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TurnBoxState();
  }
}

class TurnBoxState extends State<TurnBox> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      vsync: this,
      lowerBound: -double.infinity,//重新设置controller的取值范围，默认0.0~1.0
      upperBound: double.infinity,
      // duration: widget.duration,//这里可以省略duration，执行动画时再设置
      value: widget.turns,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: widget.child,
    );
  }

  @override
  void didUpdateWidget(TurnBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 旋转角度发生变化时，执行动画
    if (oldWidget.turns != widget.turns) {
      _controller.animateTo(
        widget.turns,
        duration: widget.duration,
        curve: Curves.easeOut,
      );
    }
  }
}
