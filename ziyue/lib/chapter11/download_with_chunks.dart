import 'dart:io';

import 'package:dio/dio.dart';

/// Downloading by spiting as file in chunks
Future downloadWithChunks(
  url,
  savePath, {
  ProgressCallback progressCallback,
}) async {
  const int firstChunkSize = 102; //第一块大小，单位B
  const int maxChunk = 3; //不计入第一个文件块的最大块数

  int totalSize = 0; //文件大小
  Dio dio = Dio();
  List<int> progress = []; //记录每一块已接收数据的长度

  // no 块的序号
  createCallBack(int no) {
    return (int received, int chunkSize) {
      progress[no] = received;
      if (progressCallback != null && totalSize != 0) {
        progressCallback(progress.reduce((value, element) {
          //通过使用所提供的函数迭代地组合集合的元素，将集合减少为单个值。
          return value + element;
        }), totalSize);
      }
    };
  }

  // 下载文件块
  Future<Response> downloadChunk(url, start, end, no) async {
    if (progress.length <= no) {
      progress.add(0);
    }
    --end; //避免重复下载end所在字节
    return dio.download(
      url,
      savePath + "temp$no",
      onReceiveProgress: createCallBack(no),
      options: Options(
        headers: {"range": "bytes=$start-$end"},
      ),
    );
  }

  // 合并文件块
  Future mergeTempFiles(int chunk) async {
    File f = File(savePath + "temp0");
    IOSink ioSink = f.openWrite(mode: FileMode.writeOnlyAppend); //以追加只写的方式打开
    for (int i = 1; i < chunk; ++i) {
      File _f = File(savePath + "temp$i");
      await ioSink.addStream(_f.openRead()); //追加临时文件
      await _f.delete(); //删除临时文件
    }
    await ioSink.close();
    await f.rename(savePath); //重命名
  }

  // 执行分块下载
  Response response = await downloadChunk(url, 0, firstChunkSize, 0); //下载第一个文件块
  //判断是否支持分块下载
  if (response.statusCode == 206) {
    //Content-Range: bytes 0-10/233295878
    totalSize = int.parse(
        response.headers.value(HttpHeaders.contentRangeHeader).split("/").last);
    int reserved = totalSize - int.parse(response.headers.value(HttpHeaders.contentLengthHeader));
    int chunk = (reserved / firstChunkSize).ceil() + 1;//按firstChunkSize计算文件块数，包括为了校验信息头下载的第一个文件块
    if(chunk > 1) {
      int chunkSize = firstChunkSize;
      if(chunk > maxChunk + 1) {
        chunk = maxChunk + 1;
        chunkSize = (reserved / maxChunk).ceil();
      }
      List<Future> futures = [];
      for(int i = 0; i < chunk - 1; ++i) {
        int start = firstChunkSize + i * chunkSize;
        futures.add(downloadChunk(url, start, start + chunkSize, i + 1));
      }
      await Future.wait(futures);
    }
    await mergeTempFiles(chunk);
    print("size:$totalSize, path:$savePath");
  }
}
