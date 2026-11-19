import 'dart:ui' show PathMetric;

import 'package:flutter/widgets.dart';

/// A pen stroke crossing out text, drawn by hand: it leaves the trailing
/// edge (the right in Arabic), dips a little over the middle and ends past
/// the leading edge. [progress] 0 draws nothing, 1 the whole stroke.
class CrossOutStrokePainter extends CustomPainter {
  const CrossOutStrokePainter({
    required this.progress,
    required this.color,
    required this.textDirection,
    this.strokeWidth = 2,
  });

  final double progress;
  final Color color;
  final TextDirection textDirection;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0) return;
    final rtl = textDirection == TextDirection.rtl;
    final w = size.width;
    final h = size.height;
    // A slight overshoot past the text on both ends, as a quick pen does.
    final from = Offset(rtl ? w + 3 : -3, h * 0.58);
    final to = Offset(rtl ? -3 : w + 3, h * 0.5);
    final path = Path()
      ..moveTo(from.dx, from.dy)
      ..quadraticBezierTo(w / 2, h * 0.38, to.dx, to.dy);

    final PathMetric metric = path.computeMetrics().first;
    final drawn = metric.extractPath(0, metric.length * progress.clamp(0, 1));
    canvas.drawPath(
      drawn,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(CrossOutStrokePainter old) =>
      old.progress != progress ||
      old.color != color ||
      old.textDirection != textDirection ||
      old.strokeWidth != strokeWidth;
}

/// A thin ring leaving a tile's border and fading: "this just changed".
/// [progress] 0 sits on the border, 1 has spread [spread] and vanished.
class LivePulsePainter extends CustomPainter {
  const LivePulsePainter({
    required this.progress,
    required this.color,
    required this.radius,
    this.spread = 9,
  });

  final double progress;
  final Color color;
  final double radius;
  final double spread;

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0 || progress >= 1) return;
    final grow = spread * progress;
    final rect = RRect.fromRectAndRadius(
      (Offset.zero & size).inflate(grow),
      Radius.circular(radius + grow),
    );
    canvas.drawRRect(
      rect,
      Paint()
        ..color = color.withValues(alpha: 0.55 * (1 - progress))
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2 * (1 - progress) + 0.5,
    );
  }

  @override
  bool shouldRepaint(LivePulsePainter old) =>
      old.progress != progress || old.color != color || old.radius != radius;
}
