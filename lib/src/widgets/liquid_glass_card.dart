import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

import '../foundation/liquid_glass_theme.dart';

class LiquidGlassCard extends StatelessWidget {
  const LiquidGlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.borderRadius,
    this.height,
    this.width,
    this.margin,
    this.enableBlur,
    this.blurMode,
    this.blur,
    this.shrinkWrap = false,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final BorderRadius? borderRadius;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? margin;
  final bool? enableBlur;
  final LiquidBlurMode? blurMode;
  final double? blur;
  final bool shrinkWrap;

  @override
  Widget build(BuildContext context) {
    final theme = context.liquidGlassTheme;
    final resolvedRadius = borderRadius ?? theme.cardRadius;
    final resolvedBlur = blur ?? theme.blurSigma;
    final resolvedEnableBlur = enableBlur ?? theme.enableBlur;
    final resolvedBlurMode = blurMode ?? theme.blurMode;
    final shouldUseRealBlur = resolvedEnableBlur &&
        resolvedBlurMode == LiquidBlurMode.real &&
        resolvedBlur > 0;

    Widget card = RepaintBoundary(
      child: DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: resolvedRadius,
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withValues(alpha: theme.shadowOpacity),
            blurRadius: 84,
            spreadRadius: 2,
            offset: const Offset(0, 36),
          ),
          BoxShadow(
            color:
                theme.shadowColor.withValues(alpha: theme.shadowOpacity * 0.5),
            blurRadius: 34,
            spreadRadius: 0,
            offset: const Offset(0, 12),
          ),
          BoxShadow(
            color: theme.highlightColor
                .withValues(alpha: theme.highlightOpacity * 0.6),
            blurRadius: 22,
            spreadRadius: -5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: resolvedRadius,
        child: Stack(
          fit: StackFit.passthrough,
          children: [
            if (shouldUseRealBlur)
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: resolvedBlur,
                    sigmaY: resolvedBlur,
                  ),
                  child: const SizedBox.shrink(),
                ),
              ),
            Container(
              padding: padding,
              decoration: BoxDecoration(
                borderRadius: resolvedRadius,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    theme.highlightColor
                        .withValues(alpha: theme.highlightOpacity * 0.17),
                    theme.tintColor.withValues(
                      alpha: shouldUseRealBlur
                          ? theme.tintOpacity * 0.12
                          : theme.tintOpacity * 0.22,
                    ),
                  ],
                ),
              ),
              child: child,
            ),
            Positioned.fill(
              child: IgnorePointer(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: resolvedRadius,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.center,
                      colors: [
                        theme.highlightColor
                            .withValues(alpha: theme.highlightOpacity * 0.44),
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
                    borderRadius: resolvedRadius,
                    strokeWidth: theme.borderWidth + 0.5,
                    borderBaseColor: theme.borderColor,
                  ),
                ),
              ),
            ),
          ],
        ),
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
    required this.borderBaseColor,
  });

  final BorderRadius borderRadius;
  final double strokeWidth;
  final Color borderBaseColor;

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
        borderBaseColor.withValues(alpha: 78 / 255),
        borderBaseColor.withValues(alpha: 70 / 255),
        borderBaseColor.withValues(alpha: 62 / 255),
        borderBaseColor.withValues(alpha: 12 / 255),
        borderBaseColor.withValues(alpha: 0),
        borderBaseColor.withValues(alpha: 14 / 255),
        borderBaseColor.withValues(alpha: 64 / 255),
        borderBaseColor.withValues(alpha: 74 / 255),
        borderBaseColor.withValues(alpha: 62 / 255),
        borderBaseColor.withValues(alpha: 12 / 255),
        borderBaseColor.withValues(alpha: 0),
        borderBaseColor.withValues(alpha: 14 / 255),
        borderBaseColor.withValues(alpha: 78 / 255),
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
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.borderBaseColor != borderBaseColor;
  }
}
