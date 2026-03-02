import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

class LiquidGlassCard extends StatelessWidget {
  const LiquidGlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.borderRadius = const BorderRadius.all(Radius.circular(24)),
    this.height,
    this.width,
    this.margin,
    this.blur = 10,
    this.shrinkWrap = false,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final BorderRadius borderRadius;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? margin;
  final double blur;
  final bool shrinkWrap;

  @override
  Widget build(BuildContext context) {
    Widget card = DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 28 / 255),
            blurRadius: 84,
            spreadRadius: 2,
            offset: const Offset(0, 36),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 14 / 255),
            blurRadius: 34,
            spreadRadius: 0,
            offset: const Offset(0, 12),
          ),
          BoxShadow(
            color: Colors.white.withValues(alpha: 16 / 255),
            blurRadius: 22,
            spreadRadius: -5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Stack(
          fit: StackFit.passthrough,
          children: [
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
                child: const SizedBox.shrink(),
              ),
            ),
            Container(
              padding: padding,
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withValues(alpha: 8 / 255),
                    Colors.white.withValues(alpha: 2 / 255),
                  ],
                ),
              ),
              child: child,
            ),
            Positioned.fill(
              child: IgnorePointer(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: borderRadius,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.center,
                      colors: [
                        Colors.white.withValues(alpha: 20 / 255),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: IgnorePointer(
                child: CustomPaint(
                  painter: _LiquidBorderPainter(
                    borderRadius: borderRadius,
                    strokeWidth: 1.7,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    if (width != null || height != null || margin != null) {
      card = Container(
        width: width,
        height: height,
        margin: margin,
        child: card,
      );
    }

    if (shrinkWrap) {
      return IntrinsicWidth(child: card);
    }

    return card;
  }
}

class _LiquidBorderPainter extends CustomPainter {
  const _LiquidBorderPainter({
    required this.borderRadius,
    required this.strokeWidth,
  });

  final BorderRadius borderRadius;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rrect = borderRadius.toRRect(rect).deflate(strokeWidth / 2);

    // Align subtle opacity dips near diagonal corners regardless of aspect ratio.
    final topRightAngle = math.atan2(-size.height * 0.5, size.width * 0.5);
    final topRightTurn = ((topRightAngle / (2 * math.pi)) + 1) % 1;
    final rotationTurns = topRightTurn - 0.875;

    final borderShader = SweepGradient(
      center: Alignment.center,
      transform: GradientRotation(rotationTurns * 2 * math.pi),
      colors: [
        Colors.white.withValues(alpha: 78 / 255),
        Colors.white.withValues(alpha: 70 / 255),
        Colors.white.withValues(alpha: 62 / 255),
        Colors.white.withValues(alpha: 20 / 255),
        Colors.white.withValues(alpha: 1 / 255),
        Colors.white.withValues(alpha: 22 / 255),
        Colors.white.withValues(alpha: 64 / 255),
        Colors.white.withValues(alpha: 74 / 255),
        Colors.white.withValues(alpha: 62 / 255),
        Colors.white.withValues(alpha: 20 / 255),
        Colors.white.withValues(alpha: 1 / 255),
        Colors.white.withValues(alpha: 22 / 255),
        Colors.white.withValues(alpha: 78 / 255),
      ],
      stops: const [
        0.00,
        0.22,
        0.34,
        0.366,
        0.375,
        0.384,
        0.41,
        0.66,
        0.84,
        0.866,
        0.875,
        0.884,
        1.00,
      ],
    ).createShader(rect);

    final shadowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth + 1.1
      ..shader = borderShader
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2.0);

    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..shader = borderShader;

    canvas.drawRRect(rrect, shadowPaint);
    canvas.drawRRect(rrect, borderPaint);
  }

  @override
  bool shouldRepaint(covariant _LiquidBorderPainter oldDelegate) {
    return oldDelegate.borderRadius != borderRadius ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
