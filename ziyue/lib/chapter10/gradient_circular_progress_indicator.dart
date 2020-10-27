import 'dart:math';
import 'package:flutter/material.dart';

class GradientCircularProgressIndicator extends StatelessWidget {
  /// 粗细
  final double strokeWidth;

  /// 两端是否为圆角
  final bool strokeCapRound;

  /// 圆的半径
  final double radius;

  /// 进度条的总弧度，2*PI为整圆，小于2*PI则不是整圆
  final double totalAngle;

  /// 进度条背景色
  final Color backgroundColor;

  /// 渐变色数组
  final List<Color> colors;

  /// 渐变色终止点，与[colors]对应
  final List<double> stops;

  /// 当前进度，取值范围[0.0-1.0]
  final double value;

  const GradientCircularProgressIndicator({
    Key key,
    this.strokeWidth = 2.0,
    this.strokeCapRound = false,
    @required this.radius,
    this.totalAngle = 2 * pi,
    this.backgroundColor = const Color(0xFFEEEEEE),
    @required this.colors,
    this.stops,
    @required this.value,
  })  : assert(radius != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    double _offset = .0;
    // 如果两端为圆角，则需要对起始位置进行调整，否则圆角部分会偏离起始位置
    // TODO 下面调整的角度的计算公式是通过数学几何知识得出，读者有兴趣可以研究一下为什么是这样
    if (strokeCapRound) {
      _offset = asin(strokeWidth / (radius * 2 - strokeWidth));
    }
    List<Color> _colors = colors;
    if (_colors == null) {
      Color color = Theme.of(context).accentColor;
      _colors = [color, color];
    }
    return Transform.rotate(
      angle: -pi / 2.0 - _offset, //去除圆角偏移量
      child: CustomPaint(
        size: Size.fromRadius(radius),
        painter: GradientCircularProgressPainter(//
          strokeWidth: strokeWidth,
          strokeCapRound: strokeCapRound,
          radius: radius,
          totalAngle: totalAngle,
          backgroundColor: backgroundColor,
          colors: _colors,
          stops: stops,
          value: value,
        ),
      ),
    );
  }
}

//实现画笔
class GradientCircularProgressPainter extends CustomPainter {
  /// 粗细
  final double strokeWidth;

  /// 两端是否为圆角
  final bool strokeCapRound;

  /// 圆的半径
  final double radius;

  /// 进度条的总弧度，2*PI为整圆，小于2*PI则不是整圆
  final double totalAngle;

  /// 进度条背景色
  final Color backgroundColor;

  /// 渐变色数组
  final List<Color> colors;

  /// 渐变色终止点，与[colors]对应
  final List<double> stops;

  /// 当前进度，取值范围[0.0-1.0]
  final double value;

  GradientCircularProgressPainter({
    this.strokeWidth,
    this.strokeCapRound,
    this.radius,
    this.totalAngle,
    this.backgroundColor,
    this.colors,
    this.stops,
    this.value,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double _value = value ?? .0;
    _value = _value.clamp(.0, 1.0) * totalAngle;
    double _start = .0;
    if (strokeCapRound) {
      _start = asin(strokeWidth / (size.width - strokeWidth));
    }
    double _offset = strokeWidth / 2.0; //rect为strokeWidth无限小时，所画环形的外接四边形
    Rect rect = Offset(_offset, _offset) &
        Size(size.width - strokeWidth, size.height - strokeWidth);

    Paint paint = new Paint()
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true
      ..strokeWidth = strokeWidth
      ..strokeCap = strokeCapRound ? StrokeCap.round : StrokeCap.butt;

    // 先画背景，透明不画
    if (backgroundColor != Colors.transparent) {
      paint.color = backgroundColor;
      canvas.drawArc(rect, _start, totalAngle, false, paint);
    }
    // 再画前景，应用渐变
    if (_value > 0) {
      paint.shader = SweepGradient(
        startAngle: 0.0,
        endAngle: _value,
        colors: colors,
        stops: stops,
      ).createShader(rect);
      canvas.drawArc(rect, _start, _value, false, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
