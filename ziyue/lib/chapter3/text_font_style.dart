import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TextFontStyle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("文本、字体样式"),
      ),
      body: Column(
        children: <Widget>[
          Text(
            "Hello World",
            textAlign: TextAlign.right,
            style: TextStyle(
              height: 1.5,
            ),
          ),
          Text(
            "It's not much, but it's home." * 4,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            "Hello World",
            textScaleFactor: 1.5,
            textDirection: TextDirection.ltr,
          ),
          Text(
            "It's not much, but it's home." * 4,
            textAlign: TextAlign.right,
          ),
          Text(
            "It's not much, but it's home." * 4,
            textDirection: TextDirection.rtl,
          ),
          Text(
            "Text组件的使用123@#!!\$",
            style: TextStyle(
              // 文字颜色
              color: Color(0xFFFC7603),
              // 背景
              background: new Paint()..color = Colors.yellow,
              // none 不显示装饰线条，underline 字体下方，overline 字体上方，lineThrough穿过文字
              decoration: TextDecoration.underline,
              // solid 直线，double 双下划线，dotted 虚线，dashed 点下划线，wavy 波浪线
              decorationStyle: TextDecorationStyle.double,
              // 装饰线条颜色
              decorationColor: Colors.red,
              // 对齐文本的水平线 alphabetic：文本基线是标准的字母基线; ideographic：文字基线是表意字基线;
              textBaseline: TextBaseline.alphabetic,
              // 文字大小
              fontSize: 15.0,
              // normal 正常，italic 斜体
              fontStyle: FontStyle.normal,
              // 字体粗细
              fontWeight: FontWeight.bold,
              // 文字间距
              letterSpacing: 5.0,
              // 该属性用于指定行高，但它并不是一个绝对值，而是一个因子，具体的行高等于fontSize*height。
              height: 1.0,
            ),
            // 段落的间距样式
            strutStyle: StrutStyle(
              fontFamily: "serif",
              fontFamilyFallback: ['monospace', 'serif'],
              fontSize: 20,
              height: 2,
              leading: 2.0,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.normal,
              forceStrutHeight: true,
              debugLabel: 'text demo',
            ),
            // 文字对齐方式
            textAlign: TextAlign.center,
            // 文字排列方向 ltr 左到右，rtl右到左
            textDirection: TextDirection.ltr,
            // 用于选择区域特定字形的语言环境
            locale: Locale('zh_CN'),
            // 软包裹 ，文字是否应该在软断行出断行
            softWrap: false,
            // 如何处理视觉溢出:clip 剪切溢出的文本以修复其容器。ellipsis 使用省略号表示文本已溢出。fade 将溢出的文本淡化为透明。
            overflow: TextOverflow.clip,
            // 文字的缩放比例
            textScaleFactor: 1.0,
            // 文本要跨越的可选最大行数,
            maxLines: 2,
            // 图像的语义描述，用于向Andoid上的TalkBack和iOS上的VoiceOver提供图像描述
            semanticsLabel: 'text demo',
            textWidthBasis: TextWidthBasis.longestLine,
          ),
          // Text.rich 方法将TextSpan 添加到Text中
          Text.rich(TextSpan(
            // style 和 text属性代表该文本片段的样式和内容。 children是一个TextSpan的数组，也就是说TextSpan可以包括其他TextSpan。
            // 而recognizer用于对该文本片段上用于手势进行识别处理。
            text: "My ",
            children: [
              TextSpan(
                text: "Home: ",
              ),
              TextSpan(
                text: "https://user.qzone.qq.com/961055747/main",
                style: TextStyle(
                  color: Colors.blue,
                ),
                recognizer: new TapGestureRecognizer()..onTap = () => print("Tap here onTap"),
              ),
            ],
          )),
          DefaultTextStyle(
            // 1. 设置默认文本样式
            style: TextStyle(
              color: Colors.red,
              fontSize: 20.0,
            ),
            textAlign: TextAlign.start,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text("Hello, jack"),
                Text("Hi, rose"),
                Text("你好，朋友",
                  style: TextStyle(
                    inherit: false,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Icon(
                IconData(
                  0xe626,
                  fontFamily: "IconFont",
                ),
                size: 30.0,
                color: Colors.green,
              ),
              Text(
                "使用自定义字体库fujinormal",
                style: TextStyle(
                  fontFamily: "Narcissus",
                ),
              ),
              Text(
                "使用自定义字体库yuweixingshu",
                style: TextStyle(
                  fontFamily: "Peony",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}
