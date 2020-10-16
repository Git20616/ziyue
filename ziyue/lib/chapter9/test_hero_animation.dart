import 'package:flutter/material.dart';
import 'package:ziyue/chapter9/hero_b.dart';

class TestHeroAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Hero动画"),
      ),
      body: Container(
        child: InkWell(
          child: Hero(
            tag: "avatar",
            child: ClipOval(
              child: Image.asset(
                "images/avatar.jpg",
                width: 80.0,
              ),
            ),
          ),
          onTap: () {
            Navigator.push(context, PageRouteBuilder(
              pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation) {
                return new FadeTransition(
                  opacity: animation,
                  child: HeroB(),
                );
              }
            ));
          },
        ),
      ),
    );
  }
}
