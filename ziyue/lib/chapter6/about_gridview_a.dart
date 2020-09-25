import 'package:flutter/material.dart';

class AboutGridViewA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("网格列表GridView"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: GridView(
              // 横轴为固定数量子元素的layout算法
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, //横轴3个子Widget
                childAspectRatio: 2.0, //子Widget宽高比为2.0
              ),
              children: <Widget>[
                Icon(Icons.ac_unit),
                Icon(Icons.airport_shuttle),
                Icon(Icons.all_inclusive),
                Icon(Icons.beach_access),
                Icon(Icons.cake),
                Icon(Icons.free_breakfast),
              ],
            ),
          ),
          Spacer(
            flex: 1,
          ),
          Expanded(
            flex: 3,
            // GridView.count构造函数内部使用了SliverGridDelegateWithFixedCrossAxisCount
            // 这里的代码等价于第一个GridView
            child: GridView.count(
              crossAxisCount: 3,
              childAspectRatio: 2.0,
              children: <Widget>[
                Icon(Icons.ac_unit),
                Icon(Icons.airport_shuttle),
                Icon(Icons.all_inclusive),
                Icon(Icons.beach_access),
                Icon(Icons.cake),
                Icon(Icons.free_breakfast),
              ],
            ),
          ),
          Spacer(
            flex: 1,
          ),
          Expanded(
            flex: 3,
            // 横轴为固定最大长度的layout算法
            child: GridView(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 120,
                childAspectRatio: 2.0,
              ),
              children: <Widget>[
                Icon(Icons.ac_unit),
                Icon(Icons.airport_shuttle),
                Icon(Icons.all_inclusive),
                Icon(Icons.beach_access),
                Icon(Icons.cake),
                Icon(Icons.free_breakfast),
              ],
            ),
          ),
          Spacer(
            flex: 1,
          ),
          Expanded(
            flex: 3,
            // GridView.extent构造函数内部使用了SliverGridDelegateWithMaxCrossAxisExtent
            // 这里的代码等价于第三个GridView
            child: GridView.extent(
              maxCrossAxisExtent: 120,
              childAspectRatio: 2.0,
              children: <Widget>[
                Icon(Icons.ac_unit),
                Icon(Icons.airport_shuttle),
                Icon(Icons.all_inclusive),
                Icon(Icons.beach_access),
                Icon(Icons.cake),
                Icon(Icons.free_breakfast),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
