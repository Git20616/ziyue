import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SomeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Theme(
      data: ThemeData(
        fontFamily: "Narcissus",
        primaryColor: Colors.blue,
      ),
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  child: Text("RaiseButton"),
                  onPressed: () {},
                ),
                FlatButton(
                  child: Text("FlatButton"),
                  onPressed: () {},
                ),
                OutlineButton(
                  child: Text("OutlineButton"),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(
                    IconData(
                      0xebbd,
                      fontFamily: "IconFont",
                    ),
                    size: 30.0,
                    color: Color(0xFFF59F9F),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            // 带图标的button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton.icon(onPressed: () {}, icon: Icon(Icons.send), label: Text("send")),
                FlatButton.icon(onPressed: () {}, icon: Icon(Icons.add), label: Text("add")),
                OutlineButton.icon(onPressed: () {}, icon: Icon(Icons.info), label: Text("info")),
              ],
            ),
            // 自定义button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  color: Colors.blue,
                  // 按钮按下时的背景颜色
                  highlightColor: Colors.blue[700],
                  // 按钮主题
                  colorBrightness: Brightness.dark,
                  // 点击时，水波动画中水波的颜色
                  splashColor: Colors.grey,
                  child: Text("submit"),
                  // 外形
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  onPressed: () {},
                ),
                RaisedButton(
                  onPressed: () {},
                  textColor: Color(0xFFFFFFFF),
                  // 按钮禁用时文字颜色
                  disabledTextColor: Color(0x00000000),
                  color: Colors.blue,
                  // 按钮禁用时的背景颜色
                  disabledColor: Colors.grey,
                  highlightColor: Colors.blue[700],
                  splashColor: Colors.grey,
                  colorBrightness: Brightness.dark,
                  // 内边距
                  padding: EdgeInsets.only(right: 2.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text("submit"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}