import 'glass_tokens.dart';

class LiquidTextScaleTokens {
  const LiquidTextScaleTokens._();

  static const double textScaleMobile = 1.0;
  static const double textScaleTablet = 1.08;
  static const double textScaleDesktop = 1.15;
}

/// Centralized sizing constants with a global scale factor.
abstract final class LiquidSizes {
  static double scale = 1.0;

  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 1200;

  static void updateScale(double width) {
    if (width < mobileBreakpoint) {
      scale = 1.0;
    } else if (width < tabletBreakpoint) {
      scale = 1.2;
    } else {
      scale = 1.4;
    }
  }

  static double get pagePadding => LiquidSpacing.lg * scale;
  static double get formMaxWidth => 400 * scale;

  static double get spacingXs => LiquidSpacing.xs * scale;
  static double get spacingSm => LiquidSpacing.sm * scale;
  static double get spacingMd => LiquidSpacing.md * scale;
  static double get spacingLg => LiquidSpacing.lg * scale;
  static double get spacingXl => LiquidSpacing.xl * scale;
  static double get spacingXxl => LiquidSpacing.xxl * scale;

  static double get iconSm => 16 * scale;
  static double get iconMd => 24 * scale;
  static double get iconLg => 48 * scale;
  static double get iconXl => 64 * scale;

  static double get titleSize => 24 * scale;
  static double get bodySize => 16 * scale;
  static double get labelSize => 14 * scale;
  static double get smallSize => 12 * scale;

  static double get loadingIndicatorSize => 20 * scale;
  static double get loadingStrokeWidth => 2 * scale;

  static double get buttonPaddingHorizontal => 14 * scale;
  static double get buttonPaddingVertical => 10 * scale;

  static double get inputPaddingHorizontal => 10 * scale;
  static double get inputPaddingVertical => 6 * scale;

  static double get listTilePaddingHorizontal => 10 * scale;
  static double get listTilePaddingVertical => 9 * scale;
  static double get sectionContentGap => 10 * scale;

  // Bottom navigation defaults
  static double get bottomNavHeight => 74 * scale;
  static double get bottomNavMarginHorizontal => 14 * scale;
  static double get bottomNavMarginBottom => 14 * scale;
  
  // Icon button and control sizes
  static double get iconButtonSize => 42 * scale;
  static double get radioSize => 22 * scale;
  static double get radioInnerSize => 10 * scale;

  static double get radiusSm => LiquidRadius.sm * scale;
  static double get radiusMd => LiquidRadius.md * scale;
  static double get radiusLg => LiquidRadius.lg * scale;
  static double get radiusXl => LiquidRadius.xl * scale;
}
