import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CameraExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CameraExampleState();
  }
}

// WidgetsBindingObserver监测页面生命周期
class _CameraExampleState extends State<CameraExample>
    with WidgetsBindingObserver {
  CameraController controller;
  String imagePath;
  String videoPath;
  VideoPlayerController videoPlayerController;
  VoidCallback videoPlayerListener;
  bool enableAudio = true;
  // 可以通过GlobalKey拿到最新的state状态。
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // 监听App状态改变，是否在前台
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// 生命周期变化时回调
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    //resumed:应用可见并可响应用户操作
    //inactive:用户可见，但不可响应用户操作
    //paused:已经暂停了，用户不可见、不可操作
    //suspending：应用被挂起，此状态IOS永远不会回调
    if(state == AppLifecycleState.resumed) {
      if(controller != null) {
        // TODO 摄像头选中回调
      }
    } else if(state == AppLifecycleState.inactive) {
      controller?.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text("相机示例"),),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }

  /// 展示预览窗口
  Widget _cameraPreviewWidget() {
    if(controller == null || !controller.value.isInitialized) {
      return const Text("选择一个摄像头");
    } else {
      return AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: CameraPreview(controller),
      );
    }
  }

  /// 开启或关闭录音
  Widget _toggleAudioWidget() {
    return null;
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  //摄像头选中回调
  void onNewCameraSelected(CameraDescription cameraDescription) async {

  }

}

void logError(String code, String message) =>
    print("Error： $code\nError Message: $message");

/// 获取不同的摄像头图标
IconData getCameraLensIcon(CameraLensDirection direction) {
  switch (direction) {
    case CameraLensDirection.front:
      return Icons.camera_front;
    case CameraLensDirection.back:
      return Icons.camera_rear;
    case CameraLensDirection.external:
      return Icons.camera;
  }
  throw ArgumentError("Unknown lens direction");
}
