import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ziyue/chapter10/gradient_circular_progress_indicator.dart';
import 'package:ziyue/chapter10/turn_box.dart';

class TestGradientCircularProgress extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TestGradientCircularProgressState();
  }
}

// 单个动画SingleTickerProviderStateMixin 多个动画TickerProviderStateMixin
class TestGradientCircularProgressState
    extends State<TestGradientCircularProgress> with TickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        new AnimationController(vsync: this, duration: Duration(seconds: 3));
    bool isForward = true;
    _animationController.addStatusListener((status) {
      switch (status) {
        case AnimationStatus.forward:
          isForward = true;
          break;
        case AnimationStatus.reverse:
          isForward = false;
          break;
        case AnimationStatus.completed:
        case AnimationStatus.dismissed:
          if (isForward) {
            _animationController.reverse();
          } else {
            _animationController.forward();
          }
          break;
      }
    });
    _animationController.addListener(() {
      //TODO 思考更好的处理方法
      setState(() {});
    });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("原型渐变进度条"),
      ),
      body: SingleChildScrollView(
        child: Wrap(
          spacing: 10.0,
          runSpacing: 16.0,
          children: <Widget>[
            GradientCircularProgressIndicator(
              colors: null, //使用跟随系统的颜色，且无渐变
              radius: 50.0,
              value: _animationController.value,
            ),
            GradientCircularProgressIndicator(
              colors: [Colors.green, Colors.green],
              radius: 50.0,
              value: _animationController.value,
              strokeWidth: 3.0,
            ),
            GradientCircularProgressIndicator(
              radius: 50.0,
              colors: [Colors.red, Colors.orange],
              value: _animationController.value,
              strokeWidth: 5.0,
            ),
            GradientCircularProgressIndicator(
              radius: 50.0,
              colors: [Colors.green, Colors.orange, Colors.red],
              value: _animationController.value,
              strokeWidth: 5.0,
            ),
            GradientCircularProgressIndicator(
              radius: 50.0,
              colors: [Colors.teal, Colors.cyan],
              value: CurvedAnimation(
                //增加线性变化
                parent: _animationController,
                curve: Curves.decelerate,
              ).value,
              strokeWidth: 5.0,
            ),
            TurnBox(
              turns: 1 / 8,
              child: GradientCircularProgressIndicator(
                radius: 50.0,
                colors: [Colors.red, Colors.orange, Colors.red],
                value: CurvedAnimation(
                  parent: _animationController,
                  curve: Curves.ease,
                ).value,
                strokeWidth: 5.0,
                strokeCapRound: true,
                backgroundColor: Colors.red[50],
                totalAngle: 1.5 * pi,
              ),
            ),
            RotatedBox(
              quarterTurns: 1,
              child: GradientCircularProgressIndicator(
                colors: [Colors.blue[700], Colors.blue[200]],
                radius: 50.0,
                strokeWidth: 3.0,
                strokeCapRound: true,
                backgroundColor: Colors.transparent,
                value: _animationController.value,
              ),
            ),
            GradientCircularProgressIndicator(
              colors: [
                Colors.red,
                Colors.amber,
                Colors.cyan,
                Colors.green[200],
                Colors.blue,
                Colors.red
              ],
              radius: 50.0,
              strokeWidth: 5.0,
              strokeCapRound: true,
              value: _animationController.value,
            ),
            ClipRect(
              child: Align(
                alignment: Alignment.topCenter,
                heightFactor: .5,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: SizedBox(
                    //width: 100.0,
                    child: TurnBox(
                      turns: .75,
                      child: GradientCircularProgressIndicator(
                        colors: [Colors.teal, Colors.cyan[500]],
                        radius: 80.0,
                        strokeWidth: 8.0,
                        value: _animationController.value,
                        totalAngle: pi,
                        strokeCapRound: true,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 80.0,
              width: 160.0,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Positioned(
                    height: 160.0,
                    top: .0,
                    child: TurnBox(
                      turns: .75,
                      child: GradientCircularProgressIndicator(
                        colors: [Colors.teal, Colors.cyan[500]],
                        radius: 80.0,
                        strokeWidth: 8.0,
                        value: _animationController.value,
                        totalAngle: 2 * pi,
                        strokeCapRound: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "${(_animationController.value * 100).toInt()}%",
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.blueGrey,
                      ),
                    ),
                  )
                ],
              ),
            ),
            GradientCircularProgressIndicator(
              radius: 100.0,
              colors: [Colors.indigo, Colors.blue, Colors.green, Colors.yellow, Colors.orange],
              value: _animationController.value,
              strokeWidth: 5.0,
              stops: [0.3, 0.4, 0.5, 0.6, 1.0],
            ),
          ],
        ),
      ),
    );
  }
}
