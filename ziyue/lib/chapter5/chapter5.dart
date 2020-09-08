import 'package:flutter/material.dart';
import 'package:ziyue/chapter5/about_padding.dart';

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
                  builder: (context) => null,
                ));
              },
              child: Text("尺寸限制类容器"),
            ),
          ],
        ),
      ),
    );
  }

}