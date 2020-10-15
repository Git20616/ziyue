import 'package:flutter/material.dart';

class TestNotification extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TestNotificationState();
  }
}

class TestNotificationState extends State<TestNotification> {
  String _msg = ""; //保存通知的消息

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notification"),),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 200.0,
              // NotificationListener 可以指定一个模板参数，该模板参数类型必须是继承自Notification；
              // 当显式指定模板参数时，NotificationListener 便只会接收该参数类型的通知。
              //例如 NotificationListener<ScrollEndNotification>
              child: NotificationListener(
                onNotification: (notification) {
                  switch(notification.runtimeType) {
                    case ScrollStartNotification: print("开始滚动"); break;
                    case ScrollUpdateNotification: print("正在滚动"); break;
                    case ScrollEndNotification: print("滚动停止"); break;
                    case OverscrollNotification: print("滚动到边界"); break;
                  }
                  //当返回值为true时，阻止冒泡，其父级Widget将再也收不到该通知；当返回值为false 时继续向上冒泡通知。
                  return true;
                },
                child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return ListTile(title: Text("$index"),);
                  },
                ),
              ),
            ),
            NotificationListener<MyNotification>(
              onNotification: (notification) {
                setState(() {
                  _msg += notification.msg;
                });
                return true;
              },
              // child: RaisedButton(
              //   onPressed: () => MyNotification("Hello World！ ").dispatch(context),
              //   child: Text("Send Notification"),
              // ),
              // 上面的代码不会生效，因为这个context是根Context，而NotificationListener是监听的子树，
              // 所以我们通过Builder来构建RaisedButton，来获得按钮位置的context。
              child: Builder(
                builder: (context) {
                  return RaisedButton(
                    onPressed: () => MyNotification("Hello World！ ").dispatch(context),
                    child: Text("Send Notification"),
                  );
                },
              ),
            ),
            Text(_msg),
          ],
        ),
      ),
    );
  }
}

// 自定义通知类
class MyNotification extends Notification {

  final String msg;//可以是任意的数据结构

  MyNotification(this.msg);
}