import 'package:flutter/widgets.dart';

import 'liquid_responsive_tokens.dart';

enum LiquidScreenType { mobile, tablet, desktop }

class LiquidBreakpoints {
  const LiquidBreakpoints._();

  static const double mobileMaxWidth = LiquidSizes.mobileBreakpoint - 1;
  static const double tabletMaxWidth = LiquidSizes.tabletBreakpoint - 1;
}

class LiquidResponsive {
  const LiquidResponsive._();

  static LiquidScreenType screenTypeOf(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width <= LiquidBreakpoints.mobileMaxWidth) {
      return LiquidScreenType.mobile;
    }
    if (width <= LiquidBreakpoints.tabletMaxWidth) {
      return LiquidScreenType.tablet;
    }
    return LiquidScreenType.desktop;
  }

  static T value<T>({
    required BuildContext context,
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    switch (screenTypeOf(context)) {
      case LiquidScreenType.mobile:
        return mobile;
      case LiquidScreenType.tablet:
        return tablet ?? mobile;
      case LiquidScreenType.desktop:
        return desktop ?? tablet ?? mobile;
    }
  }

  static double textScaleOf(
    BuildContext context, {
    double mobile = LiquidTextScaleTokens.textScaleMobile,
    double tablet = LiquidTextScaleTokens.textScaleTablet,
    double desktop = LiquidTextScaleTokens.textScaleDesktop,
  }) {
    return value(
      context: context,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }
}

extension LiquidResponsiveContext on BuildContext {
  LiquidScreenType get liquidScreenType => LiquidResponsive.screenTypeOf(this);

  bool get isLiquidMobile => liquidScreenType == LiquidScreenType.mobile;

  bool get isLiquidTablet => liquidScreenType == LiquidScreenType.tablet;

  bool get isLiquidDesktop => liquidScreenType == LiquidScreenType.desktop;

  T liquidValue<T>({
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    return LiquidResponsive.value(
      context: this,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }

  double liquidTextScale({
    double mobile = LiquidTextScaleTokens.textScaleMobile,
    double tablet = LiquidTextScaleTokens.textScaleTablet,
    double desktop = LiquidTextScaleTokens.textScaleDesktop,
  }) {
    return LiquidResponsive.textScaleOf(
      this,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }
}

extension LiquidResponsiveTextStyle on TextStyle {
  TextStyle liquidScale(
    BuildContext context, {
    double mobile = LiquidTextScaleTokens.textScaleMobile,
    double tablet = LiquidTextScaleTokens.textScaleTablet,
    double desktop = LiquidTextScaleTokens.textScaleDesktop,
  }) {
    final baseSize = fontSize;
    if (baseSize == null) return this;

    final scaled = baseSize *
        context.liquidTextScale(
          mobile: mobile,
          tablet: tablet,
          desktop: desktop,
        );

    return copyWith(fontSize: scaled);
  }
}

class LiquidResponsiveBuilder extends StatelessWidget {
  const LiquidResponsiveBuilder({super.key, required this.builder});

  final Widget Function(BuildContext context, LiquidScreenType screenType)
      builder;

  @override
  Widget build(BuildContext context) =>
      builder(context, context.liquidScreenType);
}
