import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SwitchAndCheckBoxText extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SwitchAndCheckBoxTextState();
  }
}

class SwitchAndCheckBoxTextState extends State<SwitchAndCheckBoxText> {
  bool _switchSelected = true; // 维护单选开关状态
  bool _checkboxSekected = true; // 维护复习框状态

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "单选框与复选框",
          style: TextStyle(
            fontFamily: "peony",
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Switch(
            value: _switchSelected, // 当前状态
            onChanged: (value) {
              // 状态改变时触发回调
              setState(() {
                _switchSelected = value;
              });
            },
          ),
          Checkbox(
              value: _checkboxSekected,
              onChanged: (value) {
                setState(() {
                  _checkboxSekected = value;
                });
              }),
        ],
      ),
    );
  }
}
