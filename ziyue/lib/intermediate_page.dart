import 'package:flutter/material.dart';
import 'package:ziyue/chapter8/chapter8.dart';

class IntermediatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Wrap(
        spacing: 16.0,
        runSpacing: 16.0,
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Chapter8(),
                  ));
            },
            child: Text("事件处理与通知"),
          ),
        ],
      ),
    );
  }
}
