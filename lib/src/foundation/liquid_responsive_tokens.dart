class LiquidAdaptiveDouble {
  const LiquidAdaptiveDouble({
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

  final double mobile;
  final double tablet;
  final double desktop;
}

class LiquidResponsiveTokens {
  const LiquidResponsiveTokens._();

  static const double textScaleMobile = 1.0;
  static const double textScaleTablet = 1.08;
  static const double textScaleDesktop = 1.15;

  static const LiquidAdaptiveDouble buttonPaddingHorizontal =
      LiquidAdaptiveDouble(
    mobile: 14,
    tablet: 16,
    desktop: 18,
  );
  static const LiquidAdaptiveDouble buttonPaddingVertical =
      LiquidAdaptiveDouble(
    mobile: 10,
    tablet: 12,
    desktop: 14,
  );

  static const LiquidAdaptiveDouble inputPaddingHorizontal =
      LiquidAdaptiveDouble(
    mobile: 10,
    tablet: 12,
    desktop: 14,
  );
  static const LiquidAdaptiveDouble inputPaddingVertical = LiquidAdaptiveDouble(
    mobile: 6,
    tablet: 7,
    desktop: 8,
  );

  static const LiquidAdaptiveDouble listTilePaddingHorizontal =
      LiquidAdaptiveDouble(
    mobile: 10,
    tablet: 12,
    desktop: 14,
  );
  static const LiquidAdaptiveDouble listTilePaddingVertical =
      LiquidAdaptiveDouble(
    mobile: 9,
    tablet: 10,
    desktop: 12,
  );

  static const LiquidAdaptiveDouble sectionContentGap = LiquidAdaptiveDouble(
    mobile: 10,
    tablet: 12,
    desktop: 14,
  );
}
