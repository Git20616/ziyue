import 'package:flutter/material.dart';
import 'package:ziyue/chapter5/about_container.dart';
import 'package:ziyue/chapter5/about_decorated_box.dart';
import 'package:ziyue/chapter5/about_padding.dart';
import 'package:ziyue/chapter5/about_transform.dart';
import 'package:ziyue/chapter5/one_route_page.dart';
import 'package:ziyue/chapter5/some_clip.dart';
import 'package:ziyue/chapter5/some_size_container.dart';

class Chapter5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("容器类组件"),),
      body: Center(
        child: Wrap(
          spacing: 16.0,
          runSpacing: 16.0,
          alignment: WrapAlignment.start,
          children: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => AboutPadding(),
                ));
              },
              child: Text("填充Padding"),
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => SomeSizeContainer(),
                ));
              },
              child: Text("尺寸限制类容器"),
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => AboutDecoratedBox(),
                ));
              },
              child: Text("装饰容器DecoratedBox"),
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => AboutTransform(),
                ));
              },
              child: Text("变换TransForm"),
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => AboutContainer(),
                ));
              },
              child: Text("Container容器"),
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => OneRoutePage(),
                ));
              },
              child: Text("Scaffold,TabBar,底部导航"),
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => SomeClip(),
                ));
              },
              child: Text("剪裁Clip"),
            ),
          ],
        ),
      ),
    );
  }

}