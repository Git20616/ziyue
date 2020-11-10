import 'package:flutter/material.dart';
import 'package:ziyue/chapter14/test_element.dart';
import 'package:ziyue/chapter14/test_my_image.dart';

class Chapter14 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter核心原理"),),
      body: Center(
        child: Wrap(
          spacing: 16.0,
          runSpacing: 16.0,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => TestElement(),
                ));
              },
              child: Text("用Element模拟StatefulWidget"),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => TestMyImage(),
                ));
              },
              child: Text("Image组件原理"),
            ),
          ],
        ),
      ),
    );
  }
}