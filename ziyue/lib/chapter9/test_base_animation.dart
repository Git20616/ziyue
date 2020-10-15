import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestBaseAnimation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TestBaseAnimationState();
  }
}

// 需要继承TickerProvider，如果有多个AnimationController，则应该使用TickerProviderStateMixin。
// Flutter应用在启动时都会绑定一个SchedulerBinding，通过SchedulerBinding可以给每一次屏幕刷新添加回调，
// 而Ticker就是通过SchedulerBinding来添加屏幕刷新回调，这样一来，每次屏幕刷新都会调用TickerCallback。
// 使用Ticker(而不是Timer)来驱动动画会防止屏幕外动画（动画的UI不在当前屏幕时，如锁屏时）消耗不必要的资源，
// 因为Flutter中屏幕刷新时会通知到绑定的SchedulerBinding，而Ticker是受SchedulerBinding驱动的，由于锁屏后屏幕会停止刷新，所以Ticker就不会再触发。
class TestBaseAnimationState extends State<TestBaseAnimation>
    with SingleTickerProviderStateMixin {
  // Animation是一个抽象类，它本身和UI渲染没有任何关系，而它主要的功能是保存动画的插值和状态
  Animation<double> _animation;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    // AnimationController对象值的范围是[0.0，1.0]。如果我们需要构建UI的动画值在不同的范围或不同的数据类型，则可以使用Tween来添加映射以生成不同的范围或数据类型的值。
    _animation = new Tween(begin: 0.0, end: 300.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    //启动动画
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("动画的基本结构及监听状态"),
      ),
      body: Column(
        children: <Widget>[
          Image.asset(
            "images/avatar.jpg",
            width: _animation.value,
            height: _animation.value,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    //路由销毁时需要释放动画资源
    _controller.dispose();
    super.dispose();
  }
}
