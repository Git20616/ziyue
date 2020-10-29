import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ziyue/chapter11/download_with_chunks.dart';

class TestDownloadWithChunks extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TestDownloadWithChunksState();
  }
}

class TestDownloadWithChunksState extends State<TestDownloadWithChunks> {
  bool _isLoading = false;
  final String _url = "https://video-qn.51miz.com/Video/2017/08/08/22/20170808224612_V106894_bf682eb4.mp4";
  String _filePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DownloadWithChunks"),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                RaisedButton(
                  onPressed: () async {
                    if (!_isLoading) {
                      String dir = (await getApplicationDocumentsDirectory()).path;
                      _filePath = dir + "/example/flag.mp4";
                      setState(() {
                        _isLoading = true;
                      });
                    }
                  },
                  child: Text("点击开始下载"),
                ),
                !_isLoading ? Container() : FutureBuilder(
                  future: downloadWithChunks(_url, _filePath, progressCallback: (int received, int total) {
                    if(total > 0) {
                      // print("${(received / total * 100).floor()}%");
                    }
                  }),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if(snapshot.connectionState == ConnectionState.done) {
                      if(snapshot.hasError) {
                        return Text("下载出错：${snapshot.error.toString()}");
                      }
                      return Text("下载完成", maxLines: 200,);
                    }
                    return CircularProgressIndicator();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
