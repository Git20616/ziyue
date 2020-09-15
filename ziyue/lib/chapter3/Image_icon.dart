import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageAndIcon extends StatelessWidget {
  final AssetImage _img = AssetImage("images/lysnickname.png");
  final AssetImage _img2 = AssetImage("images/avatar.jpg");

  @override
  Widget build(BuildContext context) {
    String icons = "";
    icons += "\uE000";
    icons += "\uE90D";
    icons += "\uEB3B";
    // TODO: implement build
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                icons,
                style: TextStyle(
                  fontFamily: "MaterialIcons",
                  fontSize: 24.0,
                  color: Colors.green,
                ),
              ),
              Text(
                "\uE626",
                style: TextStyle(
                  fontFamily: "IconFont",
                  fontSize: 24.0,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          Column(
            children: <Image>[
              // 从网络上加载图片
              Image(
                image: NetworkImage(
                  "https://pic3.zhimg.com/v2-a1719111c4e836dba20d53759cdb877e_s.jpg",
                ),
                width: 100.0,
              ),
              Image(
                image: _img2,
                height: 50.0,
                width: 100.0,
                fit: BoxFit.fill,
              ),
              Image(
                image: _img,
                height: 50.0,
                width: 100.0,
                fit: BoxFit.contain,
              ),
              Image(
                image: _img2,
                height: 50.0,
                width: 100.0,
                fit: BoxFit.fitWidth,
              ),
              Image(
                image: _img2,
                height: 50.0,
                width: 100.0,
                fit: BoxFit.fitHeight,
              ),
              Image(
                image: _img2,
                height: 50.0,
                width: 100.0,
                fit: BoxFit.cover,
              ),
              Image(
                image: _img2,
                height: 50.0,
                width: 100.0,
                fit: BoxFit.none,
              ),
              Image(
                image: _img2,
                height: 50.0,
                width: 100.0,
                fit: BoxFit.scaleDown,
              ),
              Image(
                image: _img2,
                width: 100.0,
                // color和 colorBlendMode：在图片绘制时可以对每一个像素进行颜色混合处理，color指定混合色，而colorBlendMode指定混合模式
                color: Colors.blue,
                colorBlendMode: BlendMode.difference,
              ),
              Image(
                image: _img2,
                width: 100.0,
                height: 200.0,
                repeat: ImageRepeat.repeatY,
              ),
            ].map((e) {
              return Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: 100.0,
                      child: e,
                    ),
                  ),
                  Text(
                    e.fit.toString(),
                    style: TextStyle(
                      fontFamily: "Narcissus",
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

}