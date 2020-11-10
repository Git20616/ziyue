import 'package:flutter/material.dart';

class TestElement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("自定义UI框架"),),
      body: CustomHome(),
    );
  }
}

// 通过纯粹的Element来模拟一个StatefulWidget的功能
class HomeView extends ComponentElement{
  HomeView(Widget widget) : super(widget);
  String text = "123456789";

  @override
  Widget build() {
    //需要用到BuildContext的地方直接用this代替即可，因为当前对象本身就是Element实例。
    Color primary = Theme.of(this).primaryColor;

    return Center(
      child: FlatButton(
        onPressed: () {
          List<String> t = text.split("")..shuffle();
          text = t.join();
          markNeedsBuild();//点击后将该Element标记为dirty，Element将会rebuild
        },
        child: Text(text, style: TextStyle(color: primary),),
      ),
    );
  }
}

// 将Element包装成Widget
class CustomHome extends Widget {
  @override
  Element createElement() {
    return HomeView(this);
  }
}