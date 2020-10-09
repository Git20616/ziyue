import 'dart:collection';

import 'package:flutter/material.dart';

// 一个通用的InheritedWidget,保存任何需要跨组件共享的状态
class InheritedProvider<T> extends InheritedWidget {
  InheritedProvider({@required this.data, Widget child}) : super(child: child);

  //共享状态使用泛型
  final T data;

  @override
  bool updateShouldNotify(InheritedProvider oldWidget) {
    // 返回true，则每次更新都会调用依赖其的子孙节点的`didChangeDependencies`。
    print(data != oldWidget.data);
    // return data != oldWidget.data;
    return true;
  }
}

// ChangeNotifier类继承自Listenable，实现了一个Flutter风格的发布者-订阅者模式
// 订阅者类
class ChangeNotifierProvider<T extends ChangeNotifier> extends StatefulWidget {
  final Widget child;
  final T data;

  ChangeNotifierProvider({Key key, this.data, this.child});

  //获取带参数模板的类型的唯一方式
  static Type _typeOf<T>() => T;

  //定义of方法，方便子树中的Widget获取共享数据
  /// listen 是否注册依赖关系，默认true
  static T of<T>(BuildContext context, {bool listen = true}) {
    final type = _typeOf<InheritedProvider<T>>();
    final provider = listen
        ? context.inheritFromWidgetOfExactType(type) as InheritedProvider<T>
        : context.ancestorInheritedElementForWidgetOfExactType(type)?.widget
            as InheritedProvider<T>;
    return provider.data;
  }

  @override
  State<StatefulWidget> createState() {
    return _ChangeNotifierProviderState<T>();
  }
}

// _ChangeNotifierProviderState类的主要作用就是监听到共享状态（model）改变时重新构建Widget树。
// 注意，在_ChangeNotifierProviderState类中调用setState()方法，widget.child始终是同一个，
// 所以执行build时，InheritedProvider的child引用的始终是同一个子widget，
// 所以widget.child并不会重新build，这也就相当于对child进行了缓存！当然如果ChangeNotifierProvider父级Widget重新build时，则其传入的child便有可能会发生变化。
class _ChangeNotifierProviderState<T extends ChangeNotifier>
    extends State<ChangeNotifierProvider<T>> {
  void update() {
    //数据发生变化（model类调用了notifyListeners）时，重新构建InheritedProvider
    setState(() {});
  }

  @override
  void didUpdateWidget(ChangeNotifierProvider<T> oldWidget) {
    //Provider更新时，如果新旧数据不一，则解绑旧数据监听，同时添加新数据监听
    if (widget.data != oldWidget.data) {
      oldWidget.data.removeListener(update);
      widget.data.addListener(update);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    //给model添加监听器
    widget.data.addListener(update);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedProvider(
      data: widget.data,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    //移除model监听器
    widget.data.removeListener(update);
    super.dispose();
  }
}

// 购物车示例
// #1 商品信息
class Item {
  Item(this.price, this.count);
  double price;
  int count;
}

// #2 保存购物车内的商品信息，作为跨组件共享的model类
class CartModel extends ChangeNotifier {
  //用于保存购物车中的商品列表
  final List<Item> _items = [];

  //禁止改变购物车里的商品信息
  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  //计算商品总价
  double get totalPrice =>
      _items.fold(0, (value, item) => value + item.count * item.price);

  //添加商品
  void add(Item item) {
    _items.add(item);
    //通知监听器（订阅者），重新构建InheritedProvider， 更新状态。
    notifyListeners();
  }

  //移除商品
  void subtract() {
    if (_items.length > 0) {
      _items.removeLast();
      notifyListeners();
    }
  }
}

// #3 view
class ProviderRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProviderRouteState();
  }
}

class ProviderRouteState extends State<ProviderRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Provider"),
      ),
      body: Center(
        child: ChangeNotifierProvider<CartModel>(
          data: new CartModel(),
          child: Builder(
            builder: (context) {
              return Column(
                children: <Widget>[
                  // Builder(
                  //   builder: (context) {
                  //     CartModel cart =
                  //         ChangeNotifierProvider.of<CartModel>(context);
                  //     return Text("总价：${cart.totalPrice}");
                  //   },
                  // ),
                  //使用便捷类对上面的代码进行优化
                  Consumer<CartModel>(
                    builder: (context, cart) => Text("总价：${cart.totalPrice}"),
                  ),
                  Builder(
                    builder: (context) {
                      print("RaiseButton build"); //用于判断RaiseButton是否被重构
                      return RaisedButton(
                        onPressed: () {
                          ChangeNotifierProvider.of<CartModel>(context,
                                  listen: false)
                              .add(Item(10.0, 1));
                        },
                        child: Text("添加商品"),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

// 优化
// 提供一个便捷类，获取当前context和指定数据类型的Provider
class Consumer<T> extends StatelessWidget {
  Consumer({
    Key key,
    @required this.builder,
    this.child,
  })  : assert(builder != null),
        super(key: key);

  final Widget child;
  final Widget Function(BuildContext context, T value) builder;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return builder(
      context,
      ChangeNotifierProvider.of<T>(context), //自动获取model
    );
  }
}
