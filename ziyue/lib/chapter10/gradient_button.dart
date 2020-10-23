import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final List<Color> colors; //颜色渐变数组
  final double width;
  final double height;
  final Widget child;
  final BorderRadius borderRadius;
  final GestureTapCallback onPressed;

  const GradientButton({
    Key key,
    this.colors,
    this.width,
    this.height,
    this.borderRadius,
    this.onPressed,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    //确保colors不为空
    List<Color> _colors = colors ??
        [
          themeData.primaryColor,
          themeData.primaryColorDark ?? themeData.primaryColor
        ];

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: _colors),
        borderRadius: borderRadius,
      ),
      child: Material(
        type: MaterialType.transparency, //透明
        child: InkWell(
          //水波纹
          splashColor: _colors.last,
          highlightColor: Colors.transparent,
          borderRadius: borderRadius,
          onTap: onPressed,
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(width: width, height: height),
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: DefaultTextStyle(
                  style: TextStyle(fontWeight: FontWeight.bold),
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
