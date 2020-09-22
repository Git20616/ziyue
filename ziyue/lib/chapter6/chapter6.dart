import 'package:flutter/material.dart';
import 'package:ziyue/chapter6/about_listview_a.dart';
import 'package:ziyue/chapter6/about_single_child_scrollview.dart';

class Chapter6 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("可滚动组件"),),
      body: Center(
        child: Wrap(
          spacing: 16.0,
          runSpacing: 16.0,
          children: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => AboutSingleChildScrollView(),
                ));
              },
              child: Text("SingleChildScrollView"),
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => AboutListViewA(),
                ));
              },
              child: Text("一个简单的ListView"),
            ),
          ],
        ),
      ),
    );
  }

}