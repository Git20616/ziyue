import 'package:flutter/material.dart';
import 'package:ziyue/chapter4/about_align.dart';
import 'package:ziyue/chapter4/some_flexbox_layout.dart';
import 'package:ziyue/chapter4/some_frame_layout.dart';
import 'package:ziyue/chapter4/some_linear_layout.dart';
import 'package:ziyue/chapter4/wrap_and_flow.dart';

class Chapter4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("布局类组件"),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => SomeLinearLayout(),
                  ));
                },
                child: Text("线性布局"),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => SomeFlexboxLayout(),
                  ));
                },
                child: Text("弹性布局"),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => WrapAndFlow(),
                  ));
                },
                child: Text("流式布局"),
              ),

            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => SomeFrameLayout(),
                  ));
                },
                child: Text("层叠布局"),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => AboutAlign(),
                  ));
                },
                child: Text("对齐与相对定位"),
              ),
            ],
          ),
        ],
      ),
    );
  }

}