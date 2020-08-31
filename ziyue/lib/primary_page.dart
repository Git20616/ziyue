import 'package:flutter/material.dart';
import 'package:ziyue/chapter3/chapter3.dart';
import 'package:ziyue/chapter4/chapter4.dart';

import 'chapter3/state_lifecycle.dart';

class PrimaryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 在Widget树中向上查找最近的父级`Scaffold` widget
    Scaffold scaffold = context.ancestorWidgetOfExactType(Scaffold);
    String ancestorTitle = (scaffold.appBar as AppBar).title.toString();
    debugPrint("父级Widget的title: $ancestorTitle");

    return Center(
//      child: Text("入门"),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              (scaffold.appBar as AppBar).title,
              new FlatButton(
                onPressed: () async {
                  var result = await Navigator.push(context, new MaterialPageRoute(
                    builder: (context) => new Chapter3(),
                  ));
                  print("路由返回值：$result");
                },
                child: new Text("基础组件"),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return Chapter4();
                    },
                  ));
                },
                child: Text("布局类组件"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}