import 'package:flutter/material.dart';

class SomeFrameLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Stack, Positioned"),),
      body: ConstrainedBox(
        // 通过ConstrainedBox组件来确保Stack占满全屏
        constraints: BoxConstraints.expand(),
        child: Stack(
          alignment: Alignment.center, // 指定未定位或部分定位的widget的对齐方式
          textDirection: TextDirection.ltr, // 和Row、Wrap的textDirection功能一样，都用于确定alignment对齐的参考系
          fit: StackFit.expand, // loose 使用子组件大小, expand扩伸到Stack大小
          overflow: Overflow.clip, // clip 超出部分裁剪, visible 超出部分显示
          children: <Widget>[
            Container(
              color: Colors.green[200],
              child: Text("Hello World", style: TextStyle(color: Colors.blue),),
            ),
            Positioned( // 根据Stack四角来定位
              left: 20.0,
              child: Text("I am LiBai"),
            ),
            Positioned(
              top: 20.0,
              child: Text("top: 20.0"),
            ),
            Positioned(
              top: 180.0,
              left: 40.0,
              width: 300.0,
              height: 300.0,
              child: Container(
                color: Colors.green,
                child: Text("top: 180.0, left: 40.0, \nwidth: 300.0, height: 300.0"),
              ),
            ),
            Positioned(
              top: 200.0,
              left: 200.0,
              width: 100.0,
              height: 100.0,
              child: Container(color: Colors.blue,),
            ),
          ],
        ),
      ),
    );
  }

}