import 'package:flutter/material.dart';
import 'package:ziyue/chapter6/about_custom_scrollview.dart';
import 'package:ziyue/chapter6/about_gridview_a.dart';
import 'package:ziyue/chapter6/about_gridview_b.dart';
import 'package:ziyue/chapter6/about_listview_a.dart';
import 'package:ziyue/chapter6/about_listview_b.dart';
import 'package:ziyue/chapter6/about_listview_c.dart';
import 'package:ziyue/chapter6/about_scroll_controller.dart';
import 'package:ziyue/chapter6/about_scroll_notification.dart';
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
            FlatButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => AboutListViewB(),
                ));
              },
              child: Text("无线加载的ListView"),
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => AboutListViewC(),
                ));
              },
              child: Text("带表头的列表"),
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => AboutGridViewA(),
                ));
              },
              child: Text("二维网格列表GridView"),
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => AboutGridViewB(),
                ));
              },
              child: Text("GridView.builder"),
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => AboutCustomScrollView(),
                ));
              },
              child: Text("CustomScrollView"),
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => AboutScrollController(),
                ));
              },
              child: Text("ScrollController"),
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => AboutScrollNotification(),
                ));
              },
              child: Text("滚动监听"),
            ),
          ],
        ),
      ),
    );
  }

}