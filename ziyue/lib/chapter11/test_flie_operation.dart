import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class TestFileOperation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TestFileOperationState();
  }
}

class TestFileOperationState extends State<TestFileOperation> {
  int _counter;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return null;
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
}