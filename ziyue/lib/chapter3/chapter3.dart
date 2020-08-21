import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ziyue/chapter3/some_button.dart';
import 'package:ziyue/chapter3/state_lifecycle.dart';
import 'package:ziyue/chapter3/state_manage.dart';
import 'package:ziyue/chapter3/text_font_style.dart';

import 'Image_icon.dart';

class Chapter3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("基础组件"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  child: Text("State生命周期"),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return CounterWidget();
                        }
                    ));
                  },
                  color: Colors.blue,
                ),
                RaisedButton(
                  child: Text("返回"),
                  onPressed: () {
                    Navigator.pop(context, "I came from chapter3");
                  },
                  color: Colors.blue,
                ),
                FlatButton(
                  child: Text("状态管理"),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return StateManage();
                    }));
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  child: Text("文本字体样式"),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return TextFontStyle();
                    }));
                  },
                ),
                FlatButton(
                  child: Text("按钮",
                    style: TextStyle(
                      fontFamily: "Peony",
                      fontSize: 20.0,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return SomeButton();
                      }
                    ));
                  },
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return Scaffold(
                          appBar: AppBar(
                            title: Text(
                              "图片与图标",
                              style: TextStyle(
                                fontFamily: "peony",
                              ),
                            ),
                          ),
                          body: ImageAndIcon(),
                        );
                      },
                    ));
                  },
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    "Image与Icon",
                    style: TextStyle(
                      fontFamily: "Narcissus",
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

}