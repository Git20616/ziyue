import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class TestFileOperation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TestFileOperationState();
  }
}

// 本示例只是为了演示文件读写，而在实际开发中，如果要存储一些简单的数据，使用shared_preferences插件会比较简单。
class TestFileOperationState extends State<TestFileOperation> {
  int _counter;

  @override
  void initState() {
    super.initState();
    // 从文件中读取点击次数
    _readCount().then((int value) {
      setState(() {
        _counter = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("文件操作"),),
      body: Center(
        child: Text("点击了$_counter次"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: incrementCount,
        tooltip: "Increment",
        child: Icon(Icons.add),
      ),
    );
  }

  Future<File> _getLocalFile() async {
    // 获取应用目录
    String dir = (await getApplicationDocumentsDirectory()).path;
    return new File("$dir/counter.txt");
  }

  Future<int> _readCount() async {
    try {
      File file = await _getLocalFile();
      // 读取点击次数
      String contents = await file.readAsString();
      return int.parse(contents);
    } on FileSystemException {
      return 0;
    }
  }

  Future<void> incrementCount() async {
    setState(() {
      ++_counter;
    });
    // 将点击次数以字符串类型写到文件中
    await(await _getLocalFile()).writeAsString("$_counter");
  }
}