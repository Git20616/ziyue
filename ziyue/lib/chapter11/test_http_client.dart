import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class TestHttpClient extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TestHttpClientState();
  }
}

class TestHttpClientState extends State<TestHttpClient> {
  bool _isLoading = false;
  String _text = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HttpClient"),
      ),
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                RaisedButton(
                  onPressed: _isLoading
                      ? null
                      : () async {
                    setState(() {
                      _isLoading = true;
                      _text = "正在请求...";
                    });
                    try {
                      //1.创建一个HttpClient:
                      HttpClient httpClient = new HttpClient();
                      //2.打开Http连接，设置请求头：
                      Uri uri = Uri(scheme: "https", host: "www.baidu.com");//Uri.parse("https://www.baidu.com");
                      HttpClientRequest request =
                      await httpClient.getUrl(uri);
                      //使用iPhone的UA
                      request.headers.add("user-agent",
                          "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/10.0 Mobile/14E304 Safari/602.1");
                      //3.等待连接服务器：
                      HttpClientResponse response = await request.close();
                      //4.读取响应内容:
                      _text = await response.transform(utf8.decoder).join();
                      print(response.headers);//输出响应头
                      //5.请求结束，关闭HttpClient：
                      httpClient.close();
                    } catch (e) {
                      _text = "请求失败：$e";
                    } finally {
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  },
                  child: Text("获取百度首页"),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 50,
                  child: Text("${_text?.replaceAll(new RegExp(r"\s"), "")}", maxLines: 200,),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

