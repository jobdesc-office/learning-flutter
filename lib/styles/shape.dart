import 'package:boilerplate/styles/color_palattes.dart';
import 'package:flutter/material.dart';

class PipelineStageShape extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 0, 0, 0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    Path path0 = Path();
    path0.moveTo(size.width * 0.0012500, size.height * 0.0040000);
    path0.lineTo(size.width * 0.0125000, size.height * 0.4980000);
    path0.lineTo(size.width * 0.0012500, size.height * 0.9960000);
    path0.lineTo(size.width * 0.9900000, size.height * 0.9940000);
    path0.lineTo(size.width * 0.9987500, size.height * 0.4980000);
    path0.lineTo(size.width * 0.9862500, 0);

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
      ..color = ColorPallates.pipeline
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path0 = Path();
    path0.moveTo(size.width * 0.0012500, size.height * 0.0040000);
    path0.lineTo(size.width * 0.0125000, size.height * 0.4980000);
    path0.lineTo(size.width * 0.0012500, size.height * 0.9960000);
    path0.lineTo(size.width * 0.9900000, size.height * 0.9940000);
    path0.lineTo(size.width * 0.9987500, size.height * 0.4980000);
    path0.lineTo(size.width * 0.9862500, 0);

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
