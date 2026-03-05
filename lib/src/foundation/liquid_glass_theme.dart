import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

import 'glass_tokens.dart';

/// Blur rendering strategy for glass widgets.
enum LiquidBlurMode { real, fake }

/// Theme extension that centralizes visual tokens for liquid-glass widgets.
///
/// Add an instance to `ThemeData.extensions` and read it via
/// `context.liquidGlassTheme`.
@immutable
class LiquidGlassTheme extends ThemeExtension<LiquidGlassTheme> {
  /// Creates a fully configured liquid-glass theme token set.
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

  /// Base tint color mixed into glass backgrounds.
  final Color tintColor;

  /// Foreground/highlight color used for text and reflections.
  final Color highlightColor;

  /// Border color used around glass surfaces.
  final Color borderColor;

  /// Shadow color used for depth effects.
  final Color shadowColor;

  /// Default corner radius for card-like widgets.
  final BorderRadius cardRadius;

  /// Default corner radius for pill/capsule widgets.
  final BorderRadius capsuleRadius;

  /// Global on/off switch for blur usage.
  final bool enableBlur;

  /// Global blur rendering mode.
  final LiquidBlurMode blurMode;

  /// Sigma value used when real blur is enabled.
  final double blurSigma;

  /// Default border stroke width.
  final double borderWidth;

  /// Default tint alpha multiplier.
  final double tintOpacity;

  /// Default highlight alpha multiplier.
  final double highlightOpacity;

  /// Default shadow alpha multiplier.
  final double shadowOpacity;

  /// Preconfigured light appearance.
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

  /// Preconfigured dark appearance.
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

  /// Resolves the nearest [LiquidGlassTheme] from context, or returns
  /// a light/dark fallback if no extension is registered.
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
  /// Shortcut to read [LiquidGlassTheme.of].
  LiquidGlassTheme get liquidGlassTheme => LiquidGlassTheme.of(this);
}
