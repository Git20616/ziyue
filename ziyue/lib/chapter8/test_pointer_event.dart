import 'package:flutter/material.dart';

class TestPointerEvent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TestPointerEventState();
  }
}

class TestPointerEventState extends State<TestPointerEvent> {
  PointerEvent _event; //定义一个事件，保存当前指针位置

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("原始指针事件处理"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Listener(
              onPointerDown: (PointerDownEvent event) =>
                  setState(() => _event = event), //手指按下回调
              onPointerMove: (PointerMoveEvent event) =>
                  setState(() => _event = event), //手指移动回调
              onPointerUp: (PointerUpEvent event) =>
                  setState(() => _event = event), //手指抬起回调
              onPointerCancel: (PointerCancelEvent event) =>
                  setState(() => _event = event), //触摸事件取消回调
              behavior: HitTestBehavior
                  .deferToChild, //命中测试表现，子组件会一个接一个的进行命中测试, 如果指针事件作用于子组件上时，其父级组件也肯定可以收到该事件。
              child: Container(
                alignment: Alignment.center,
                color: Colors.green,
                width: 400.0,
                height: 180.0,
                child: Text(
                  _event?.toString() ?? "",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Container(
              color: Colors.blue,
              child: Listener(
                onPointerDown: (PointerDownEvent event) => print("down A"),
                behavior:
                    HitTestBehavior.opaque, //在命中测试时，将当前组件当成不透明处理(即使本身是透明的)
                child: ConstrainedBox(
                  //透明组件
                  constraints: BoxConstraints.tight(Size(200, 100)),
                  child: Center(
                    child: Text("Box A"),
                  ),
                ),
              ),
            ),
            Stack(
              children: <Widget>[
                Listener(
                  onPointerDown: (PointerDownEvent event) => print("down 1"),
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tight(Size(300.0, 200.0)),
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: Colors.green),
                    ),
                  ),
                ),
                Listener(
                  onPointerDown: (PointerDownEvent event) => print("down 2"),
                  behavior: HitTestBehavior.translucent, //当点击组件透明区域时，可以对自身边界内及底部可视区域都进行命中测试
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tight(Size(200.0, 100.0)),
                    child: Center(
                      child: Text("左上角200*100范围内非文本区域点击"),
                    ),
                  ),
                ),
              ],
            ),
            Listener(
              onPointerDown: (e) => print("without"),
              // AbsorbPointer本身会参与命中测试，而IgnorePointer本身不会参与，
              // 这就意味着AbsorbPointer本身是可以接收指针事件的(但其子树不行)，而IgnorePointer不可以
              child: AbsorbPointer(
                child: Listener(
                  onPointerDown: (e) => print("within"),
                  child: Container(
                    width: 100.0,
                    height: 50.0,
                    color: Colors.blue,
                    child: Text("AbsorbPointer"),
                  ),
                ),
              ),
            ),
            Listener(
              onPointerDown: (e) => print("without"),
              // AbsorbPointer本身会参与命中测试，而IgnorePointer本身不会参与，
              // 这就意味着AbsorbPointer本身是可以接收指针事件的(但其子树不行)，而IgnorePointer不可以
              child: IgnorePointer(
                child: Listener(
                  onPointerDown: (e) => print("within"),
                  child: Container(
                    width: 100.0,
                    height: 50.0,
                    color: Colors.green,
                    child: Text("IgnorePointer"),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
