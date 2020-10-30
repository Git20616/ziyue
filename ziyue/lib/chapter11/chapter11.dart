import 'package:flutter/material.dart';
import 'package:ziyue/chapter11/json_to_model.dart';
import 'package:ziyue/chapter11/test_dio.dart';
import 'package:ziyue/chapter11/test_download_with_chunks.dart';
import 'package:ziyue/chapter11/test_flie_operation.dart';
import 'package:ziyue/chapter11/test_http_client.dart';
import 'package:ziyue/chapter11/test_socket_api.dart';
import 'package:ziyue/chapter11/test_websocket.dart';

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
            RaisedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => TestWebSocket(),
                ));
              },
              child: Text("WebSocket"),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => TestSocketAPI(),
                ));
              },
              child: Text("Socket API"),
            ),
            Builder(
              builder: (context) {
                return RaisedButton(
                  onPressed: () {
                    jsonToModel();
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("结果见logcat"),
                      duration: Duration(seconds: 1),
                    ));
                  },
                  child: Text("Json转Dart Model类"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}