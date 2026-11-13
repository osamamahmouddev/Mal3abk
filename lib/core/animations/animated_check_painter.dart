import 'package:flutter/widgets.dart';

/// Draws a ring and a check mark, both growing with [progress] (0 to 1): the
/// ring first, then the check.
class AnimatedCheckPainter extends CustomPainter {
  const AnimatedCheckPainter({
    required this.progress,
    required this.color,
    this.strokeWidth = 4,
  });

  final double progress;
  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final inset = strokeWidth / 2;
    final ring = Rect.fromLTWH(
      inset,
      inset,
      size.width - strokeWidth,
      size.height - strokeWidth,
    );
    final ringProgress = (progress / 0.6).clamp(0.0, 1.0);
    canvas.drawArc(ring, -1.5708, 6.28318 * ringProgress, false, paint);

    final checkProgress = ((progress - 0.55) / 0.45).clamp(0.0, 1.0);
    if (checkProgress == 0) return;

    final w = size.width;
    final h = size.height;
    final start = Offset(w * 0.28, h * 0.52);
    final middle = Offset(w * 0.44, h * 0.67);
    final end = Offset(w * 0.73, h * 0.36);

    final firstLeg = (checkProgress / 0.4).clamp(0.0, 1.0);
    final secondLeg = ((checkProgress - 0.4) / 0.6).clamp(0.0, 1.0);

    final path = Path()
      ..moveTo(start.dx, start.dy)
      ..lineTo(
        start.dx + (middle.dx - start.dx) * firstLeg,
        start.dy + (middle.dy - start.dy) * firstLeg,
      );
    if (secondLeg > 0) {
      path.lineTo(
        middle.dx + (end.dx - middle.dx) * secondLeg,
        middle.dy + (end.dy - middle.dy) * secondLeg,
      );
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(AnimatedCheckPainter old) =>
      old.progress != progress ||
      old.color != color ||
      old.strokeWidth != strokeWidth;
}
