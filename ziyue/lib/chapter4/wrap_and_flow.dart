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
        ],
      ),
    );
  }
}