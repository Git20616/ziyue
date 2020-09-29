import 'package:flutter/material.dart';

class AboutScrollNotification extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AboutScrollNotificationState();
  }
}

class AboutScrollNotificationState extends State<AboutScrollNotification> {
  String _progress = "0%"; //保持进度百分比

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("ScrollNotification"),
      ),
      body: Scrollbar(
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification nf) {
            // metrics属性
            // pixels：当前滚动位置。
            // maxScrollExtent：最大可滚动长度。
            // extentBefore：滑出ViewPort顶部的长度；此示例中相当于顶部滑出屏幕上方的列表长度。
            // extentInside：ViewPort内部长度；此示例中屏幕显示的列表部分的长度。
            // extentAfter：列表中未滑入ViewPort部分的长度；此示例中列表底部未显示到屏幕范围部分的长度。
            // atEdge：是否滑到了可滚动组件的边界（此示例中相当于列表顶或底部）。
            double progress = nf.metrics.pixels / nf.metrics.maxScrollExtent;
            setState(() {
              _progress = "${(progress * 100).toInt()}%";
            });
            print("BottomEdge: ${nf.metrics.extentAfter}");
            return false; //返回true，进度条将失效
          },
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              ListView.builder(
                itemCount: 100,
                itemExtent: 50.0,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text("list item $index"),
                    onTap: () {
                      print("item $index on tap");
                    },
                  );
                },
              ),
              CircleAvatar(
                radius: 30.0,
                backgroundColor: Colors.blue,
                child: Text(_progress),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
