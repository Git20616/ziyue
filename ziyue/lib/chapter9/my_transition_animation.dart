import 'package:flutter/material.dart';
import 'package:ziyue/chapter9/animated_decorated_box.dart';
import 'package:ziyue/chapter9/animated_decorated_box1.dart';

class MyTransitionAnimation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyTransitionAnimationState();
  }
}

class MyTransitionAnimationState extends State<MyTransitionAnimation> {
  Color btn1Color = Colors.blue;
  Color btn2Color = Colors.green;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("自定义动画组件"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            AnimatedDecoratedBox1(
              decoration: BoxDecoration(color: btn1Color),
              duration: const Duration(seconds: 1),
              child: FlatButton(
                onPressed: () {
                  setState(() {
                    btn1Color = btn1Color == Colors.blue ? Colors.red : Colors.blue;
                  });
                },
                child: Text("AnimatedDecoratedBox1", style: TextStyle(color: Colors.white),),
              ),
            ),
            AnimatedDecoratedBox(
              decoration: BoxDecoration(color: btn2Color),
              duration: const Duration(seconds: 1),
              child: InkWell(
                onTap: () {
                  setState(() {
                    btn2Color = btn2Color == Colors.blue ? Colors.red : Colors.blue;
                  });
                },
                child: Container(
                  height: 60.0,
                  child: Text("AnimatedDecoratedBox", style: TextStyle(color: Colors.white),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}