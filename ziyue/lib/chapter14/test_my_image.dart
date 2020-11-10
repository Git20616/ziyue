import 'package:flutter/material.dart';
import 'package:ziyue/chapter14/my_image.dart';

class TestMyImage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TestMyImageState();
  }
}

class TestMyImageState extends State<TestMyImage> {
  final List<String> imgs = [
    "https://pic3.zhimg.com/v2-a1719111c4e836dba20d53759cdb877e_s.jpg",
    "https://portrait.gitee.com/uploads/avatars/user/2759/8277366_cattleman_1604630422.png!avatar100",
    "https://portrait.gitee.com/uploads/avatars/user/2759/8277366_cattleman_1604630422.png",
    "https://tse2-mm.cn.bing.net/th/id/OIP._2qPIRGsEsPcbAFVP34qQwHaFj?pid=Api&rs=1",
  ];
  String imgUrl;
  int index;

  @override
  void initState() {
    super.initState();
    imgUrl = imgs[0];
    index = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Image"),
      ),
      body: GestureDetector(
        onTap: () {
          imgUrl = imgs[++index % 4];
          setState(() {});
        },
        child: MyImage(imageProvider: NetworkImage(imgUrl, scale: 0.8)),//原图与显示图的比例
      ),
    );
  }
}
