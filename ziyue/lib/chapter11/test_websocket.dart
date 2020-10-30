import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class TestWebSocket extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TestWebSocketState();
  }
}

class TestWebSocketState extends State<TestWebSocket> {
  TextEditingController _controller = new TextEditingController();
  IOWebSocketChannel channel;
  List<String> _msg = [];

  @override
  void initState() {
    super.initState();
    // 创建WebSocket连接
    channel = new IOWebSocketChannel.connect("ws://echo.websocket.org");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WebSocket"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: StreamBuilder(
                  stream: channel.stream,
                  builder: (context, snapshot) {
                    // 注意！这里不用也不能setSate()
                    print(snapshot.toString());
                    if(snapshot.hasError) {
                      return Text("网络异常...");
                    } else if(snapshot.hasData) {
                      _msg.add(snapshot.data);
                    }
                    return ListView(
                      children: _msg.map((e) {
                        return ListTile(title: Text("received: $e"),);
                      }).toList(),
                    );
                  },
                ),
              ),
            ),
            Form(
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(labelText: "Send a message"),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _sendMsg();
        },
        tooltip: "Send Message",
        child: Icon(Icons.send),
      ),
    );
  }

  void _sendMsg() {
    print("Send Message");
    if (_controller.text.isNotEmpty) {
      //WebSocketChannel提供了一个StreamSink，它将消息发给服务器。
      // StreamSink类提供了给数据源同步或异步添加事件的一般方法。
      channel.sink.add(_controller.text);
      _controller.text = "";
    }
  }

  @override
  void dispose() {
    //使用WebSocket后，要关闭连接
    channel.sink.close();
    super.dispose();
  }
}
