import 'package:flutter/material.dart';
import 'dart:math';

class AboutTransform extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("变换TransForm"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text("通过Matrix4变换"),
            Container(
              color: Colors.black,
              child: Transform(
                alignment: Alignment.topRight, // 相对于坐标系原点的对齐方式
                transform: Matrix4.skewY(0.3), // 沿Y轴倾斜0.3弧度
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  color: Colors.deepOrange,
                  child: Text("Apartment for rent!"),
                ),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(color: Colors.blue),
              child: Transform.translate(
                offset: Offset(20.0, 10.0),
                child: Container(
                  color: Colors.green,
                  width: 120.0,
                  height: 40.0,
                ),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              child: Transform.rotate(
                angle: pi / 2.0,
                child: Container(
                  color: Colors.blue,
                  width: 120.0,
                  height: 40.0,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DecoratedBox(
                  decoration: BoxDecoration(color: Colors.green[200]),
                  child: Transform.scale(
                    scale: 1.5,
                    child: Text("Hello world"),
                  ),
                ),
                // 矩阵变化只会作用在绘制阶段
                // Transform的变换是应用在绘制阶段，而并不是应用在布局(layout)阶段，
                // 所以无论对子组件应用何种变化，其占用空间的大小和在屏幕上的位置都是固定不变的
                // 下面的Text组件会被遮挡
                Text(
                  "你好",
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DecoratedBox(
                  decoration: BoxDecoration(color: Colors.green[200]),
                  // RotatedBox的变换是在layout阶段，会影响在子组件的位置和大小。
                  child: RotatedBox(
                    quarterTurns: 1, // 旋转90度（1/4圈）
                    child: Text("RotatedBox"),
                  ),
                ),
                Text("你好"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
