import 'package:flutter/material.dart';

class StyledDiscountBanner extends StatelessWidget {
  final int discountPercentage;
  const StyledDiscountBanner({super.key, required this.discountPercentage});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(70, 55),
      painter: TrianglePainter(discountPercentage: discountPercentage),
    );
  }
}

class TrianglePainter extends CustomPainter {
  final int discountPercentage;
  const TrianglePainter({required this.discountPercentage});

  @override
  void paint (Canvas canvas, Size size) {
    final paint = Paint()
    ..color = Colors.blue
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
        text: '$discountPercentage%',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold
        )
      )
    )..layout();

    final xCenter = (size.width - textPainter.width) / 5;
    final yCenter = (size.height - textPainter.height) / 5;
    textPainter.paint(canvas, Offset(xCenter, yCenter));
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}

