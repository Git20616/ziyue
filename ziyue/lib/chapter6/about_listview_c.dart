import 'package:flutter/material.dart';

class AboutListViewC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("优雅地添加固定列表头"),
      ),
      // Column是继承自Flex的，可以使用Column+Expanded来实现代表头的列表
      body: Column(
        children: <Widget>[
          ListTile(
            title: Text("商品列表"),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return ListTile(title: Text("$index"),);
              },
            ),
          ),
        ],
      ),
    );
  }
}
