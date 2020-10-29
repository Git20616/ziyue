import 'package:flutter/material.dart';
import 'package:ziyue/chapter11/test_dio.dart';
import 'package:ziyue/chapter11/test_download_with_chunks.dart';
import 'package:ziyue/chapter11/test_flie_operation.dart';
import 'package:ziyue/chapter11/test_http_client.dart';

class Chapter11 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("文件操作与网络请求"),),
      body: Center(
        child: Wrap(
          spacing: 16.0,
          runSpacing: 16.0,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => TestFileOperation(),
                ));
              },
              child: Text("文件操作"),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => TestHttpClient(),
                ));
              },
              child: Text("Http请求-HttpClient"),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => TestDio(),
                ));
              },
              child: Text("Http请求-Dio"),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => TestDownloadWithChunks(),
                ));
              },
              child: Text("实例-文件分块下载"),
            ),
          ],
        ),
      ),
    );
  }
}