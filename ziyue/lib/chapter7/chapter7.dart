import 'package:flutter/material.dart';
import 'package:ziyue/chapter7/about_will_pop_scope.dart';
import 'package:ziyue/chapter7/future_and_stream.dart';
import 'package:ziyue/chapter7/some_dialog.dart';
import 'package:ziyue/chapter7/test_inherited.dart';
import 'package:ziyue/chapter7/test_provider.dart';
import 'package:ziyue/chapter7/test_theme.dart';

class Chapter7 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("功能型组件"),
      ),
      body: Center(
        child: Wrap(
          spacing: 16.0,
          runSpacing: 16.0,
          children: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AboutWillPopScope(),
                    ));
              },
              child: Text("导航返回拦截"),
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TestInheritRoute(),
                    ));
              },
              child: Text("数据共享"),
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProviderRoute(),
                    ));
              },
              child: Text("跨组件数据共享"),
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => TestTheme(),
                ));
              },
              child: Text("颜色与主题"),
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => FutureAndStream(),
                ));
              },
              child: Text("异步UI更新"),
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => SomeDialog(),
                ));
              },
              child: Text("对话框详解"),
            ),
          ],
        ),
      ),
    );
  }
}
