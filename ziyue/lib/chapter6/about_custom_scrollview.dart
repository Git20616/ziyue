import 'package:flutter/material.dart';

class AboutCustomScrollView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 因为本路由没有使用Scaffold，为了让子级Widget(如Text)使用Material Design 默认的样式风格,我们使用Material作为本路由的根。
    return Material(
      child: CustomScrollView(
        // Sliver有细片、薄片之意，在Flutter中，Sliver通常指可滚动组件子元素（就像一个个薄片一样）。
        // 为了能让可滚动组件能和CustomScrollView配合使用，Flutter提供了一些可滚动组件的Sliver版，如SliverList、SliverGrid等。
        // 实际上Sliver版的可滚动组件和非Sliver版的可滚动组件最大的区别就是前者不包含滚动模型（自身不能再滚动），而后者包含滚动模型
        slivers: <Widget>[
          // AppBar导航栏
          SliverAppBar(
            pinned: true, //动画效果
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text("CustomScrollView"),
              background: Image.asset(
                "./images/lake.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(8.0),
            sliver: SliverGrid(
              // Grid
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 4.0,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.center,
                    color: Colors.cyan[100 * (index % 9)],
                    child: Text("grid item $index"),
                  );
                },
                childCount: 20,
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            // List
            sliver: SliverFixedExtentList(
              itemExtent: 50.0, //主轴方向上的长度，即列表项的高度
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.center,
                    color: Colors.blue[100 * (index % 9)],
                    child: Text("list item $index"),
                  );
                },
                childCount: 50
              ),
            ),
          ),
        ],
      ),
    );
  }
}
