import 'dart:ui';

import 'package:flutter/material.dart';

import '../foundation/liquid_glass_theme.dart';

class LiquidGlassSurface extends StatelessWidget {
  const LiquidGlassSurface({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius,
    this.enableBlur,
    this.blurMode,
    this.blurSigma,
    this.borderColor,
    this.backgroundColor,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final bool? enableBlur;
  final LiquidBlurMode? blurMode;
  final double? blurSigma;
  final Color? borderColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final theme = context.liquidGlassTheme;
    final resolvedRadius = borderRadius ?? theme.cardRadius;
    final resolvedBlur = blurSigma ?? theme.blurSigma;
    final resolvedEnableBlur = enableBlur ?? theme.enableBlur;
    final resolvedBlurMode = blurMode ?? theme.blurMode;
    final shouldUseRealBlur = resolvedEnableBlur &&
        resolvedBlurMode == LiquidBlurMode.real &&
        resolvedBlur > 0;
    final bg =
        backgroundColor ?? theme.tintColor.withValues(alpha: theme.tintOpacity);
    final border = borderColor ?? theme.borderColor;

    Widget content = child;
    if (padding != null) {
      content = Padding(padding: padding!, child: content);
    }

    final decorated = DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: resolvedRadius,
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withValues(alpha: theme.shadowOpacity),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: resolvedRadius,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: resolvedRadius,
            border: Border.all(
              color: border,
              width: theme.borderWidth,
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                theme.highlightColor.withValues(alpha: theme.highlightOpacity),
                bg,
                Colors.white.withValues(alpha: 0.01),
              ],
            ),
          ),
          child: shouldUseRealBlur
              ? BackdropFilter(
                  filter:
                      ImageFilter.blur(sigmaX: resolvedBlur, sigmaY: resolvedBlur),
                  child: content,
                )
              : content,
        ),
      ),
    );

    return RepaintBoundary(child: decorated);
  }
}
