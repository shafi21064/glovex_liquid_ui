import 'dart:ui';

import 'package:flutter/material.dart';

import '../foundation/glass_tokens.dart';

class LiquidGlassSurface extends StatelessWidget {
  const LiquidGlassSurface({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius = LiquidGlassTokens.cardRadius,
    this.blurSigma = LiquidGlassTokens.blur,
    this.borderColor,
    this.backgroundColor,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final BorderRadius borderRadius;
  final double blurSigma;
  final Color? borderColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? Colors.white.withValues(alpha: LiquidGlassTokens.tintAlpha);
    final border = borderColor ?? Colors.white.withValues(alpha: 0.28);

    Widget content = child;
    if (padding != null) {
      content = Padding(padding: padding!, child: content);
    }

    return ClipRRect(
      borderRadius: borderRadius,
      child: Stack(
        children: [
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
              child: const SizedBox.expand(),
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withValues(alpha: LiquidGlassTokens.highlightAlpha),
                    bg,
                    Colors.white.withValues(alpha: 0.01),
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                border: Border.all(color: border, width: LiquidGlassTokens.borderWidth),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: LiquidGlassTokens.shadowAlpha),
                    blurRadius: 18,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: content,
            ),
          ),
        ],
      ),
    );
  }
}
