import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class TestDio extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TestDioState();
  }
}

class TestDioState extends State<TestDio> {
  // 详情参考 https://github.com/flutterchina/dio
  Dio _dio = new Dio();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("flutterchina开源项目"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: FutureBuilder(
          future: _dio.get("https://api.github.com/orgs/flutterchina/repos"),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            //请求完成
            if (snapshot.connectionState == ConnectionState.done) {
              Response response = snapshot.data;
              //发生错误
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return ListView(
                children: response.data.map<Widget>((e) {
                  return ListTile(title: Text(e["full_name"]),);
                }).toList(),
              );
            }
            //请求未完成
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
