import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:ziyue/chapter12/camera_example.dart';

class Chapter12 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("package与插件"),
      ),
      body: Center(
        child: Wrap(
          spacing: 16.0,
          runSpacing: 16.0,
          children: <Widget>[
            RaisedButton(
              onPressed: () async {
                List<CameraDescription> cameras = <CameraDescription>[];
                cameras = await availableCameras();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CameraExample(
                        cameras: cameras,
                      ),
                    ));
              },
              child: Text("相机示例"),
            ),
          ],
        ),
      ),
    );
  }
}
