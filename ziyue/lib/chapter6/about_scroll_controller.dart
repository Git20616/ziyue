import 'package:flutter/material.dart';

class AboutScrollController extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AboutScrollControllerState();
  }
}

class AboutScrollControllerState extends State<AboutScrollController> {
  ScrollController _scrollController = new ScrollController();
  bool showToTopBtn = false; //是否显示返回顶部按钮

  @override
  void initState() {
    super.initState();
    // 监听滚动事件，打印滚动位置
    _scrollController.addListener(() {
      print(_scrollController.offset); //打印滚动位置
      // 控制按钮的显示与隐藏
      if (_scrollController.offset < 1000 && showToTopBtn) {
        setState(() {
          showToTopBtn = false;
        });
      } else if (_scrollController.offset >= 1000 && !showToTopBtn) {
        setState(() {
          showToTopBtn = true;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose(); //销毁控制器，避免内测泄露
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("滚动控制"),
      ),
      body: Scrollbar(
        child: ListView.builder(
          itemCount: 100,
          itemExtent: 50.0, //列表项高度固定时，显示指定是一个好习惯（性能消耗小）
          controller: _scrollController,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text("list item $index"),
            );
          },
        ),
      ),
      floatingActionButton: !showToTopBtn
          ? null
          : FloatingActionButton(
              onPressed: () {
                // 点击返回顶部，执行动画
                _scrollController.animateTo(
                  0.0,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.ease, //动画曲线
                );
              },
              child: Icon(Icons.arrow_upward),
            ),
    );
  }
}
