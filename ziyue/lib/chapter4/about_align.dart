import 'package:flutter/material.dart';

class AboutAlign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("对齐与相对定位"),),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              color: Colors.blue[50],
              width: 120.0,
              height: 120.0,
              child: Align(
                alignment: Alignment.topRight,
                child: FlutterLogo(size: 60.0,),
              ),
            ),
            Container(
              color: Colors.blue[50],
              child: Align(
                // widthFactor和heightFactor是用于确定Align 组件本身宽高的属性；
                // 它们是两个缩放因子，会分别乘以子元素的宽、高，最终的结果就是Align 组件的宽高。
                // 如果值为null，则组件的宽高将会占用尽可能多的空间
                widthFactor: 2, // 相对子widget宽的系数
                heightFactor: 2, // 相对子widget高的系数
                alignment: Alignment.topRight,
                child: FlutterLogo(size: 60.0,),
              ),
            ),
            Container(
              color: Colors.blue[50],
              child: Align(
                widthFactor: 2,
                heightFactor: 2,
                alignment: Alignment(2, 0.0), // 计算公式(Alignment.x*childWidth/2+childWidth/2, Alignment.y*childHeight/2+childHeight/2) 就是(90, 30)
                child: FlutterLogo(size: 60.0,),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(color: Colors.green[200]),
              // 可以认为Center组件其实是对齐方式确定（Alignment.center）了的Align。
              child: Center(
                child: Text("aaa"),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(color: Colors.green[200]),
              child: Center(
                widthFactor: 2,
                heightFactor: 2,
                child: Text("aaa"),
              ),
            ),
          ],
        ),
      ),
    );
  }

}