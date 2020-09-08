import 'package:flutter/material.dart';

class AboutPadding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("填充Padding"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Container(
          color: Colors.green[200],
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start, // 左对齐，排除干扰
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text("左边8像素留白"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text("上下8像素留白"),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, .0, 20.0, 20.0),
                child: Text("指定4个方向上的留白"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
