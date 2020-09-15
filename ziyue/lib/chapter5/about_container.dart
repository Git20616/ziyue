import 'dart:math';

import 'package:flutter/material.dart';

class AboutContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Container容器"),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            // 容器内补白，属于decoration装饰范围
            padding: EdgeInsets.all(16.0),
            // 容器外补白，不属于decoration装饰范围
            // padding与margin都是由Padding组件实现的
            margin: EdgeInsets.only(top: 50.0, left: 120.0),
            // 容器的大小可以通过width、height属性来指定，也可以通过constraints来指定；
            // 如果它们同时存在时，width、height优先。
            // 实际上Container内部会根据width、height来生成一个constraints。
            constraints: BoxConstraints.tightFor(width: 200.0, height: 150.0),
            // color和decoration是互斥的，如果同时设置它们则会报错！
            // 实际上，当指定color时，Container内会自动创建一个decoration。
            decoration: BoxDecoration(
              gradient: RadialGradient( //背景径向渐变
                colors: [Colors.red, Colors.orange],
                center: Alignment.topLeft,
                radius: 0.98,
              ),
              boxShadow: [ //卡片阴影
                BoxShadow(
                  color: Colors.black54,
                  offset: Offset(2.0, 2.0),
                  blurRadius: 4.0,
                ),
              ],
            ),
            transform: Matrix4.rotationZ(pi / 12), //绕Z轴旋转
            alignment: Alignment.center,
            child: Text("5.20", style: TextStyle(color: Colors.white, fontSize: 40.0),),
          ),
          Container(
            margin: EdgeInsets.all(20.0),
            color: Colors.green[200],
            child: Text("margin"),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            color: Colors.green[200],
            child: Text("padding"),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: DecoratedBox(
              decoration: BoxDecoration(color: Colors.green[200]),
              child: Text("Padding1"),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(color: Colors.green[200]),
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Text("Padding2"),
            ),
          ),
        ],
      ),
    );
  }

}