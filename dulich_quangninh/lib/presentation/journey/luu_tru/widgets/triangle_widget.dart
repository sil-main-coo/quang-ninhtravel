import 'dart:math';

import 'package:dulichquangninh/presentation/theme/theme_color.dart';
import 'package:flutter/material.dart';

class TriangleWidget extends StatelessWidget {
  const TriangleWidget(
      {Key key, this.color, this.icon, this.sizeContainer, this.sizeIcon})
      : super(key: key);
  final Color color;
  final IconData icon;
  final double sizeContainer;
  final double sizeIcon;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        painter: _ShapesPainter(color),
        child: Container(
            height: sizeContainer,
            width: sizeContainer,
            child: Center(
                child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, bottom: 16),
                    child: Transform.rotate(
                        angle: pi / 4,
                        child: Icon(
                          icon,
                          size: sizeIcon,
                          color: AppColor.white,
                        ))))));
  }
}

class _ShapesPainter extends CustomPainter {
  final Color color;

  _ShapesPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = color;
    var path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.height, size.width);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
