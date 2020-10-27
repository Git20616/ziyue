import 'dart:math';

import 'package:flutter/material.dart';

class TestCustomPaint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("五子棋"),
      ),
      body: Center(
        child: CustomPaint(
          size: Size(280, 280),
          painter: MyPaint(),//背景画笔，会显示在子节点后面，如需显示再子节点前，考虑前景画笔foregroundPainter
        ),
      ),
    );
  }
}

class MyPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double eWidth = size.width / 14;
    double eHeight = size.height / 14;

    // 画棋盘背景
    Paint paint = new Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill
      ..color = Color(0x77cdb175);
    //Rect myRect = const Offset(1.0, 2.0) & const Size(3.0, 4.0);
    canvas.drawRect(Offset.zero & size, paint);

    // 画棋盘网格
    paint
      ..style = PaintingStyle.stroke
      ..color = Colors.black87
      ..strokeWidth = 1.0;
    for (int i = 0; i <= 14; ++i) {
      double dy = eHeight * i;
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy), paint);
    }
    for (int i = 0; i <= 14; ++i) {
      double dx = eWidth * i;
      canvas.drawLine(Offset(dx, 0), Offset(dx, size.height), paint);
    }

    // 画棋子
    paint
      ..style = PaintingStyle.fill
      ..color = Colors.black;
    canvas.drawCircle(Offset(eWidth * 7, eHeight * 7), min(eWidth / 2, eHeight / 2) - 2, paint);
    paint
      ..style = PaintingStyle.fill
      ..isAntiAlias = true
      ..color = Colors.white;
    canvas.drawCircle(Offset(eWidth * 8, eHeight * 7), min(eWidth / 2, eHeight / 2) - 2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // 在实际场景中正确利用此回调可以避免重绘开销，本示例我们简单的返回true
    return true;
  }
}
