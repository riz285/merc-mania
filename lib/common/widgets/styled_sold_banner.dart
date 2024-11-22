import 'dart:math';

import 'package:flutter/material.dart';

class StyledSoldOutBanner extends StatelessWidget {
  final bool isSold;
  const StyledSoldOutBanner({super.key, required this.isSold});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(70, 55),
      painter: TrianglePainter(isSold: isSold),
    );
  }
}

class TrianglePainter extends CustomPainter {
  final bool isSold;
  const TrianglePainter({required this.isSold});

  @override
  void paint (Canvas canvas, Size size) {
    final paint = Paint()
    ..color = Colors.redAccent
    ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 10)
      ..arcToPoint(
        Offset(10, 0),
        radius: Radius.circular(10),
        clockwise: true,
      )
      ..lineTo(size.width, 0)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(path, paint);

    canvas.drawPath(path, paint);

    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: 'SOLD',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold
        )
      )
    )..layout();

    canvas.rotate(1.8*pi);

    final xCenter = (size.width - 2*textPainter.width);
    final yCenter = (size.height - 1.75*textPainter.height);
    textPainter.paint(canvas, Offset(xCenter, yCenter));
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}

