import 'package:flutter/material.dart';

class MyImage extends StatefulWidget {
  final ImageProvider imageProvider; //1.提供图片数据源, 2.缓存图片

  const MyImage({Key key, @required this.imageProvider})
      : assert(imageProvider != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyImageState();
  }
}

class _MyImageState extends State<MyImage> {
  ImageStream _imageStream;
  ImageInfo _imageInfo;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 依赖改变时，图片的配置信息可能会发生改变
    _getImage();
  }

  @override
  void didUpdateWidget(MyImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(widget.imageProvider != oldWidget.imageProvider) {
      _getImage();
    }
  }

  @override
  void dispose() {
    _imageStream.removeListener(ImageStreamListener(_updateImage, onError: _onImageError));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RawImage(
      image: _imageInfo?.image,
      scale: _imageInfo?.scale ?? 1.0,
    );
  }

  void _getImage() {
    final ImageStream oldImageStream = _imageStream;
    // 调用imageProvider.resolve方法，获得ImageStream。
    // Flutter SDK提供了一个便捷函数createLocalImageConfiguration来创建ImageConfiguration 对象
    _imageStream = widget.imageProvider.resolve(createLocalImageConfiguration(context));
    // 判断新旧ImageStream是否相同，如果不同，则需要调整流的监听器
    if(_imageStream.key != oldImageStream?.key) {
      final ImageStreamListener listener = ImageStreamListener(_updateImage, onError: _onImageError);//设置监听器
      oldImageStream?.removeListener(listener);
      _imageStream.addListener(listener);
    }
  }

  void _updateImage(ImageInfo imageInfo, bool synchronousCall) {
    setState(() {
      // Trigger a build whenever the image changes.
      _imageInfo = imageInfo;
    });
  }

  void _onImageError(dynamic exception, StackTrace stackTrace) {
    print("onImageError: $exception");
  }
}
