import 'package:flutter/material.dart';

import '../styles/app_colors.dart';

/// A smoothly spinning football (soccer ball) indicator themed with the
/// Mal3abk brand/logo colors. Used as the loading spinner inside buttons and
/// action surfaces.
class SpinningBallWidget extends StatefulWidget {
  const SpinningBallWidget({
    super.key,
    this.size = 24,
    this.ballColor,
    this.patternColor,
    this.duration = const Duration(milliseconds: 950),
  });

  final double size;
  final Color? ballColor;
  final Color? patternColor;
  final Duration duration;

  @override
  State<SpinningBallWidget> createState() => _SpinningBallWidgetState();
}

class _SpinningBallWidgetState extends State<SpinningBallWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: SizedBox.square(
        dimension: widget.size,
        child: CustomPaint(
          size: Size.square(widget.size),
          painter: _LogoBallPainter(
            ballColor: widget.ballColor ?? AppColors.white,
            patternColor: widget.patternColor ?? AppColors.brandRed,
          ),
        ),
      ),
    );
  }
}

class _LogoBallPainter extends CustomPainter {
  const _LogoBallPainter({
    required this.ballColor,
    required this.patternColor,
  });

  final Color ballColor;
  final Color patternColor;

  @override
  void paint(Canvas canvas, Size size) {
    final dimension = size.shortestSide;
    if (dimension <= 0) return;

    canvas.save();

    // Center and scale to the 92x92 coordinate space from the official logo SVG
    canvas.translate(size.width / 2, size.height / 2);
    final scale = dimension / 92.0;
    canvas.scale(scale, scale);
    canvas.translate(-256.0, -250.0);

    const center = Offset(256.0, 250.0);
    const radius = 46.0;

    // Clip to ball circle
    final clipPath = Path()
      ..addOval(Rect.fromCircle(center: center, radius: radius));
    canvas.clipPath(clipPath);

    // 1. Draw ball surface base
    final basePaint = Paint()
      ..color = ballColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, basePaint);

    final fillPaint = Paint()
      ..color = patternColor
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final strokePaint = Paint()
      ..color = patternColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true;

    final seamPaint = Paint()
      ..color = patternColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true;

    // 2. Central pentagon
    final centerPentagon = Path()
      ..moveTo(256.0, 236.2)
      ..lineTo(269.1, 245.7)
      ..lineTo(264.1, 261.2)
      ..lineTo(247.9, 261.2)
      ..lineTo(242.9, 245.7)
      ..close();
    canvas.drawPath(centerPentagon, fillPaint);
    canvas.drawPath(centerPentagon, strokePaint);

    // 3. Five connecting seams from central pentagon vertices
    canvas.drawLine(
      const Offset(256.0, 236.2),
      const Offset(256.0, 218.7),
      seamPaint,
    );
    canvas.drawLine(
      const Offset(269.1, 245.7),
      const Offset(290.1, 240.3),
      seamPaint,
    );
    canvas.drawLine(
      const Offset(264.1, 261.2),
      const Offset(277.1, 275.3),
      seamPaint,
    );
    canvas.drawLine(
      const Offset(247.9, 261.2),
      const Offset(234.9, 275.3),
      seamPaint,
    );
    canvas.drawLine(
      const Offset(242.9, 245.7),
      const Offset(221.9, 240.3),
      seamPaint,
    );

    // 4. Five perimeter polygons
    final p1 = Path()
      ..moveTo(276.3, 222.1)
      ..lineTo(271.8, 208.2)
      ..lineTo(283.6, 199.6)
      ..lineTo(295.4, 208.2)
      ..lineTo(290.9, 222.1)
      ..close();
    canvas.drawPath(p1, fillPaint);
    canvas.drawPath(p1, strokePaint);

    final p2 = Path()
      ..moveTo(288.8, 260.7)
      ..lineTo(300.6, 252.1)
      ..lineTo(312.4, 260.7)
      ..lineTo(307.9, 274.5)
      ..lineTo(293.3, 274.5)
      ..close();
    canvas.drawPath(p2, fillPaint);
    canvas.drawPath(p2, strokePaint);

    final p3 = Path()
      ..moveTo(256.0, 284.5)
      ..lineTo(267.8, 293.1)
      ..lineTo(263.3, 307.0)
      ..lineTo(248.7, 307.0)
      ..lineTo(244.2, 293.1)
      ..close();
    canvas.drawPath(p3, fillPaint);
    canvas.drawPath(p3, strokePaint);

    final p4 = Path()
      ..moveTo(223.2, 260.7)
      ..lineTo(218.7, 274.5)
      ..lineTo(204.1, 274.5)
      ..lineTo(199.6, 260.7)
      ..lineTo(211.4, 252.1)
      ..close();
    canvas.drawPath(p4, fillPaint);
    canvas.drawPath(p4, strokePaint);

    final p5 = Path()
      ..moveTo(235.7, 222.1)
      ..lineTo(221.1, 222.1)
      ..lineTo(216.6, 208.2)
      ..lineTo(228.4, 199.6)
      ..lineTo(240.2, 208.2)
      ..close();
    canvas.drawPath(p5, fillPaint);
    canvas.drawPath(p5, strokePaint);

    // 5. Subtle outer ring
    final borderPaint = Paint()
      ..color = patternColor.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawCircle(center, radius - 1, borderPaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _LogoBallPainter oldDelegate) =>
      oldDelegate.ballColor != ballColor ||
      oldDelegate.patternColor != patternColor;
}
