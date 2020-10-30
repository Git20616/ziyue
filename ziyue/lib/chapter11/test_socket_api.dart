import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class TestSocketAPI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TestSocketAPIState();
  }
}

class TestSocketAPIState extends State<TestSocketAPI> {
  String _text = "";

  @override
  void initState() {
    super.initState();
    _request();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Socket API"),),
      body: Text(_text),
    );
  }

  _request() async {
    // 建立连接
    Socket socket = await Socket.connect("baidu.com", 80);
    // 根据http协议，发送请求头
    socket.writeln("GET / HTTP/1.1");
    socket.writeln("Host:baidu.com");
    socket.writeln("Connection:close");
    socket.writeln();
    // 发送请求
    await socket.flush();
    // 读取返回内容
    socket.listen((socket) {
      _text = socket.toString();
      setState(() {

      });
    });
    await socket.close();
  }
}