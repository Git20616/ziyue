import 'package:flutter/material.dart';

class TestTheme extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TestThemeState();
  }
}

class _TestThemeState extends State<TestTheme> {
  Color _themeColor = Colors.teal; //当前路由主题颜色

  @override
  Widget build(BuildContext context) {
    //通过Theme.of(BuildContext context)来获取
    ThemeData themeData = Theme.of(context);

    return Theme(
      data: ThemeData(
        primarySwatch: _themeColor,
        iconTheme: IconThemeData(color: _themeColor),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text("主题测试"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //使用主题的iconTheme
                Icon(Icons.favorite),
                Icon(Icons.airport_shuttle),
                Text("  颜色跟随主题"),
              ],
            ),
            Theme(
              data: themeData.copyWith(
                iconTheme: themeData.iconTheme.copyWith(color: Colors.black), //只改变iconTheme的color属性
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.favorite),
                  Icon(Icons.airport_shuttle),
                  Text("  颜色固定黑色"),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _themeColor = _themeColor == Colors.teal ? Colors.blue : Colors.teal;
            });
          },
          child: Icon(Icons.palette),
        ),
      ),
    );
  }
}

// ThemeData({
// Brightness brightness, //深色还是浅色
// MaterialColor primarySwatch, //主题颜色样本，通过这个样本色可以在一些条件下生成一些其它的属性
// Color primaryColor, //主色，决定导航栏颜色
// Color accentColor, //次级色，决定大多数Widget的颜色，如进度条、开关等。
// Color cardColor, //卡片颜色
// Color dividerColor, //分割线颜色
// ButtonThemeData buttonTheme, //按钮主题
// Color cursorColor, //输入框光标颜色
// Color dialogBackgroundColor,//对话框背景颜色
// String fontFamily, //文字字体
// TextTheme textTheme,// 字体主题，包括标题、body等文字样式
// IconThemeData iconTheme, // Icon的默认样式
// TargetPlatform platform, //指定平台，应用特定平台控件风格
// ...
// })
