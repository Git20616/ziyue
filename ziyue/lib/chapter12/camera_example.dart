import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

class CameraExample extends StatefulWidget {
  final List<CameraDescription> cameras;

  const CameraExample({Key key, @required this.cameras}) : super(key: key);

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
  List<CameraDescription> cameras; //摄像头列表
  // 可以通过GlobalKey拿到最新的state状态。
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    cameras = widget.cameras;
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
    if (state == AppLifecycleState.resumed) {
      if (controller != null) {
        // 摄像头选中回调
        onNewCameraSelected(controller.description);
      }
    } else if (state == AppLifecycleState.inactive) {
      controller?.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("相机示例"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Center(
                        child: _cameraPreviewWidget(),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(
                        color: (controller != null &&
                                controller.value.isRecordingVideo)
                            ? Colors.redAccent
                            : Colors.grey,
                        width: 3.0,
                      ),
                    ),
                  ),
                ),
                _captureControlRowWidget(),
                _toggleAudioWidget(),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      _cameraTogglesRowWidget(),
                      _thumbnailWidget(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 展示预览窗口
  Widget _cameraPreviewWidget() {
    if (controller == null || !controller.value.isInitialized) {
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
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Row(
        children: <Widget>[
          const Text("开启录音"),
          Switch(
            value: enableAudio,
            onChanged: (bool value) {
              enableAudio = value;
              if (controller != null) {
                onNewCameraSelected(controller.description);
              }
            },
          ),
        ],
      ),
    );
  }

  /// 显示已拍摄图片/视频缩略图
  Widget _thumbnailWidget() {
    return Expanded(
      child: Align(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            (videoPlayerController == null && imagePath == null)
                ? Container()
                : SizedBox(
                    child: (videoPlayerController == null)
                        ? Image.file(File(imagePath))
                        : Container(
                            child: Center(
                              child: AspectRatio(
                                aspectRatio:
                                    (videoPlayerController.value.size != null)
                                        ? videoPlayerController
                                            .value.aspectRatio
                                        : 1.0,
                                child: VideoPlayer(videoPlayerController),
                              ),
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.pink)),
                          ),
                    width: 64.0,
                    height: 64.0,
                  ),
          ],
        ),
      ),
    );
  }

  /// 相机工具栏
  Widget _captureControlRowWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.camera_alt),
          color: Colors.blue,
          onPressed: (controller != null &&
                  controller.value.isInitialized &&
                  !controller.value.isRecordingVideo)
              ? onTakePictureButtonPressed
              : null,
        ),
        IconButton(
          icon: const Icon(Icons.videocam),
          color: Colors.blue,
          onPressed: (controller != null &&
                  controller.value.isInitialized &&
                  !controller.value.isRecordingVideo)
              ? onVideoRecordButtonPressed
              : null,
        ),
        IconButton(
          icon: const Icon(Icons.stop),
          color: Colors.red,
          onPressed: (controller != null &&
                  controller.value.isInitialized &&
                  !controller.value.isRecordingVideo)
              ? onStopButtonPressed
              : null,
        ),
      ],
    );
  }

  /// 展示所有摄像头
  Widget _cameraTogglesRowWidget() {
    final List<Widget> toggles = <Widget>[];
    if (cameras.isEmpty) {
      return Text("没有检测到摄像头");
    } else {
      for (CameraDescription cameraDescription in cameras) {
        toggles.add(SizedBox(
          width: 90,
          child: RadioListTile<CameraDescription>(
            title: Icon(getCameraLensIcon(cameraDescription.lensDirection)),
            groupValue: controller?.description,
            value: cameraDescription,
            onChanged: controller != null && controller.value.isRecordingVideo
                ? null
                : onNewCameraSelected,
          ),
        ));
      }
    }
    return Row(children: toggles);
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  void showInSnackBar(String message) {
    print(message);
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  void _showCameraException(CameraException e) {
    logError(e.code, e.description);
    showInSnackBar("Error: ${e.code}, ${e.description}");
  }

  //摄像头选中回调
  void onNewCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }
    controller = CameraController(cameraDescription, ResolutionPreset.high,
        enableAudio: enableAudio);

    controller.addListener(() {
      if (mounted) {
        //手动刷新页面
        setState(() {});
      }
      if (controller.value.hasError) {
        showInSnackBar("Camera error: ${controller.value.errorDescription}");
      }
    });

    try {
      await controller.initialize();
    } on CameraException catch (e) {
      _showCameraException(e);
    }

    if (mounted) {
      //手动刷新页面
      setState(() {});
    }
  }

  // 拍照按钮点击回调
  void onTakePictureButtonPressed() {
    takePicture().then((String filePath) {
      if (mounted) {
        setState(() {
          imagePath = filePath;
          videoPlayerController?.dispose();
          videoPlayerController = null;
        });
        if (filePath != null) {
          showInSnackBar("图片保存在$filePath");
        }
      }
    });
  }

  // 开始录制视频
  void onVideoRecordButtonPressed() {
    startVideoRecording().then((String filePath) {
      if (mounted) {
        setState(() {
          if (filePath != null) {
            showInSnackBar("视频保存在$filePath");
          }
        });
      }
    });
  }

  // 终止录制视频
  void onStopButtonPressed() {
    stopVideoRecording().then((_) {
      if (mounted) {
        setState(() {
          if (videoPath != null) {
            showInSnackBar("视频保存与$videoPath");
          }
        });
      }
    });
  }

  Future<String> startVideoRecording() async {
    if (!controller.value.isInitialized) {
      showInSnackBar("请选择一个摄像头");
      return null;
    }

    // 确定视频保存的路径
    final Directory externalDir = await getApplicationDocumentsDirectory();
    final String dirPath = "${externalDir.path}/Movies/flutter_test";
    await Directory(dirPath).create(recursive: true);
    final String filePath = "$dirPath/${timestamp()}.mp4";

    if (controller.value.isRecordingVideo) {
      return null; //如果正在录制，则直接返回
    }

    try {
      videoPath = filePath;
      await controller.startVideoRecording(filePath);
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
    return filePath;
  }

  Future<void> stopVideoRecording() async {
    if (!controller.value.isRecordingVideo) {
      return null;
    }

    try {
      await controller.stopVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }

    // 播放录制的视频
    await _startVideoPlayer();
  }

  Future<void> _startVideoPlayer() async {
    final VideoPlayerController vController =
        VideoPlayerController.file(File(videoPath));
    videoPlayerListener = () {
      if (videoPlayerController != null &&
          videoPlayerController.value.size != null) {
        // Refreshing the state to update video player with the correct ratio.
        if (mounted) {
          setState(() {});
        }
        videoPlayerController.removeListener(videoPlayerListener);
      }
    };
    vController.addListener(videoPlayerListener);
    await vController.setLooping(true);
    await vController.initialize();
    await videoPlayerController?.dispose();
    if (mounted) {
      setState(() {
        imagePath = null;
        videoPlayerController = vController;
      });
    }
    await vController.play();
  }

  Future<String> takePicture() async {
    if (!controller.value.isInitialized) {
      showInSnackBar("错误：请先选择一个相机");
      return null;
    }

    // 确定照片保存的路径
    final Directory externalDir = await getApplicationDocumentsDirectory();
    final String dirPath = "${externalDir.path}/Pictures/flutter_test";
    await Directory(dirPath).create(recursive: true);
    final String filePath = "$dirPath/${timestamp()}.jpg";

    if (controller.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      await controller.takePicture(filePath);
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
    return filePath;
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
