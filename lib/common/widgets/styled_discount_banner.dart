import 'package:flutter/material.dart';

class StyledDiscountBanner extends StatelessWidget {
  final int discountPercentage;
  const StyledDiscountBanner({super.key, required this.discountPercentage});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(30, 30),
      // painter: TrianglePainter(),
    );
  }
}

// class TrianglePainter extends CustomPainter {
//   @override
//   void paint (Canvas canvas, Size size) {
//     final paint = Paint()..color = Colors.red
//     ..style = PaintingStyle.fill;
//     final path = Path;
//     final x = alignment.x * size.width;
//     final y = alignment.y * size.height;

  
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }

