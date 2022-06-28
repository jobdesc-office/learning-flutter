import 'package:boilerplate/styles/color_palattes.dart';
import 'package:flutter/material.dart';

class StagePaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    Path path = Path();

    path
      ..lineTo(size.width * .85, 0) // .85 amount of right gap
      ..lineTo(size.width, size.height / 2)
      ..lineTo(size.width * .85, size.height)
      ..lineTo(0, size.height)
      ..lineTo(0, 0)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class StageCountinuePaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = ColorPallates.pipeline
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    Path path = Path();

    path
      ..lineTo(size.width * .85, 0) // .85 amount of right gap
      ..lineTo(size.width, size.height / 2)
      ..lineTo(size.width * .85, size.height)
      ..lineTo(0, size.height)
      ..lineTo(40, 20)
      ..lineTo(0, 0)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
