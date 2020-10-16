import 'package:flutter/material.dart';

class HeroB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("原图"),),
      body: Center(
        child: Hero(
          tag: "avatar",
          child: Image.asset("images/avatar.jpg"),
        ),
      ),
    );
  }

}