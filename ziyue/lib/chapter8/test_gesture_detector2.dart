import 'package:flutter/material.dart';

class TestGestureDetector2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TestGestureDetector2State();
  }
}

class TestGestureDetector2State extends State<TestGestureDetector2> {
  double _leftA = 0.0;
  double _topA = 0.0;
  double _leftB = 0.0;
  double _topB = 0.0;
  double _leftC = 0.0;
  double _topC = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("手势竞争与冲突"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text("手势竞争"),
            Container(
              width: 300.0,
              height: 200.0,
              color: Colors.blue,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: _leftA,
                    top: _topA,
                    child: GestureDetector(
                      child: CircleAvatar(
                        child: Text("A"),
                      ),
                      onVerticalDragUpdate: (DragUpdateDetails e) {
                        print("vertical: " + e.toString());
                        setState(() {
                          double _y = _topA + e.delta.dy;
                          if (_y >= 0 && _y <= 160) _topA = _y;
                        });
                      },
                      onHorizontalDragUpdate: (DragUpdateDetails e) {
                        print("horizontal: " + e.toString());
                        setState(() {
                          double _x = _leftA + e.delta.dx;
                          if (_x >= 0 && _x <= 260) _leftA = _x;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Text("onTapUp与onPanEnd冲突"),
            Container(
              width: 300.0,
              height: 150.0,
              color: Colors.blue,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: _leftB,
                    top: _topB,
                    child: GestureDetector(
                      child: CircleAvatar(child: Text("B")), //要拖动和点击的widget
                      onPanUpdate: (DragUpdateDetails e) {
                        //手指滑动触发回调
                        setState(() {
                          // 注意！delta是偏移量
                          double _x = _leftB + e.delta.dx;
                          double _y = _topB + e.delta.dy;
                          if (_x >= 0 && _x <= 260 && _y >= 0 && _y <= 110) {
                            _leftB = _x;
                            _topB = _y;
                          }
                        });
                      },
                      onPanEnd: (DragEndDetails e) {
                        print("onPanEnd");
                      },
                      onTapDown: (details) {
                        print("down");
                      },
                      onTapUp: (details) {
                        print("up");
                      },
                    ),
                  ),
                ],
              ),
            ),
            Text("通过Listener监听原始指针事件解决冲突"),
            Container(
              width: 300.0,
              height: 150.0,
              color: Colors.blue,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: _leftC,
                    top: _topC,
                    child: Listener(
                      onPointerDown: (e) => print("down"),
                      onPointerUp: (e) => print("up"),
                      child: GestureDetector(
                        child: CircleAvatar(child: Text("C")), //要拖动和点击的widget
                        onPanUpdate: (DragUpdateDetails e) {
                          //手指滑动触发回调
                          setState(() {
                            // 注意！delta是偏移量
                            double _x = _leftC + e.delta.dx;
                            double _y = _topC + e.delta.dy;
                            if (_x >= 0 && _x <= 260 && _y >= 0 && _y <= 110) {
                              _leftC = _x;
                              _topC = _y;
                            }
                          });
                        },
                        onPanEnd: (DragEndDetails e) {
                          print("onPanEnd");
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
