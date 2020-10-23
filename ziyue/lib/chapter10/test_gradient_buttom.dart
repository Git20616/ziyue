import 'package:flutter/material.dart';
import 'package:ziyue/chapter10/gradient_button.dart';

class TestGradientButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TestGradientButtonState();
  }
}

class TestGradientButtonState extends State<TestGradientButton> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("自定义渐变按钮"),),
      body: Column(
        children: <Widget>[
          GradientButton(
            colors: [Colors.orange, Colors.red],
            height: 50.0,
            child: Text("Submit"),
            onPressed: () {
              print("on click");
            },
          ),
          GradientButton(
            colors: [Colors.lightGreen, Colors.green[700]],
            height: 50.0,
            child: Text("Submit"),
            onPressed: () {},
          ),
          GradientButton(
            colors: [Colors.lightBlue, Colors.blueAccent],
            height: 50.0,
            child: Text("Submit"),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}