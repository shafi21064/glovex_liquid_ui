import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

import 'glass_tokens.dart';

enum LiquidBlurMode { real, fake }

@immutable
class LiquidGlassTheme extends ThemeExtension<LiquidGlassTheme> {
  const LiquidGlassTheme({
    required this.tintColor,
    required this.highlightColor,
    required this.borderColor,
    required this.shadowColor,
    required this.cardRadius,
    required this.capsuleRadius,
    required this.enableBlur,
    required this.blurMode,
    required this.blurSigma,
    required this.borderWidth,
    required this.tintOpacity,
    required this.highlightOpacity,
    required this.shadowOpacity,
  });

  final Color tintColor;
  final Color highlightColor;
  final Color borderColor;
  final Color shadowColor;

  final BorderRadius cardRadius;
  final BorderRadius capsuleRadius;

  final bool enableBlur;
  final LiquidBlurMode blurMode;
  final double blurSigma;
  final double borderWidth;
  final double tintOpacity;
  final double highlightOpacity;
  final double shadowOpacity;

  factory LiquidGlassTheme.light({Color brandTint = Colors.white}) {
    return LiquidGlassTheme(
      tintColor: brandTint,
      highlightColor: Colors.white,
      borderColor: Colors.white.withValues(alpha: 0.30),
      shadowColor: Colors.black,
      cardRadius: const BorderRadius.all(Radius.circular(LiquidRadius.xl)),
      capsuleRadius: const BorderRadius.all(Radius.circular(LiquidRadius.pill)),
      enableBlur: true,
      blurMode: LiquidBlurMode.real,
      blurSigma: 14,
      borderWidth: 1.2,
      tintOpacity: 0.06,
      highlightOpacity: 0.18,
      shadowOpacity: 0.10,
    );
  }

  factory LiquidGlassTheme.dark({Color brandTint = Colors.white}) {
    return LiquidGlassTheme(
      tintColor: brandTint,
      highlightColor: Colors.white,
      borderColor: Colors.white.withValues(alpha: 0.28),
      shadowColor: Colors.black,
      cardRadius: const BorderRadius.all(Radius.circular(LiquidRadius.xl)),
      capsuleRadius: const BorderRadius.all(Radius.circular(LiquidRadius.pill)),
      enableBlur: true,
      blurMode: LiquidBlurMode.real,
      blurSigma: 14,
      borderWidth: 1.2,
      tintOpacity: 0.04,
      highlightOpacity: 0.12,
      shadowOpacity: 0.12,
    );
  }

  static LiquidGlassTheme of(BuildContext context) {
    final theme = Theme.of(context).extension<LiquidGlassTheme>();
    if (theme != null) return theme;

    final brightness = MediaQuery.maybePlatformBrightnessOf(context);
    if (brightness == Brightness.light) {
      return LiquidGlassTheme.light();
    }
    return LiquidGlassTheme.dark();
  }

  @override
  LiquidGlassTheme copyWith({
    Color? tintColor,
    Color? highlightColor,
    Color? borderColor,
    Color? shadowColor,
    BorderRadius? cardRadius,
    BorderRadius? capsuleRadius,
    bool? enableBlur,
    LiquidBlurMode? blurMode,
    double? blurSigma,
    double? borderWidth,
    double? tintOpacity,
    double? highlightOpacity,
    double? shadowOpacity,
  }) {
    return LiquidGlassTheme(
      tintColor: tintColor ?? this.tintColor,
      highlightColor: highlightColor ?? this.highlightColor,
      borderColor: borderColor ?? this.borderColor,
      shadowColor: shadowColor ?? this.shadowColor,
      cardRadius: cardRadius ?? this.cardRadius,
      capsuleRadius: capsuleRadius ?? this.capsuleRadius,
      enableBlur: enableBlur ?? this.enableBlur,
      blurMode: blurMode ?? this.blurMode,
      blurSigma: blurSigma ?? this.blurSigma,
      borderWidth: borderWidth ?? this.borderWidth,
      tintOpacity: tintOpacity ?? this.tintOpacity,
      highlightOpacity: highlightOpacity ?? this.highlightOpacity,
      shadowOpacity: shadowOpacity ?? this.shadowOpacity,
    );
  }

  @override
  LiquidGlassTheme lerp(ThemeExtension<LiquidGlassTheme>? other, double t) {
    if (other is! LiquidGlassTheme) return this;
    return LiquidGlassTheme(
      tintColor: Color.lerp(tintColor, other.tintColor, t)!,
      highlightColor: Color.lerp(highlightColor, other.highlightColor, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      shadowColor: Color.lerp(shadowColor, other.shadowColor, t)!,
      cardRadius: BorderRadius.lerp(cardRadius, other.cardRadius, t)!,
      capsuleRadius: BorderRadius.lerp(capsuleRadius, other.capsuleRadius, t)!,
      enableBlur: t < 0.5 ? enableBlur : other.enableBlur,
      blurMode: t < 0.5 ? blurMode : other.blurMode,
      blurSigma: lerpDouble(blurSigma, other.blurSigma, t)!,
      borderWidth: lerpDouble(borderWidth, other.borderWidth, t)!,
      tintOpacity: lerpDouble(tintOpacity, other.tintOpacity, t)!,
      highlightOpacity:
          lerpDouble(highlightOpacity, other.highlightOpacity, t)!,
      shadowOpacity: lerpDouble(shadowOpacity, other.shadowOpacity, t)!,
    );
  }
}

extension LiquidGlassThemeContext on BuildContext {
  LiquidGlassTheme get liquidGlassTheme => LiquidGlassTheme.of(this);
}
