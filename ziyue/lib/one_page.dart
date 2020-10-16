import 'package:flutter/material.dart';

class OnePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("One Page"),),
      body: Center(
        child: Container(
          width: 400.0,
          child: Image.asset("images/avatar.jpg"),
        ),
      ),
    );
  }
}