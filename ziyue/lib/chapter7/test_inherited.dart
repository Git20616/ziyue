import 'package:flutter/material.dart';

/// InheritedWidget提供了一种数据在widget树中从上到下传递共享数据的方式
class ShareDataWidget extends InheritedWidget {
  ShareDataWidget({@required this.data, Widget child}) : super(child: child);

  final int data; //需要在子树中共享的数据， 保存点击次数

  /// 提供of方法，方便子树中的widget获取数据
  static ShareDataWidget of(BuildContext context) {
    // 调用dependOnInheritedWidgetOfExactType() 和 getElementForInheritedWidgetOfExactType()的区别就是前者会注册依赖关系，而后者不会
   // return context.dependOnInheritedWidgetOfExactType<ShareDataWidget>();
   //  return context.getElementForInheritedWidgetOfExactType<ShareDataWidget>().widget;
    return context.ancestorInheritedElementForWidgetOfExactType(ShareDataWidget).widget;
  }

  // 该回调方法决定当data发生变化时，是否通知子树中依赖data的widget
  @override
  bool updateShouldNotify(ShareDataWidget oldWidget) {
    // 如果返回true，则子树中依赖(build函数中有调用)本widget的子widget的`state.didChangeDependencies`会被调用
    return oldWidget.data != data;
  }
}

//  实现一个子组件，在组件中引用ShareWidget中的数据
class _TestInherited extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return __TestInheritedState();
  }
}

class __TestInheritedState extends State<_TestInherited> {
  @override
  Widget build(BuildContext context) {
    // 使用InheritedWidget中共享的数据
    return Text(ShareDataWidget.of(context).data.toString());
  }

  // 一般来说，子widget很少会重写此方法，因为在依赖改变后framework也都会调用build()方法。
  // 但是，如果你需要在依赖改变后执行一些昂贵的操作，比如网络请求，这时最好的方式就是在此方法中执行，这样可以避免每次build()都执行这些昂贵操作。
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //父或祖先widget中的InheritedWidget改变(updateShouldNotify返回true)时会被调用。
    //如果build中没有依赖InheritedWidget，则此回调不会被调用。
    print("Dependencies change");
  }
}

class TestInheritRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TestInheritRouteState();
  }

}

class TestInheritRouteState extends State<TestInheritRoute> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("InheritedWidget"),),
      body: Center(
        child: ShareDataWidget(
          data: _count,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: _TestInherited(),
              ),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    ++_count;
                  });
                },
                child: Text("increment"),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
