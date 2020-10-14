import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TestGestureDetector extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TestGestureDetectorState();
  }
}

class TestGestureDetectorState extends State<TestGestureDetector> {
  String _operation = "No Gesture Detected"; //保存事件名
  double _topA = 0.0;
  double _leftA = 0.0;
  double _leftB = 0.0;
  double _imgWidth = 200.0; //通过修改图片宽度来打到缩放效果

  // GestureRecognizer
  TapGestureRecognizer _tapGestureRecognizer = new TapGestureRecognizer();
  bool _toggle = false;

  @override
  void dispose() {
    // 用到GestureRecognizer的话一定要调用其dispose方法释放资源
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GestureDetector, GestureRecognizer"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            GestureDetector(
              // 同时监听onTap和onDoubleTap事件时，当用户触发tap事件时，会有200毫秒左右的延时
              // 这是因为当用户点击完之后很可能会再次点击以触发双击事件，所以GestureDetector会等一段时间来确定是否为双击事件
              onTap: () => updateText("onTap"),
              onDoubleTap: () => updateText("onDoubleTap"),
              onLongPress: () => updateText("onLongPress"),
              child: Container(
                width: 300.0,
                height: 80.0,
                color: Colors.green,
                child: Column(
                  children: <Widget>[
                    Text(
                      "点击、双击、长按：",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      _operation,
                      style: TextStyle(fontSize: 30.0, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              child: Image.asset(
                "images/lake.jpg",
                width: _imgWidth,
              ),
              onScaleUpdate: (ScaleUpdateDetails e) {
                setState(() {
                  _imgWidth = e.scale.clamp(0.5, 2.0) * 200.0;
                });
              },
            ),
            Container(
              width: 300.0,
              height: 150.0,
              color: Colors.blue,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: _topA,
                    left: _leftA,
                    child: GestureDetector(
                      child: CircleAvatar(
                        child: Text("A"),
                      ),
                      onPanDown: (DragDownDetails e) {
                        //手指按下触发回调
                        print(
                            "global: ${e.globalPosition}, local: ${e.localPosition}");
                      },
                      onPanUpdate: (DragUpdateDetails e) {
                        //手指滑动触发回调
                        setState(() {
                          // 注意！delta是偏移量
                          double _x = _leftA + e.delta.dx;
                          double _y = _topA + e.delta.dy;
                          if (_x >= 0 && _x <= 260 && _y >= 0 && _y <= 110) {
                            _leftA = _x;
                            _topA = _y;
                          }
                        });
                      },
                      onPanEnd: (DragEndDetails e) {
                        print("velocity: ${e.velocity}");
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 300.0,
              height: 80.0,
              color: Colors.blue,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: _leftB,
                    top: 20.0,
                    child: GestureDetector(
                      child: CircleAvatar(
                        child: Text("B"),
                      ),
                      onHorizontalDragUpdate: (DragUpdateDetails e) {
                        //水平方向拖动事件
                        setState(() {
                          double _x = _leftB + e.delta.dx;
                          if (_x >= 0 && _x <= 260) {
                            _leftB = _x;
                          }
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: "你好世界"),
                  TextSpan(
                    text: "点我变色",
                    style: TextStyle(
                      fontSize: 30.0,
                      color: _toggle ? Colors.blue : Colors.red,
                    ),
                    recognizer: _tapGestureRecognizer..onTap = () { //这里使用级联运算符（..） 返回GestureRecognizer对象本身
                      setState(() {
                        _toggle = !_toggle;
                      });
                    },
                  ),
                  TextSpan(text: "你好世界"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateText(String text) {
    setState(() {
      _operation = text;
    });
  }
}
