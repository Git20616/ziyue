import 'package:flutter/material.dart';

class AboutWillPopScope extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AboutWillPopScopeState();
  }
}

class AboutWillPopScopeState extends State<AboutWillPopScope> {
  DateTime _lastPressedAt; //记录上一次点击的时间

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("WillPopScope"),
      ),
      body: Builder(
        builder: (BuildContext context) {

          return WillPopScope(
            onWillPop: () async {
              // 两次点击超过1秒，则重新计时
              if(_lastPressedAt == null || DateTime.now().difference(_lastPressedAt) > Duration(seconds: 1)) {
                _lastPressedAt = DateTime.now();
                //
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text("再按一次退出"),
                  duration: Duration(seconds: 1),
                ));
                return false;
              }
              return true; //返回true当前路由出栈退出
            },
            child: Container(
              alignment: Alignment.center,
              child: Text("1秒内连续点击两次返回键退出"),
            ),
          );
        },
      ),
    );
  }
}
