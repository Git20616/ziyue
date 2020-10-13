import 'package:flutter/material.dart';
import 'package:ziyue/chapter8/test_pointer_event.dart';

class Chapter8 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("事件处理与通知"),),
      body: Center(
        child: Wrap(
          spacing: 16.0,
          runSpacing: 16.0,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) => TestPointerEvent(),
                ));
              },
              child: Text("原始指针事件处理"),
            ),
          ],
        ),
      ),
    );
  }
}