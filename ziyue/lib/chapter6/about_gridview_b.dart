import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class AboutGridViewB extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AboutGridViewBState();
  }
}

class AboutGridViewBState extends State<AboutGridViewB> {
  static const String loadingTag = "##loading##"; // 表尾标记
  List _words = <String>[loadingTag];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("GridView.builder"),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 2.0,
        ),
        itemCount: _words.length, //列表项的数量，如果为null则为无限列表
        itemBuilder: (context, index) {
          if (_words[index] == loadingTag) {
            if (index < 61) {
              _retrieveData();
              return Container(
                padding: EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: SizedBox(
                  width: 24.0,
                  height: 24.0,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                  ),
                ),
              );
            } else {
              return Container(
                padding: EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: Text(
                  "已加载所有内容",
                  style: TextStyle(color: Colors.grey),
                ),
              );
            }
          }
          return Container(
            padding: EdgeInsets.only(left: 8.0),
            alignment: Alignment.centerLeft,
            child: Chip(
              avatar: CircleAvatar(
                child: Text(_words[index][0]),
              ),
              label: Text(_words[index]),
            ),
          );
        },
      ),
    );
  }

  void _retrieveData() {
    Future.delayed(Duration(milliseconds: 500)).then((dynamic) {
      setState(() {
        _words.insertAll(
            //包括index所在的位置
            _words.length - 1,
            generateWordPairs().take(30).map((item) {
              return item.asPascalCase;
            }).toList());
      });
    });
  }
}
