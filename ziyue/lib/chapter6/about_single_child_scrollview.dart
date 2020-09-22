import 'package:flutter/material.dart';

class AboutSingleChildScrollView extends StatelessWidget {
  final String _str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("SingleChildScrollView"),
      ),
      body: Scrollbar( //显示进度条
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: _str //动态创建List<Widget>
                  .split("")
                  .map((item) => Text(
                        item,
                        textScaleFactor: 2.0,
                      ))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
