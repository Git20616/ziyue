import 'package:flutter/material.dart';
import 'package:ziyue/chapter3/cupertino_test_route.dart';

import '../intermediate_page.dart';

class CounterWidget extends StatefulWidget {
  const CounterWidget({Key key, this.initValue: 0});

  final int initValue;

  @override
  State<StatefulWidget> createState() {
    return CounterWidgetState();
  }
}

class CounterWidgetState extends State<CounterWidget> {
  int _counter;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 当 widget 第一次插入到 widget 树时被调用，对于每一个 State 对象而言，该回调只会被调用一次。
    // 所以，通常会在该回调函数中做一些一次性的操作，比如状态初始化等。
    _counter = widget.initValue;
    print("initState");
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    // 当 State 对象的依赖发生变化时被调用，典型的场景就是应用主题改变时，Flutter 会通知 widget 调用此回调。
    print("didChangeDependencies");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // 用于构建 widget 树，会在以下场景被调用：
    // 1.在调用 initState()以后
    // 2.在调用 didUpdateWidget() 以后
    // 3.在调用 setState() 以后
    // 4.在调用 didChangeDependencies() 以后
    // 5.在 State 对象从树中一个位置移除后又重新插入到树的其它位置之后（意思就是改变当前 Widget 在树中的位置）。
    print("build");

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("State生命周期"),
      ),
      body: new Center(
        child: Builder(builder: (context) {
          return new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FlatButton(
                child: Text("$_counter"),
                onPressed: () => setState(() => ++_counter),
              ),
              MaterialButton(
                child: Text("New page"),
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) {
                        return Scaffold(
                          body: new IntermediatePage(),
                        );
                      }));
                },
              ),
              RaisedButton(
                child: Text("ScaffoldState"),
                onPressed: () => getStateInWidget(context),
              ),
              RaisedButton(
                child: Text("CupertinoDemo"),
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) {
                        return CupertinoTestRoute();
                      }));
                },
              ),
            ],
          );
        }),
      ),
    );
  }

  @override
  void reassemble() {
    // TODO: implement reassemble
    super.reassemble();
    // 此回调为了开发调式提供的， 在热重载时被调用。
    print("reassemble");
  }

  @override
  void didUpdateWidget(CounterWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    // 在 widget 重新构建时，Flutter 会调用 Widget.canUpdate() 来检测 widget 树中同一个位置新的节点，然后决定是否需要更新，
    // 如果 Widget.canUpdate() 返回 true，则调用此回调。
    print("didUpdateWidget");
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    // 当 State 对象从树中移除时，会调用此回调。
    print("deactivate");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // 当 State 对象从树中被永久移除时调用。
    print("dispose");
  }

  void getStateInWidget(BuildContext context) {
    // 查找父级最近的Scaffold对应的ScaffoldState对象
    // 注意：下面的两种方法，均只能在Builder中实现，即，context用builder匿名方法中的context形参
//    ScaffoldState _state = context.ancestorStateOfType(const TypeMatcher<ScaffoldState>());
//    _state.showSnackBar(new SnackBar(content: new Text("I am SnackBar")));
    ScaffoldState _state=Scaffold.of(context);
    _state.showSnackBar(
      SnackBar(
        content: Text("我是SnackBar"),
      ),
    );
  }
}

