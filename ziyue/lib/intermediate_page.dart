import 'package:flutter/material.dart';
import 'package:ziyue/chapter11/chapter11.dart';
import 'package:ziyue/chapter8/chapter8.dart';
import 'package:ziyue/chapter9/chapter9.dart';

import 'chapter10/chapter10.dart';

class IntermediatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Wrap(
        spacing: 16.0,
        runSpacing: 16.0,
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Chapter8(),
                  ));
            },
            child: Text("事件处理与通知"),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => Chapter9(),
              ));
            },
            child: Text("动画"),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => Chapter10(),
              ));
            },
            child: Text("自定义组件"),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => Chapter11(),
              ));
            },
            child: Text("文件操作与网络请求"),
          ),
        ],
      ),
    );
  }
}
