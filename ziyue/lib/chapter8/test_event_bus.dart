import 'package:flutter/material.dart';
import 'package:ziyue/chapter8/event_bus.dart';

class TestEventBus extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TestEventBusState();
  }

}

class TestEventBusState extends State<TestEventBus> {
  String _eventData = "";

  @override
  void initState() {
    // 监听事件，可以在任一页面监听，写在这里是出于方便
    bus.on("test", (arg) {
      setState(() {
        _eventData = arg;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("全局事件总线"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                bus.emit("test", "eventData");
              },
              child: Text("触发事件"),
            ),
            Text("data: $_eventData"),
          ],
        ),
      ),
    );
  }

}