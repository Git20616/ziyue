import 'package:flutter/material.dart';
import 'package:ziyue/chapter8/test_gesture_detector.dart';
import 'package:ziyue/chapter8/test_gesture_detector2.dart';
import 'package:ziyue/chapter8/test_pointer_event.dart';

class Chapter8 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("事件处理与通知"),),
      body: Center(
        child: Wrap(
          spacing: 16.0,
          runSpacing: 16.0,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) => TestPointerEvent(),
                ));
              },
              child: Text("原始指针事件处理"),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) => TestGestureDetector(),
                ));
              },
              child: Text("手势识别"),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => TestGestureDetector2(),
                ));
              },
              child: Text("手势竞争与冲突"),
            ),
            RaisedButton(
              onPressed: () {
              },
              child: Text("全局事件总线"),
            ),
          ],
        ),
      ),
    );
  }
}