import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StateManage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("状态管理"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FlatButton(
              child: Text("管理自身状态"),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

}