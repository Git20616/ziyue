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
    with TickerProviderStateMixin {
  // #1 基础版本
  // Animation是一个抽象类，它本身和UI渲染没有任何关系，而它主要的功能是保存动画的插值和状态
  Animation<double> _animation;
  AnimationController _controller;

  // #2 使用AnimatedWidget简化
  Animation<double> _animation2;
  AnimationController _controller2;

  // #3 最优雅的方式 用AnimatedBuilder重构
  Animation<double> _animation3;
  AnimationController _controller3;

  @override
  initState() {
    super.initState();
    // #1 基础版本
    _controller = new AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    // AnimationController对象值的范围是[0.0，1.0]。如果我们需要构建UI的动画值在不同的范围或不同的数据类型，则可以使用Tween来添加映射以生成不同的范围或数据类型的值。
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceIn,
    ); //使用弹性曲线
    _animation = new Tween(begin: 0.0, end: 200.0).animate(_animation)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          _controller2.forward();
        }
      });
    //启动动画
    _controller.forward();

    // #2 使用AnimatedWidget简化
    _controller2 = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation2 = new Tween(begin: 0.0, end: 200.0).animate(_controller2)
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          _controller3.forward();
        }
      }); //AnimatedWidget类封装了调用setState()的细节
    // _controller2.forward(); //#1执行结束后执行#2

    // #3 最优雅的方式 用AnimatedBuilder重构
    _controller3 = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation3 = new Tween(begin: 0.0, end: 200.0).animate(_controller3)
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          _controller3.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller3.forward();
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("动画的基本结构及监听状态"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 16.0),
        child: Column(
          children: <Widget>[
            Image.asset(
              "images/avatar.jpg",
              width: _animation.value,
              height: _animation.value,
            ),
            AnimateImg(
              animation: _animation2,
            ),
            GrowTransition(
              animation: _animation3,
              child: Image.asset("images/avatar.jpg"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    //路由销毁时需要释放动画资源
    _controller.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }
}

// #2 使用AnimatedWidget简化
//AnimatedWidget类封装了调用setState()的细节
class AnimateImg extends AnimatedWidget {
  AnimateImg({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable; //父类变量
    return Image.asset(
      "images/avatar.jpg",
      width: animation.value,
      height: animation.value,
    );
  }
}

// #3 最优雅的方式 用AnimatedBuilder重构
class GrowTransition extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;

  const GrowTransition({Key key, this.animation, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (BuildContext context, Widget child) {
        return new Container(
          width: animation.value,
          height: animation.value,
          child: child,
        );
      },
    );
  }
}
