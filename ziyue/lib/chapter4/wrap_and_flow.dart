import 'package:flutter/material.dart';

class WrapAndFlow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("流式布局"),),
      body: Column(
        children: <Widget>[
          Wrap(
            spacing: 8.0, // 主轴（水平）方向间距
            runSpacing: 4.0, // 纵轴（垂直）方向间距
            alignment: WrapAlignment.start,
            children: <Widget>[
              Chip(
                avatar: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text("李"),
                ),
                label: Text("李白"),
              ),
              Chip(
                avatar: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text("安"),
                ),
                label: Text("安得倚天剑"),
              ),
              Chip(
                avatar: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text("跨"),
                ),
                label: Text("跨海斩长鲸"),
              ),
              Chip(
                avatar: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text("F"),
                ),
                label: Text("Flutter"),
              ),
              Chip(
                avatar: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text("江"),
                ),
                label: Text("江湖夜雨十年灯"),
              ),
              Chip(
                avatar: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text("H"),
                ),
                label: Text("Hello Flutter"),
              ),
            ],
          ),
          Container(
            color: Colors.grey[200],
            child: Flow(
              // 需要自己实现子widget的位置转换
              delegate: TestFlowDelegate(margin: EdgeInsets.all(10.0)),
              children: <Widget>[
                Container(width: 180.0, height: 80.0, color: Colors.red, child: FlatButton(onPressed: () {}, child: null,),),
                Container(width: 180.0, height: 80.0, color: Colors.orange, child: FlatButton(onPressed: () {}, child: null,),),
                Container(width: 80.0, height: 80.0, color: Colors.yellow,),
                Container(width: 80.0, height: 80.0, color: Colors.green,),
                Container(width: 80.0, height: 80.0, color: Colors.blue,),
                Container(width: 180.0, height: 80.0, color: Colors.indigo,),
                Container(width: 80.0, height: 80.0, color: Colors.purple, child: FlatButton(onPressed: () {}, child: null,),),
              ],
            ),
          ),

        ],
      ),
    );
  }
}

// 自己实现FlowDelegate
class TestFlowDelegate extends FlowDelegate {
  EdgeInsets margin = EdgeInsets.zero; // 用于设置子widget外边距
  TestFlowDelegate({this.margin});

  @override
  void paintChildren(FlowPaintingContext context) {
    // TODO: implement paintChildren
    double x = margin.left;
    double y = margin.top;

    // 计算每个子widget的位置
    for(int i = 0; i < context.childCount; ++i) {
      double w = x + context.getChildSize(i).width + margin.right;
      if(w <= context.size.width) { // 判断是否超出边界
        // 绘制子widget,可以理解为将i进行了位置平移变换
        context.paintChild(i, transform: Matrix4.translationValues(x, y, 0.0));
        x = w + margin.left; // 更新x
      }else {
        x = margin.left; // 重置x
        y = y + context.getChildSize(i).height + margin.bottom + margin.top; // 更新y
        context.paintChild(i, transform: Matrix4.translationValues(x, y, 0.0));
        x = x + context.getChildSize(i).width + margin.right + margin.left;
      }
    }

  }

  @override
  Size getSize(BoxConstraints constraints) {
    // TODO: implement getSize
    return Size(double.infinity, 300); // 想最大的扩展宽度，可以将宽度值设为double.infinity。
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    // TODO: implement shouldRepaint
    return oldDelegate != this; // 是否重绘
  }

}