import 'package:flutter/material.dart';

class PipelineStageShape extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15;

    Path path0 = Path();
    path0.moveTo(0, 0);
    path0.lineTo(size.width * 0.7503125, 0);
    path0.lineTo(size.width * 0.9975000, size.height * 0.5000000);
    path0.lineTo(size.width * 0.7512875, size.height);
    path0.lineTo(0, size.height);
    path0.lineTo(size.width * 0.2529500, size.height * 0.5026600);
    path0.lineTo(0, 0);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PipelineStageShapeFill extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path0 = Path();
    path0.moveTo(0, 0);
    path0.lineTo(size.width * 0.7503125, 0);
    path0.lineTo(size.width * 0.9975000, size.height * 0.5000000);
    path0.lineTo(size.width * 0.7512875, size.height);
    path0.lineTo(0, size.height);
    path0.lineTo(size.width * 0.2529500, size.height * 0.5026600);
    path0.lineTo(0, 0);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
