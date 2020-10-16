import 'package:flutter/material.dart';
import 'package:ziyue/chapter9/my_page_route.dart';
import 'package:ziyue/one_page.dart';

class TestRouteAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("自定义路由过渡动画"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.push(context, PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 800),
                  pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation) {
                    return new FadeTransition(
                      opacity: animation,
                      child: OnePage(),
                    );
                  },
                ));
              },
              child: Text("使用PageRouteBuilder"),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(context, MyPageRoute(
                  builder1: (context) => OnePage(),
                  transitionDuration1: Duration(milliseconds: 800),
                ));
              },
              child: Text("封装PageRoute"),
            ),
          ],
        ),
      ),
    );
  }
}