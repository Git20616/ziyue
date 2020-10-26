import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ziyue/chapter10/turn_box.dart';

class TestTurnBox extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TestTurnBoxState();
  }
}

class TestTurnBoxState extends State<TestTurnBox> {
  double _turns = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("组合实例TurnBox"),),
      body: Center(
        child: Column(
          children: <Widget>[
            TurnBox(
              turns: _turns,
              duration: Duration(milliseconds: 500),
              child: Icon(Icons.refresh, size: 50.0,),
            ),
            TurnBox(
              turns: _turns,
              duration: Duration(milliseconds: 1000),
              child: Icon(Icons.refresh, size: 150.0,),
            ),
            RaisedButton(
              onPressed: () {
                setState(() {
                  _turns = ((_turns * 10 + 2).toInt()) / 10;
                });
                print(_turns);
              },
              child: Text("顺时针旋转1/5圈"),
            ),
            RaisedButton(
              onPressed: () {
                setState(() {
                  _turns = ((_turns * 10 - 2).toInt()) / 10;
                });
                print(_turns);
              },
              child: Text("逆时针旋转1/5圈"),
            ),
          ],
        ),
      ),
    );
  }
}