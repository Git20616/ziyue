import 'package:flutter/material.dart';

class TestAnimatedSwitcher extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TestAnimatedSwitcherState();
  }
}

class TestAnimatedSwitcherState extends State<TestAnimatedSwitcher> {
  int _count = 0;
  MyChar myChar = MyChar();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            reverseDuration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              // return ScaleTransition(
              //   child: child,
              //   scale: animation,
              // );
              // 自定义平移动画
              return SlideTransitionX(
                position: animation,
                child: child,
                direction: AxisDirection.down,
              );
            },
            child: Text(
              "$_count",
              //显示指定key，不同的key会被认为是不同的Text，这样才能执行动画
              key: ValueKey<int>(_count),
              style: TextStyle(fontSize: 36.0),
            ),
          ),
          RaisedButton(
            onPressed: () {
              setState(() {
                ++_count;
              });
            },
            child: Text("加一"),
          ),
          AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              Tween<Offset> tween =
                  Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0));
              return MySlideTransition(
                child: child,
                position: tween.animate(animation),
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              //显示指定key，不同的key会被认为是不同的Text，这样才能执行动画
              key: ValueKey<int>(myChar.index),
              child: Text(
                "${myChar.value}",
                style: TextStyle(fontSize: 36.0),
              ),
            ),
          ),
          RaisedButton(
            onPressed: () {
              setState(() {
                myChar.next();
                print(myChar.index);
              });
            },
            child: Text("左侧滑出，右侧滑入"),
          ),
        ],
      ),
    );
  }
}

// 自定义AnimatedWidget，实现右边滑进显示，左边划出隐藏
class MySlideTransition extends AnimatedWidget {
  Animation<Offset> get position => listenable;
  final bool transformHitTests;
  final Widget child;

  MySlideTransition(
      {Key key,
      @required Animation<Offset> position,
      this.transformHitTests = true,
      this.child})
      : assert(position != null),
        super(key: key, listenable: position);

  @override
  Widget build(BuildContext context) {
    Offset offset = position.value;
    //动画反向执行时，调整x偏移，实现“从左边滑出隐藏”
    if (position.status == AnimationStatus.reverse) {
      offset = Offset(-offset.dx, offset.dy);
    }
    return FractionalTranslation(
      translation: offset, //0.25代表1/4屏幕
      transformHitTests: transformHitTests,
      child: child,
    );
  }
}

class MyChar {
  static List<String> uppercases = ["A", "B", "C", "D", "E", "F", "G", "H"];
  int index = 0;
  String get value => uppercases[index % 8];
  String next() => uppercases[index++ % 8];
}

// 通用的出入滑动动画
class SlideTransitionX extends AnimatedWidget {
  Animation<double> get position => listenable;
  final bool transformHitTests;
  final Widget child;
  final AxisDirection direction; //退场方向
  Tween<Offset> _tween;

  SlideTransitionX({
    Key key,
    @required Animation<double> position,
    this.transformHitTests = true,
    this.child,
    this.direction = AxisDirection.up,
  }) : assert(position != null), super(key: key, listenable: position) {
    //设置动画值范围，direction为OldWidget
    switch(direction) {
      case AxisDirection.up:
        _tween = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0));
        break;
      case AxisDirection.right:
        _tween = Tween<Offset>(begin: Offset(-1.0, 0.0), end: Offset(0.0, 0.0));
        break;
      case AxisDirection.down:
        _tween = Tween<Offset>(begin: Offset(0.0, -1.0), end: Offset(0.0, 0.0));
        break;
      case AxisDirection.left:
        _tween = Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    Offset offset = _tween.evaluate(position);//动画值换算
    if(position.status == AnimationStatus.reverse) {
      switch(direction) {
        case AxisDirection.up:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.right:
          offset = Offset(-offset.dx, offset.dy);
          break;
        case AxisDirection.down:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.left:
          offset = Offset(-offset.dx, offset.dy);
          break;
      }
    }
    return FractionalTranslation(
      translation: offset,
      transformHitTests: transformHitTests,
      child: child,
    );
  }
}
