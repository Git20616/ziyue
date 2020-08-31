import 'package:flutter/material.dart';

class SomeLinearLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("线性布局"),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          
        ],
      ),
    );
  }

}