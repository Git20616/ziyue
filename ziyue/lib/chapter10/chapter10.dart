import 'package:flutter/material.dart';
import 'package:ziyue/chapter10/test_gradient_buttom.dart';

class Chapter10 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("自定义组件"),),
      body: Center(
        child: Wrap(
          spacing: 16.0,
          runSpacing: 16.0,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => TestGradientButton(),
                ));
              },
              child: Text("组合现有组件"),
            ),
          ],
        ),
      ),
    );
  }
}