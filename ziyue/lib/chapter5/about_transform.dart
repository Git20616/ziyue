import 'package:flutter/material.dart';

class AboutTransform extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("变换TransForm"),),
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

          ],
        ),
      ),
    );
  }

}