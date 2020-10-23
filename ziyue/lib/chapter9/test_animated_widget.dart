import 'package:flutter/material.dart';
import 'package:ziyue/chapter9/animated_decorated_box.dart';

class TestAnimatedWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TestAnimatedWidgetState();
  }
}

// AnimatedPadding	        在padding发生变化时会执行过渡动画到新状态
// AnimatedPositioned	      配合Stack一起使用，当定位状态发生变化时会执行过渡动画到新的状态。
// AnimatedOpacity	        在透明度opacity发生变化时执行过渡动画到新状态
// AnimatedAlign	          当alignment发生变化时会执行过渡动画到新的状态。
// AnimatedContainer	      当Container属性发生变化时会执行过渡动画到新的状态。
// AnimatedDefaultTextStyle	当字体样式发生变化时，子组件中继承了该样式的文本组件会动态过渡到新样式。
class TestAnimatedWidgetState extends State<TestAnimatedWidget> {
  double _padding = 10.0;
  double _left = 0;
  double _opacity = 0.2;
  Alignment _align = Alignment.topLeft;
  double _height = 100.0;
  Color _color = Colors.red;
  TextStyle _style = TextStyle(color: Colors.black, fontSize: 18.0);
  Color _decorationColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    Duration duration = Duration(seconds: 5);
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter预置的动画过渡组件"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                setState(() {
                  _padding = 20.0;
                });
              },
              child: AnimatedPadding(
                duration: duration,
                padding: EdgeInsets.all(_padding),
                child: Text("AnimatedPadding"),
              ),
            ),
            SizedBox(
              height: 60.0,
              child: Stack(
                children: <Widget>[
                  AnimatedPositioned(
                    duration: duration,
                    left: _left,
                    child: RaisedButton(
                      onPressed: () {
                        setState(() {
                          _left = 100.0;
                        });
                      },
                      child: Text("AnimatedPositioned"),
                    ),
                  ),
                ],
              ),
            ),
            AnimatedOpacity(
              duration: duration,
              opacity: _opacity,
              child: RaisedButton(
                onPressed: () {
                  setState(() {
                    _opacity = 1.0;
                  });
                },
                color: Colors.blue,
                child: Text("AnimatedOpacity"),
              ),
            ),
            Container(
              height: 100.0,
              color: Colors.grey,
              child: AnimatedAlign(
                duration: duration,
                alignment: _align,
                child: RaisedButton(
                  onPressed: () {
                    setState(() {
                      _align = Alignment.center;
                    });
                  },
                  child: Text("AnimatedAlign"),
                ),
              ),
            ),
            AnimatedContainer(
              duration: duration,
              height: _height,
              color: _color,
              child: FlatButton(
                onPressed: () {
                  setState(() {
                    _height = 150.0;
                    _color = Colors.green;
                  });
                },
                child: Text(
                  "AnimatedContainer",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            AnimatedDefaultTextStyle(
              duration: duration,
              style: _style,
              child: GestureDetector(
                child: Text("AnimatedDefaultTextStyle"),
                onTap: () {
                  setState(() {
                    _style = TextStyle(
                      color: Colors.orange,
                      fontSize: 36.0,
                    );
                  });
                },
              ),
            ),
            AnimatedDecoratedBox(
              duration: duration,
              decoration: BoxDecoration(color: _decorationColor),
              child: FlatButton(
                onPressed: () {
                  setState(() {
                    _decorationColor = Colors.blue;
                  });
                },
                child: Text("AnimatedDecoratedBox"),
              ),
            ),
          ].map((item) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: item,
            );
          }).toList(),
        ),
      ),
    );
  }
}
