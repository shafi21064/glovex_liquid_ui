/// Spacing scale (use multiples of 4).
class LiquidSpacing {
  const LiquidSpacing._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
}

/// Radius scale.
class LiquidRadius {
  const LiquidRadius._();

  static const double sm = 4;
  static const double md = 8;
  static const double lg = 16;
  static const double xl = 24;
  static const double pill = 9999;
}

/// Glass / blur tokens used by glassmorphism widgets.
class LiquidGlassEffectTokens {
  const LiquidGlassEffectTokens({
    this.blurSigma = 14,
    this.opacity = 0.04,
    this.borderOpacity = 0.28,
    this.highlightOpacity = 0.12,
    this.shadowOpacity = 0.12,
    this.borderWidth = 1.2,
  });

  final double blurSigma;
  final double opacity;
  final double borderOpacity;
  final double highlightOpacity;
  final double shadowOpacity;
  final double borderWidth;
}
