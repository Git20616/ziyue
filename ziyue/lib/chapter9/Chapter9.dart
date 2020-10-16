import 'package:flutter/material.dart';
import 'package:ziyue/chapter9/test_base_animation.dart';
import 'package:ziyue/chapter9/test_hero_animation.dart';
import 'package:ziyue/chapter9/test_route_animation.dart';
import 'package:ziyue/chapter9/test_stagger_animation.dart';

class Chapter9 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("动画"),),
      body: Center(
        child: Wrap(
          spacing: 16.0,
          runSpacing: 16.0,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => TestBaseAnimation(),
                ));
              },
              child: Text("动画结构"),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => TestRouteAnimation(),
                ));
              },
              child: Text("自定义路由过渡动画"),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => TestHeroAnimation(),
                ));
              },
              child: Text("Hero动画"),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => TestStaggerAnimation(),
                ));
              },
              child: Text("交织动画"),
            ),
          ],
        ),
      ),
    );
  }
}