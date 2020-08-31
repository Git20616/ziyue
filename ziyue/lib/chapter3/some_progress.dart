import 'package:flutter/material.dart';

class SomeProgress extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SomeProgressState();
  }
}

class SomeProgressState extends State<SomeProgress>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //
    _animationController =
        new AnimationController(vsync: this, duration: Duration(seconds: 3));
    _animationController.forward();
    _animationController.addListener(() => setState(() => {}));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Theme(
      data: ThemeData(
        fontFamily: "peony",
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text("进度指示器"),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
          child: Column(
            children: <Widget>[
              LinearProgressIndicator(
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation(Colors.blue),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: LinearProgressIndicator(
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
                  value: 0.5,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
                  value: 0.5,
                ),
              ),
              // 自定义尺寸
              // 可以通过容器类组件如ConstrainedBox、SizedBox来制定尺寸
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: SizedBox(
                  height: 3,
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation(Colors.blue),
                    value: 0.5,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: SizedBox(
                  height: 100.0,
                  width: 100.0, // 这里宽与高都必须定义
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation(Colors.blue),
                    value: 0.5,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: LinearProgressIndicator(
                  backgroundColor: Colors.grey[200],
                  valueColor: ColorTween(begin: Colors.grey, end: Colors.blue).animate(_animationController), //给进度色添加动画
                  value: _animationController.value,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
