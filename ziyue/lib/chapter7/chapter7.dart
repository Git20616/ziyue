import 'package:flutter/material.dart';
import 'package:ziyue/chapter7/about_will_pop_scope.dart';

class Chapter7 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("功能型组件"),
      ),
      body: Center(
        child: Wrap(
          spacing: 16.0,
          runSpacing: 16.0,
          children: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AboutWillPopScope(),
                    ));
              },
              child: Text("导航返回拦截"),
            ),
          ],
        ),
      ),
    );
  }
}
