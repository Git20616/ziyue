import 'package:flutter/material.dart';

class SomeClip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget avatar = Image.asset("images/avatar.jpg", width: 80.0,);

    // ClipOval	子组件为正方形时剪裁为内贴圆形，为矩形时，剪裁为内贴椭圆
    // ClipRRect	将子组件剪裁为圆角矩形
    // ClipRect	剪裁子组件到实际占用的矩形大小（溢出部分剪裁）

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("剪裁Clip"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            avatar, //不剪裁
            ClipOval( //剪裁为圆形
              child: avatar,
            ),
            ClipRRect( //裁剪为圆角矩形
              borderRadius: BorderRadius.circular(8.0),
              child: avatar,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  widthFactor: 0.5, //将宽度设置为原来的一半，另一半会溢出
                  child: avatar,
                ),
                Text("Hello world"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ClipRect( //将溢出部分剪裁
                  child: Align(
                    alignment: Alignment.topLeft,
                    widthFactor: 0.5,
                    child: avatar,
                  ),
                ),
                Text("Hello world"),
              ],
            ),
            DecoratedBox(
              decoration: BoxDecoration(color: Colors.green[200]),
              // 剪裁是在layout完成后的绘制阶段进行的，所以不会影响组件的大小，这和Transform原理是相似的。
              child: ClipRect(
                clipper: MyClipper(),
                child: avatar,
              ),
            ),
          ],
        ),
      ),
    );
  }

}

// 自定义剪裁区域
class MyClipper extends CustomClipper<Rect> {
  @override
  getClip(Size size) {
    // TODO: implement getClip
    // 返回一个剪裁区域
    return Rect.fromLTWH(20, 20, 40, 40);
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    // TODO: implement shouldReclip
    // 决定是否从新剪裁
    // 如果在应用中，剪裁区域始终不会发生变化时应该返回false，这样就不会触发重新剪裁，避免不必要的性能开销。
    // 如果剪裁区域会发生变化（比如在对剪裁区域执行一个动画），那么变化后应该返回true来重新执行剪裁。
    return false;
  }

}