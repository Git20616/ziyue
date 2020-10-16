import 'package:flutter/material.dart';

// 要创建交织动画，需要使用多个动画对象（Animation）。
// 一个AnimationController控制所有的动画对象。
// 给每一个动画对象指定时间间隔（Interval）
class StaggerAnimation extends StatelessWidget {
  final Animation<double> controller;
  Animation<double> height;
  Animation<EdgeInsets> padding;
  Animation<Color> color;

  StaggerAnimation({Key key, @required this.controller}) : super(key: key) {
    // 高度动画
    height = Tween<double>(begin: 0.0, end: 300.0).animate(CurvedAnimation(
      parent: controller,
      curve: Interval(0.0, 0.6, curve: Curves.ease), //间隔，前60%的动画时间
    ));

    // 利用padding属性实现平移
    padding = Tween<EdgeInsets>(
      begin: EdgeInsets.only(left: 0.0),
      end: EdgeInsets.only(left: 250.0),
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Interval(0.6, 1.0, curve: Curves.ease), //间隔，后40%时间
    ));

    // 颜色渐变
    color = ColorTween(
      begin: Colors.green,
      end: Colors.red,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Interval(0.0, 0.6, curve: Curves.ease),
    ));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget child) {
        return Container(
          alignment: Alignment.bottomLeft,
          padding: padding.value,
          child: Container(
            color: color.value,
            width: 50.0,
            height: height.value,
          ),
        );
      },
    );
  }
}

class TestStaggerAnimation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TestStaggerAnimationState();
  }
}

class TestStaggerAnimationState extends State<TestStaggerAnimation> with TickerProviderStateMixin{
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
  }

  //异步方法
  Future<void> _playAnimation() async {
    try {
      await _controller.forward().orCancel;
      await _controller.reverse().orCancel;
    } on TickerCanceled {
      // on ticker is canceled
      print("ticker is canceled");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("交织动画"),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          _playAnimation();
        },
        child: Center(
          child: Container(
            width: 300.0,
            height: 300.0,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              border: Border.all(color: Colors.black.withOpacity(0.5)),
            ),
            child: StaggerAnimation(controller: _controller),
          ),
        ),
      ),
    );
  }
}
