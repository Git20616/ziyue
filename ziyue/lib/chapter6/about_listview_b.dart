import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class AboutListViewB extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AboutListViewBState();
  }
}

class AboutListViewBState extends State<AboutListViewB> {
  static const loadingTag = "##loading##"; //表尾标记
  List _words = <String>[loadingTag];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("无限加载列表"),
      ),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          // 如果到了表尾
          if (_words[index] == loadingTag) {
            // 不足100条，继续获取数据

          }
          return ListTile(
            title: Text(_words[index]),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            height: 0.5,
          );
        },
        itemCount: _words.length,
      ),
    );
  }

  void _retrieveData() {
    Future.delayed(Duration(seconds: 2)).then((dynamic) {
      setState(() {
        // 重新构建列表
        _words.insertAll(
            _words.length - 1,
            generateWordPairs()
                .take(20)
                .map((item) => item.asPascalCase)
                .toList());
      });
    });
  }
}
