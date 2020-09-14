import 'package:flutter/material.dart';

class AboutDecoratedBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("装饰容器"),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.0), // 3像素圆角
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  offset: Offset(2.0, 2.0),
                  blurRadius: 4.0,
                ),
              ],
              gradient: LinearGradient(
                colors: [Colors.red, Colors.orange[700]],
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 80.0),
              child: Text("Sign in", style: TextStyle(color: Colors.white),),
            ),
          ),
        ],
      ),
    );
  }

}