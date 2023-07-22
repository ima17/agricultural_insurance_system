import 'dart:math';

import 'package:flutter/material.dart';

class VoiceWavePainter extends CustomPainter {
  final Animation<double> animation;
  final List<double> frequencies;
  final double amplitude;

  VoiceWavePainter(
      {required this.animation,
      required this.frequencies,
      this.amplitude = 50.0})
      : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final centerY = size.height / 2;
    final step = 4;

    for (double frequency in frequencies) {
      final path = Path();
      path.moveTo(0, centerY);

      for (double x = 0; x < size.width; x += step) {
        final y = centerY +
            sin((x / size.width * 4 * pi) +
                    (animation.value * 2 * pi) * frequency) *
                amplitude;
        path.lineTo(x, y);
      }

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(VoiceWavePainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(VoiceWavePainter oldDelegate) => false;
}
