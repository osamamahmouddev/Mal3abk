import 'package:flutter/material.dart';

import '../../../../core/styles/app_colors.dart';

/// Top-down pitch: stripes, touchlines, halfway line, centre circle, both
/// penalty and goal areas, penalty spots and goals. Own goal at the bottom.
class TacticalPitchPainter extends CustomPainter {
  const TacticalPitchPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    const stripes = 10;
    for (var i = 0; i < stripes; i++) {
      canvas.drawRect(
        Rect.fromLTWH(0, h / stripes * i, w, h / stripes),
        Paint()
          ..color = i.isEven ? AppColors.pitchGreen : AppColors.pitchGreenDark,
      );
    }

    final line = Paint()
      ..color = AppColors.white.withValues(alpha: 0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final spot = Paint()..color = AppColors.white.withValues(alpha: 0.8);
    final m = w * 0.04;
    final field = Rect.fromLTRB(m, m, w - m, h - m);

    canvas
      ..drawRect(field, line)
      ..drawLine(Offset(field.left, h / 2), Offset(field.right, h / 2), line)
      ..drawCircle(Offset(w / 2, h / 2), w * 0.14, line)
      ..drawCircle(Offset(w / 2, h / 2), 3, spot);

    for (final top in [true, false]) {
      final y = top ? field.top : field.bottom;
      final dir = top ? 1.0 : -1.0;
      final boxW = field.width * 0.6;
      final boxH = field.height * 0.16;
      final smallW = field.width * 0.3;
      final smallH = field.height * 0.06;
      final goalW = field.width * 0.16;
      canvas
        ..drawRect(
          Rect.fromLTWH(w / 2 - boxW / 2, top ? y : y - boxH, boxW, boxH),
          line,
        )
        ..drawRect(
          Rect.fromLTWH(
            w / 2 - smallW / 2,
            top ? y : y - smallH,
            smallW,
            smallH,
          ),
          line,
        )
        ..drawCircle(Offset(w / 2, y + dir * boxH * 0.72), 3, spot)
        ..drawLine(
          Offset(w / 2 - goalW / 2, y - dir * 4),
          Offset(w / 2 + goalW / 2, y - dir * 4),
          line..strokeWidth = 4,
        );
      line.strokeWidth = 2;
    }
  }

  @override
  bool shouldRepaint(covariant TacticalPitchPainter oldDelegate) => false;
}
