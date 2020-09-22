import 'package:flutter/material.dart';

class AboutListViewA extends StatelessWidget {
  //定义两条分割线
  Divider _divider1 = Divider(color: Colors.blue,);
  Divider _divider2 = Divider(color: Colors.green,);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("默认构造函数与builder"),
      ),
      body: Column(
        children: <Widget>[
          // 默认构造函数构建的ListView没有应用基于Sliver的懒加载模型。实际上通过此方式创建的ListView和使用SingleChildScrollView+Column的方式没有本质的区别。
          // 再次强调，可滚动组件通过一个List来作为其children属性时，只适用于子组件较少的情况，这是一个通用规律，并非ListView自己的特性，像GridView也是如此。
          ListView(
            // itemExtent：该参数如果不为null，则会强制children的“长度”为itemExtent的值；
            // 这里的“长度”是指滚动方向上子组件的长度，也就是说如果滚动方向是垂直方向，则itemExtent代表子组件的高度；
            // 如果滚动方向为水平方向，则itemExtent就代表子组件的宽度。
            // 在ListView中，指定itemExtent比让子组件自己决定自身长度会更高效，这是因为指定itemExtent后，滚动系统可以提前知道列表的长度，而无需每次构建子组件时都去再计算一下，尤其是在滚动位置频繁变化时（滚动系统需要频繁去计算列表高度）。
            itemExtent: 30.0,
            shrinkWrap: true, //该属性表示是否根据子组件的总长度来设置ListView的长度，默认值为false 。
            padding: const EdgeInsets.all(10.0),
            children: <Widget>[
              const Text('I\'m dedicating every day to you'),
              const Text('Domestic life was never quite my style'),
              const Text('When you smile, you knock me out, I fall apart'),
              const Text('And I thought I was so smart'),
            ],
          ),
          Expanded(
            flex: 1,
            // ListView.builder适合列表项比较多（或者无限）的情况，因为只有当子组件真正显示的时候才会被创建，也就说通过该构造函数创建的ListView是支持基于Sliver的懒加载模型的。
            child: ListView.builder(
              itemCount: 30,
              itemExtent: 50.0,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text("$index"),
                );
              },
            ),
          ),
          Expanded(
            flex: 1,
            // ListView.separated可以在生成的列表项之间添加一个分割组件，它比ListView.builder多了一个separatorBuilder参数，该参数是一个分割组件生成器。
            child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return ListTile(title: Text("$index"),);
              },
              separatorBuilder: (BuildContext context, int index) {
                return index % 2 == 0 ? _divider1 : _divider2;
              },
              itemCount: 30,
            ),
          ),
        ],
      ),
    );
  }
}
