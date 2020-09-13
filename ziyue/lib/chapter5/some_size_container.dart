import 'package:flutter/material.dart';

class SomeSizeContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 定义一个背景为红色的盒子
    Widget redBox = DecoratedBox(
      decoration: BoxDecoration(color: Colors.red),
    );
    Widget greenBox = DecoratedBox(
      decoration: BoxDecoration(color: Colors.green),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("尺寸限制类容器"),
        actions: <Widget>[
          SizedBox(
            width: 20.0,
            height: 20.0, // 未生效 父容器中做了限制
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
              valueColor: AlwaysStoppedAnimation(Colors.white70),
              value: 0.8,
            ),
          ),
          UnconstrainedBox(
            // “去除”父容器限制
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: SizedBox(
                width: 20.0,
                height: 20.0,
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                  valueColor: AlwaysStoppedAnimation(Colors.white70),
                  value: 1.0,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          // ConstrainedBox用于对子组件添加额外的约束
          ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: double.infinity, // 宽度尽可能大
              minHeight: 50.0, // 最小高度为50像素
            ),
            child: Container(
              height: 5.0, // minHeight会生效
              child: redBox,
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints.tight(Size(30.0, 30.0)),
            child: Container(
              height: 5.0,
              child: greenBox,
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints.expand(width: 120.0, height: 120.0),
            child: Container(
              height: 5.0,
              child: redBox,
            ),
          ),
          ConstrainedBox(
            // ↓↓
            constraints: BoxConstraints.tightFor(width: 80.0, height: 80.0),
            child: greenBox,
          ),
          SizedBox(
            // SizedBox可以看做ConstrainedBox的定制，与上边代码等价↑↑
            width: 80.0,
            height: 80.0,
            child: redBox,
          ),
          // minWidth, minHeight多重限制取最大值
          ConstrainedBox(
            constraints: BoxConstraints(minWidth: 60.0, minHeight: 20.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: 40.0, minHeight: 40.0),
              child: greenBox,
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(minWidth: 40.0, minHeight: 40.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: 60.0, minHeight: 20.0),
              child: redBox,
            ),
          ),
          // maxWidth, maxHeight多重限制取最小值
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 90.0, maxHeight: 30.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 60.0, maxHeight: 60.0),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: greenBox,
              ),
            ),
          ),
          ConstrainedBox(
            constraints:
                BoxConstraints(minWidth: 80.0, minHeight: 80.0), // 父容器限制
            child: UnconstrainedBox(
              // “去除”父容器限制
              // UnconstrainedBox对父组件限制的“去除”并非是真正的去除，父容器的限制仍然存在留白空间
              // 可以认为此时的父ConstrainedBox是作用于子UnconstrainedBox上，而redBox只受子ConstrainedBox限制
              child: ConstrainedBox(
                constraints:
                    BoxConstraints(minWidth: 60.0, minHeight: 20.0), // 子容器限制
                child: redBox,
              ),
            ),
          ),
          Container(
            width: 180.0,
            child: AspectRatio(
              // 限制宽高比
              aspectRatio: 2.0,
              child: Container(
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
