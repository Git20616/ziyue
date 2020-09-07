import 'package:flutter/material.dart';

class SomeLinearLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("线性布局"),),
      backgroundColor: Colors.green[200],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max, // 有效，外层column高度为整个屏幕
        children: <Widget>[
          Text("hello flutter "),
          Text("nice to meet you"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("hello flutter "),
              Text("nice to meet you"),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min, // 默认max
            mainAxisAlignment: MainAxisAlignment.center, // mainAxisSize值为MainAxisSize.min，则此属性无意义
            children: <Widget>[
              Text("hello flutter "),
              Text("nice to meet you"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end, // 从结束位置排列，先判定textDirection属性
            textDirection: TextDirection.rtl, // 从右往左排列，默认ltr
            children: <Widget>[
              Text("hello flutter "),
              Text("nice to meet you"),
            ],
          ),
          Row(
            children: <Widget>[
              Text("hello flutter ", style: TextStyle(
                fontSize: 25.0,
              ),),
              Text("nice to meet you"),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("hello flutter ", style: TextStyle(
                fontSize: 25.0,
              ),),
              Text("nice to meet you"),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start, // 从开始位置排列，先判定verticalDirection
            verticalDirection: VerticalDirection.up, // 从低到高排列，默认down
            children: <Widget>[
              Text("hello flutter ", style: TextStyle(
                fontSize: 25.0,
              ),),
              Text("nice to meet you"),
            ],
          ),
          Container(
            color: Colors.red[400],
            child: Column(
              mainAxisSize: MainAxisSize.max, // 无效，内层column高度为实际高度
              children: <Widget>[
                Text("hello flutter "),
                Text("nice to meet you"),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.orange,
              child: Column(
//                mainAxisSize: MainAxisSize.max, // 该属性无效
                children: <Widget>[
                  Text("hello flutter "),
                  Text("nice to meet you"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}