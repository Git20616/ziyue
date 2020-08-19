import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StateManage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("状态管理"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FlatButton(
              child: Text("管理自身状态"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          TapBoxA(),
                        ],
                      ),
                      color: Colors.white,
                    );
                  },
                ));
              },
            ),
            FlatButton(
              child: Text("父Widget管理子Widget状态"),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

}

class TapBoxA extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TapBoxAState();
  }

}

class TapBoxAState extends State<TapBoxA> {
  bool _active = false;

  void _handleTap () {
    setState(() {
      _active = !_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        child: Center(
          child: Text(
            _active ? "active" : "inactive",
            style: TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(
          color: _active ? Colors.lightGreen[700] : Colors.grey[600],
        ),
      ),
    );
  }

}

class ParentWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ParentWidgetState();
  }

}

class ParentWidgetState extends State<ParentWidget> {
  bool _active = false;

  void _handleTapBoxChange(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            child: TapBoxB(),
          ),
        ],
      ),
      color: Colors.white,
    );;
  }

}

class TapBoxB extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}