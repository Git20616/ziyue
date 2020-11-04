import 'package:flutter/material.dart';

class TestTexture extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TestTextureState();
  }
}

class TestTextureState extends State<TestTexture> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("相机示例"),),
    );
  }
}